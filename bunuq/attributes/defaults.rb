default.ram[:op]         = "/op"

default.bunuq[:dir]     = "#{node[:ram][:op]}/bunuq"
default.bunuq[:app]     = "#{node[:ram][:op]}/bunuq/app"
default.bunuq[:npm]     = "#{node[:ram][:op]}/bunuq/.node_modules"
default.bunuq[:npmrc]   = "#{node[:ram][:op]}/bunuq/.npmrc"
default.bunuq[:sv]      = "#{node[:bunuq][:dir]}/sv"

default.bunuq[:config]  = "#{node[:bunuq][:app]}/lib/config.js"

default.bunuq[:user]    = "bunuq"
default.bunuq[:git]     = "git://github.com/RAM9/bunuq.git"


