
include_recipe "java"

begin
  mysqlIp = private_recipe_ip("ndb","mysqld")
rescue
  mysqlIp = ""
  Chef::Log.warn "could not find the ndb server ip for HopsWorks!"
end
mysqlPort = node['ndb']['mysql_port']

user node['dela']['user'] do
  home "/home/#{node['dela']['user']}"
  system true
  shell "/bin/bash"
  manage_home true
  action :create
  not_if "getent passwd #{node['dela']['user']}"
  not_if { node['install']['external_users'].casecmp("true") == 0 }
end

group node['dela']['group'] do
  action :modify
  members ["#{node['dela']['user']}"]
  append true
  not_if { node['install']['external_users'].casecmp("true") == 0 }
end

group node['hops']['group'] do
  action :create
  not_if "getent group #{node['hops']['group']}"
  not_if { node['install']['external_users'].casecmp("true") == 0 }
end

group node['hops']['group'] do
  action :modify
  members ["#{node['dela']['user']}"]
  append true
  not_if { node['install']['external_users'].casecmp("true") == 0 }
end

directory node['dela']['home'] do
  owner node['dela']['user']
  group node['dela']['group']
  mode "750"
  recursive true
  action :create
end


directory "#{node['dela']['home']}/bin" do
  owner node['dela']['user']
  group node['dela']['group']
  mode "750"
  action :create
end

directory "#{node['dela']['home']}/conf" do
  owner node['dela']['user']
  group node['dela']['group']
  mode "750"
  action :create
end

directory "#{node['dela']['home']}/lib" do
  owner node['dela']['user']
  group node['dela']['group']
  mode "750"
  action :create
end

directory "#{node['dela']['home']}/report" do
  owner node['dela']['user']
  group node['dela']['group']
  mode "750"
  action :create
end

for script in node['dela']['scripts'] do
  template "#{node['dela']['home']}/bin/#{script}" do
    source "#{script}.erb"
    owner node['dela']['user']
    group node['dela']['group']
    mode "0750"
  end
end

url = node['dela']['url']

remote_file "#{node['dela']['home']}/lib/dela.jar" do
  source url
  retries 2
  owner node['dela']['user']
  group node['dela']['group']
  mode "0750"
  # TODO - checksum
  action :create_if_missing
end

link node['dela']['base_dir'] do
  owner node['dela']['user']
  group node['dela']['group']
  to node['dela']['home']
end

if node['dela']['id'].nil?
    node.override['dela']['id'] = Random.rand(100000)
end

if node['dela']['seed'].nil?
    node.override['dela']['seed'] = Random.rand(100000)
end

raise if node['dela']['stun_servers_ip'].size < 2 
stun1_ip = node['dela']['stun_servers_ip'][0]
stun2_ip = node['dela']['stun_servers_ip'][1]
stun1_id = node['dela']['stun_servers_id'][0]
stun2_id = node['dela']['stun_servers_id'][1]

case node['dela']['report']['type']
when "none"
  reportType = "none"
when "hops"
  reportType = "tracker"
  reportURI = "https://hops.site:51081/hops-site/api"
when "bbc5"
  reportType = "tracker"
  reportURI = "https://bbc5.sics.se:43080/hops-site/api"
when "other"
  reportType = "tracker"
  reportURI = node['dela']['report']['tracker']
when "disk"
  reportType = "disk"
  reportURI = "#{node['dela']['home']}/report"
else
  reportType = "none"
end

template "#{node['dela']['home']}/conf/application.conf" do
  source "application.conf.erb" 
  owner node['dela']['user']
  group node['dela']['group']
  mode 0700
  variables({ 
     :stun1_ip => stun1_ip,
     :stun2_ip => stun2_ip,
     :stun1_id => stun1_id,
     :stun2_id => stun2_id,
     :reportType => reportType,
     :reportURI => reportURI,
     :mysqlIp => mysqlIp,
     :mysqlPort => mysqlPort
  })
end

template "#{node['dela']['home']}/conf/config.yml" do
  source "config.yml.erb" 
  owner node['dela']['user']
  group node['dela']['group']
  mode 0750
end
