######## CHANGE ########
kagent_keys "/home/#{node.dela.user}" do
  cb_user "#{node.dela.user}"
  cb_group "#{node.dela.group}"
  cb_name "dela"
  cb_recipe "sshable"  
  action :get_publickey
end  