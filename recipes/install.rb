group node.dela.group do
  action :create
  not_if "getent group #{node.dela.group}"
end


user node.dela.user do
  action :create
  supports :manage_home => true
  home "/home/#{node.dela.user}"
  shell "/bin/bash"
  not_if "getent passwd #{node.dela.user}"
end

group node.dela.group do
  action :modify
  members ["#{node.dela.user}"]
  append true
end


private_ip = my_private_ip()
public_ip = my_public_ip()



