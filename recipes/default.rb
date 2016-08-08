url = node.dela.url

base_package_filename = File.basename(url)
cached_package_filename = "#{Chef::Config[:file_cache_path]}/#{base_package_filename}"

remote_file cached_package_filename do
  source url
  retries 2
  owner node.dela.user
  group node.dela.group
  mode "0755"
  # TODO - checksum
  action :create_if_missing
end


hin = "#{node.dela.home/.#{base_package_filename}_downloaded"
base_name = File.basename(base_package_filename, ".tar.gz")
bash 'extract-dela' do
  user "root"
  code <<-EOH
	tar -zxf #{cached_package_filename} -C #{node.dela.dir}
        chown -RL #{node.dela.user}:#{node.dela.group} #{node.dela.home}
        touch #{hin}
	EOH
  not_if { ::File.exist?("#{hin}") }
end

