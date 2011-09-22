default[:ram][:op]        = "/op"

default[:rsw][:dir]       = "#{node[:ram][:op]}/rsw"
default[:rsw][:app]       = "#{node[:ram][:op]}/rsw/app"
default[:rsw][:sv]        = "#{node[:rsw][:dir]}/sv"

default[:rsw][:command]   = "rvm exec bundle exec rake resque:scheduler"
default[:rsw][:user]      = "rsw"

