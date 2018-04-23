include_attribute "kagent"
include_attribute "ndb"
include_attribute "hops"

default['dela']['service']               = "dela"
default['dela']['group']                 = node['install']['user'].empty? ? "dela" : node['install']['user']
default['dela']['user']                  = node['install']['user'].empty? ? "dela" : node['install']['user']

default['dela']['public_ips']            = ['10.0.2.15']
default['dela']['private_ips']           = ['10.0.2.15']
default['dela']['systemd']               = "true"

default['dela']['version']               = "0.1.0"

default['dela']['url']                   = "#{node['download_url']}/dela/dela-#{node['dela']['version']}.jar"
default['dela']['dir']                   = node['install']['dir'].empty? ? "/srv/hops" : node['install']['dir']
default['dela']['base_dir']              = node['dela']['dir'] + "/dela"
default['dela']['home']                  = node['dela']['base_dir'] + "-" + node['dela']['version']
default['dela']['scripts']               = %w{ start.sh generic_start.sh stop.sh generic_stop.sh update_binaries.sh}
default['dela']['logs']                  = node['dela']['base_dir'] + "/dela.log"
default['dela']['pid_file']              = "/tmp/dela.pid"

default['dela']['log_level']             = "WARN"
default['dela']['stun_servers_ip']       = ["193.10.64.107","193.10.64.85"]
default['dela']['stun_servers_id']       = ["1","2"]
default['dela']['id']                    = nil
default['dela']['seed']                  = nil
default['dela']['stun_server_port1']     = 42002
default['dela']['stun_server_port2']     = 42003
default['dela']['http_port']             = 42000
default['dela']['port']                  = 42011
default['dela']['stun_port1']            = 42012
default['dela']['stun_port2']            = 42013
default['dela']['http_admin_port']       = 42014
default['dela']['hops']['storage']['type'] = "HDFS"
default['dela']['hops']['library']['type'] = "DISK"
default['dela']['report']['type']        = "hops"
default['dela']['report']['tracker']     = "https://hops.site:51081/hops-site/api"
