bash 'kill_running_interpreters' do
    user "root"
    ignore_failure true
    code <<-EOF
      service dela stop
    EOF
end


directory node['dela']['home'] do
  recursive true
  action :delete
  ignore_failure true
end

link node['dela']['base_dir'] do
  action :delete
  ignore_failure true
end


