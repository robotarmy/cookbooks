#
# Cookbook Name:: mongrel2
# Recipe:: default
#
# Copyleft BY-SA 2010, RAM9
# http://creativecommons.org/licenses/by-sa/3.0/
#
include_recipe 'sqlite'

package "uuid" do
  action :upgrade
end

package "uuid-dev" do
  action :upgrade
end

package "uuid-runtime" do
  action :upgrade
end

directory "#{node[:ram][:op]}/src"

remote_file "#{node[:ram][:op]}/src/zeromq-#{node[:zeromq][:version]}.tar.gz" do
  source   node[:zeromq][:source]
  checksum node[:zeromq][:checksum]
  action :create_if_missing
end

bash "Compling Zerqmq #{node[:zeromq][:version]} from source" do
  cwd "#{node[:ram][:op]}/src"
  code <<-EOH
   tar zxf zeromq-#{node[:zeromq][:version]}.tar.gz
   cd zeromq-#{node[:zeromq][:version]}
   ./configure
   make && make install
   ldconfig
   EOH
end

remote_file "#{node[:ram][:op]}/src/mongrel2-#{node[:mongrel][:version]}.tar.bz2" do
  source   node[:mongrel][:source]
  checksum node[:mongrel][:checksum]
  action :create_if_missing
end

bash "Compling Mongrel2 #{node[:mongrel][:version]} from source" do
  cwd "#{node[:ram][:op]}/src"
  code <<-EOH
   tar jxf mongrel2-#{node[:mongrel][:version]}.tar.bz2
   cd mongrel2-#{node[:mongrel][:version]}
   make
   make install
   EOH
end

