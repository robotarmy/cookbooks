default[:ram][:op]         = "/op"

default[:psybnc][:version] = "2.3.2-7"
default[:psybnc][:port]    = "56667"
default[:psybnc][:dir]     = "#{node[:ram][:op]}/psybnc"
default[:psybnc][:sv]      = "#{node[:psybnc][:dir]}/sv"

default[:psybnc][:config]  = "#{node[:psybnc][:dir]}/psybnc.conf"

default[:psybnc][:user]    = "psybnc"

