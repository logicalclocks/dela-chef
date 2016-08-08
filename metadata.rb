name             'dela-chef'
maintainer       "dela-chef"
maintainer_email "jdowling@kth.se"
license          "Apache v2.0"
description      'Installs/Configures/Runs dela-chef'
version          "0.1"

recipe            "dela-chef::install", "Experiment setup for dela-chef"
recipe            "dela-chef::experiment",  "configFile=; Experiment name: experiment"


depends "kagent"



%w{ ubuntu debian rhel centos }.each do |os|
  supports os
end



attribute "dela-chef/group",
:description => "group parameter value",
:type => "string"

attribute "dela-chef/user",
:description => "user parameter value",
:type => "string"


