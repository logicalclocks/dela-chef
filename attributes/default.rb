default.dela.service			   = "dela"
default.dela.group                 = "dela"
default.dela.user                  = "dela"

default.dela.public_ips            = ['10.0.2.15']
default.dela.private_ips           = ['10.0.2.15']
default.dela.systemd               = "true"

default.dela.version               = "0.0.2-SNAPSHOT"

default.dela.url                   = "http://snurran.sics.se/hops/dela/dela-#{node.dela.version}.jar"
default.dela.dir                   = "/srv"
default.dela.base_dir              = node.dela.dir + "/dela"
default.dela.home                  = node.dela.base_dir + "-" + node.dela.version
default.dela.scripts               = %w{ start.sh generic_start.sh stop.sh generic_stop.sh update_binaries.sh}
default.dela.logs                  = node.dela.base_dir + "/dela.log"
default.dela.pid_file              = "/tmp/dela.pid"

default.dela.log_level             = "WARN"
default.dela.stun_servers_ip       = ["192.0.0.101","192.0.0.102"]
default.dela.stun_servers_id       = ["1","2"]
default.dela.id                    = nil
default.dela.seed                  = nil
default.dela.stun_server_port1     = 42002
default.dela.stun_server_port2     = 42003
default.dela.http_port		   	   = 42000
default.dela.port                  = 42001
default.dela.stun_port1            = 42002
default.dela.stun_port2            = 42003
default.dela.http_admin_port	   = 42004
default.dela.hops.baseEndpoint 	   = "DISK"

