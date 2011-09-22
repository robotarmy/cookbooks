default.ram[:op]         = "/op"

default.fluffy[:dir]     = "#{node[:ram][:op]}/fluffy"
default.fluffy[:app]     = "#{node[:ram][:op]}/fluffy/app"
default.fluffy[:npm]     = "#{node[:ram][:op]}/fluffy/.node_modules"
default.fluffy[:npmrc]   = "#{node[:ram][:op]}/fluffy/.npmrc"
default.fluffy[:sv]      = "#{node[:fluffy][:dir]}/sv"

default.fluffy[:config]  = "#{node[:fluffy][:app]}/lib/config.js"

default.fluffy][:user]    = "fluffy"
default.fluffy][:git]     = "git://github.com/RAM9/fluffy.git"


