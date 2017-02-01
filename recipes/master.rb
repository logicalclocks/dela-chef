include_recipe "dela::default"

homedir = "/home/#{node.dela.user}"
Chef::Log.info "Home dir is #{homedir}. Generating ssh keys..."

kagent_keys "#{homedir}" do
  cb_user node.dela.user
  cb_group node.dela.group
  action :generate  
end  


kagent_keys "#{homedir}" do
  cb_user node.dela.user
  cb_group node.dela.group
  cb_name "dela"
  cb_recipe "master"  
  action :return_publickey
end  
