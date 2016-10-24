include_recipe "dela::_default"

homedir = "/home/#{node.dela.user}"

kagent_keys "#{homedir}" do
  cb_user "#{node.dela.user}"
  cb_group "#{node.dela.group}"
  cb_name "dela"
  cb_recipe "master"  
  action :get_publickey
end  
