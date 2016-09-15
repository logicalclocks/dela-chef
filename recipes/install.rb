
include_recipe "java"

user node.dela.user do

  home "/home/#{node.dela.user}"
  system true
  shell "/bin/bash"
  manage_home true
  action :create
  not_if "getent passwd #{node.dela.user}"
end

group node.dela.group do
  action :modify
  members ["#{node.dela.user}"]
  append true
end

directory "#{node.dela.home}" do
  owner node.dela.user
  group node.dela.group
  mode "775"
  action :create
  recursive true
  not_if { File.directory?("#{node.dela.home}") }
end


directory "#{node.dela.home}/bin" do
  owner node.dela.user
  group node.dela.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.dela.home}/bin") }
end

directory "#{node.dela.home}/conf" do
  owner node.dela.user
  group node.dela.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.dela.home}/conf") }
end

directory "#{node.dela.home}/lib" do
  owner node.dela.user
  group node.dela.group
  mode "775"
  action :create
  not_if { File.directory?("#{node.dela.home}/lib") }
end

for script in node.dela.scripts do
  template "#{node.dela.home}/bin/#{script}" do
    source "#{script}.erb"
    owner node.dela.user
    group node.dela.group
    mode 0750
  end
end

url = node.dela.url

remote_file "#{node.dela.home}/lib/dela.jar" do
  source url
  retries 2
  owner node.dela.user
  group node.dela.group
  mode "0755"
  # TODO - checksum
  action :create_if_missing
end

link node.dela.base_dir do
  owner node.dela.user
  group node.dela.group
  to node.dela.home
end

