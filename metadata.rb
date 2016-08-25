name             "dela"
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs dela'
version          "0.1.0"

recipe            "dela::install", "Install dela binaries"
recipe            "dela::default",  "Configures and starts the dela server"
recipe            "dela::purge",  "Stops the dela server and deletes all its files"


%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end

depends "kagent"
depends "java"

attribute "dela/group",
:description => "group parameter value",
:type => "string"

attribute "dela/user",
:description => "user parameter value",
:type => "string"

attribute "java/jdk_version",
:description => "Version of Java to use (e.g., '7' or '8')",
:type => "string"

attribute "dela/id",
:description => "id for the dela instance. Randomly generated, but can be ovverriden here.",
:type => "string"

attribute "dela/seed",
:description => "seed for the dela instance. Randomly generated, but can be ovverriden here.",
:type => "string"

attribute "dela/log_level",
:description => "Default: WARN. Can be INFO or DEBUG or TRACE or ERROR.",
:type => "string"

attribute "dela/stun_port1",
:description => "1st port for stun server.",
:type => "string"

attribute "dela/stun_port2",
:description => "2nd port for stun server.",
:type => "string"

attribute "dela/stun_client_port1",
:description => "1st Client port used by stun client in Dela.",
:type => "string"

attribute "dela/stun_client_port2",
:description => "2nd Client port used by stun client in Dela.",
:type => "string"
