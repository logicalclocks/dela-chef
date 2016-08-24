
raise if node.dela.stun_servers.size < 2 
stun1_ip = node.dela.stun_servers[0]
stun2_ip = node.dela.stun_servers[1]

if node.dela.id.nil?
    node.override.dela.id = Time.now.getutc.to_i
end

if node.dela.seed.nil?
    node.override.dela.seed = Random.rand(100000)
end


template "#{node.dela.home}/conf/application.conf" do
  source "application.conf.erb" 
  owner node.dela.user
  group node.dela.group
  mode 0750
  variables({ 
     :stun1_ip => stun1_ip,
     :stun2_ip => stun2_ip
  })
end

template "#{node.dela.home}/conf/config.yml.erb" do
  source "application.conf.erb" 
  owner node.dela.user
  group node.dela.group
  mode 0750
  variables({ 
     :stun1_ip => stun1_ip,
     :stun1_ip => stun1_ip
  })
end


service_name="dela"

if node.livy.systemd == "true"

  service service_name do
    provider Chef::Provider::Service::Systemd
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  case node.platform_family
  when "rhel"
    systemd_script = "/usr/lib/systemd/system/#{service_name}.service" 
  else
    systemd_script = "/lib/systemd/system/#{service_name}.service"
  end

  template systemd_script do
    source "#{service_name}.service.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :start, resources(:service => service_name), :immediately
  end

  hadoop_spark_start "reload_#{service_name}" do
    action :systemd_reload
  end  

else #sysv

  service service_name do
    provider Chef::Provider::Service::Init::Debian
    supports :restart => true, :stop => true, :start => true, :status => true
    action :nothing
  end

  template "/etc/init.d/#{service_name}" do
    source "#{service_name}.erb"
    owner "root"
    group "root"
    mode 0754
    notifies :enable, resources(:service => service_name)
    notifies :restart, resources(:service => service_name), :immediately
  end

end


#if node.kagent.enabled == "true" 
   kagent_config service_name do
     service service_name
     start_script "service #{service_name} start"
     stop_script "service #{service_name} stop"
     log_file "#{node.livy.home}/livy.log"
     pid_file "/tmp/livy.pid"
   end
#end
