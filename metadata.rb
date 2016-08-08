name             'dela'
maintainer       "Jim Dowling"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs dela'
version          "0.1"

recipe            "dela-chef::install", "Experiment setup for dela-chef"
recipe            "dela-chef::default",  "configFile=; Experiment name: experiment"


depends "kagent"



%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end



attribute "dela/group",
:description => "group parameter value",
:type => "string"

attribute "dela/user",
:description => "user parameter value",
:type => "string"


