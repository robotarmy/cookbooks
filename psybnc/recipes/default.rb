#
# Cookbook Name:: psybnc
# Recipe:: default
#
# Copyright 2010, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{node[:ram][:op]}/src"

user node[:psybnc][:user] do
  comment "psybnc daemon"
  system true
  shell "/bin/false"
end

directory node[:psybnc][:dir] do
  owner node[:psybnc][:user]
  group node[:psybnc][:user]
  mode 0755
  recursive true
end



remote_file "#{node[:ram][:op]}/src/psyBNC-#{node[:psybnc][:version]}.tar.gz" do
  source 'http://www.psybnc.at/download/beta/psyBNC-#{node[:psybnc][:version]}.tar.gz'
  checksum "c475f14b1b3a9280a123142e6e344dd8"
  code <<-EOH
  make
  cp psybnc #{node[:ram][:op]}/psybnc
  EOH
end

template node[:psybnc][:config] do
  source "psybnc.conf.erb"
end

daemontools_service "psybnc" do
  template "psybnc"
  directory node[:psybnc][:sv]
  owner node[:psybnc][:user]
  group node[:psybnc][:user]
  log true 
  supports :start   => true,
           :stop    => true,
           :restart => true
  action [:enable, :start]
  subscribes :restart, resources(:template => node[:psybnc][:config])
end

