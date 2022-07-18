name             "dela"
maintainer       "Alex Ormenisan"
maintainer_email "aaor@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs dela'
version          "3.0.0"

recipe            "dela::install",      "Install dela binaries"
recipe            "dela::default",      "Basic dela recipe"
recipe            "dela::purge",        "Stops the dela server and deletes all its files"


%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

depends "java", '~> 7.0.0'
depends 'kagent'
depends 'conda'
depends 'hops'

##### karamel/chef
attribute "java/jdk_version",
          :description => "Version of Java to use (e.g., '7' or '8')",
          :type => "string"

attribute "kagent/enabled",
          :description => "'true' by default",
          :type => "string"

##### install
attribute "dela/version",
          :description => "dela-transfer version",
          :type => "string"

attribute "dela/url",
          :description => "dela-transfer download url",
          :type => "string"

attribute "dela/group",
          :description => "group parameter value",
          :type => "string"

attribute "dela/user",
          :description => "user parameter value",
          :type => "string"


##### app
attribute "dela/log_level",
          :description => "Default: WARN. Can be INFO or DEBUG or TRACE or ERROR.",
          :type => "string"

attribute "dela/id",
          :description => "id for the dela instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "dela/seed",
          :description => "seed for the dela instance. Randomly generated, but can be ovverriden here.",
          :type => "string"

attribute "dela/stun_port1",
          :description => "1st Client port used by stun client in Dela.",
          :type => "string"

attribute "dela/stun_port2",
          :description => "2nd Client port used by stun client in Dela.",
          :type => "string"

attribute "dela/port",
	    :description => "Dela Client application port.",
	    :type => "string"

attribute "dela/stun_client_port2",
          :description => "2nd Client port used by stun client in Dela.",
          :type => "string"

attribute "dela/port",
          :description => "Dela Client application port.",
          :type => "string"

attribute "dela/http_port",
          :description => "Dela Client http port.",
	    :type => "string"

attribute "dela/stun_servers_ip",
          :description => "Dela Client stun connections(ips).",
          :type => "array"

attribute "dela/stun_servers_id",
          :description => "Dela Client stun connections(ids).",
          :type => "array"

attribute "dela/hops/storage/type",
          :description => "Dela Client storage type(HDFS/DISK).",
          :type => "string"
          
attribute "dela/hops/library/type",
          :description => "Dela Client library type(MYSQL/DISK).",
          :type => "string"

##### hopsworks
attribute "mysql/user",
          :description => "Mysql server username",
          :type => 'string',
          :required => "required"

attribute "mysql/password",
          :description => "MySql server password",
          :type => 'string',
          :required => "required"

attribute "install/dir",
          :description => "Base directory for dela installation (default: '/srv')",
          :type => 'string',
          :required => "required"

##### tracker
attribute "dela/report/type",
          :description => "Report type: none/disk/hops/bbc5/other. Default value is hops",
          :type => 'string'

attribute "dela/report/tracker",
          :description => "Tracker url when used in conjunction with type:other",
          :type => 'string'
