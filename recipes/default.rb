include_recipe "dela::base-default"

service_name=node['dela']['service']
if node['kagent']['enabled'] == "true" 
   kagent_config service_name do
     service service_name
     log_file "#{node['dela']['logs']}"
     config_file "#{node['dela']['home']}/conf/application.conf"
   end
end