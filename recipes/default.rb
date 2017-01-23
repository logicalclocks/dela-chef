include_recipe "dela::base-default"

if node.dela.id.nil?
    node.override.dela.id = Time.now.getutc.to_i
end

if node.dela.seed.nil?
    node.override.dela.seed = Random.rand(100000)
end

raise if node.dela.stun_servers_ip.size < 2 
stun1_ip = node.dela.stun_servers_ip[0]
stun2_ip = node.dela.stun_servers_ip[1]
stun1_id = node.dela.stun_servers_id[0]
stun2_id = node.dela.stun_servers_id[1]

template "#{node.dela.home}/conf/application.conf" do
  source "application.conf.erb" 
  owner node.dela.user
  group node.dela.group
  mode 0750
  variables({ 
     :stun1_ip => stun1_ip,
     :stun2_ip => stun2_ip,
     :stun1_id => stun1_id,
     :stun2_id => stun2_id
  })
end

template "#{node.dela.home}/conf/config.yml" do
  source "config.yml.erb" 
  owner node.dela.user
  group node.dela.group
  mode 0750
end

if node.kagent.enabled == "true" 
   kagent_config node.dela.service do
     service node.dela.service
     log_file "#{node.dela.logs}"
     config_file "#{node.dela.home}/conf/application.conf"
   end
end
