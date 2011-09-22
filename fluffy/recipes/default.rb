#
# Cookbook Name:: fluffy
# Recipe:: default
#
# Copyright 2010, RAM9, Curtis Schofield 
#
# All rights reserved - Redistribute at your own peril
#
#
include_recipe "nodejs::npm"


user node[:fluffy][:user] do
  comment "fluffy daemon"
	home node[:fluffy][:dir]
  shell "/bin/zsh"
	not_if 'id fluffy'
end

[ node[:fluffy][:dir],
  node[:fluffy][:app]  ].each do |dir|
  directory dir do
    owner node[:fluffy][:user]
    group node[:fluffy][:user]
    mode 0755
    recursive true
  end
end

file "#{node[:fluffy][:dir]}/.zshrc" do
  action :create
end

[node[:fluffy][:npm]].each do |dir| 
	directory dir do
		owner node[:fluffy][:user]
		group node[:fluffy][:user]
		mode 0755
		recursive true
	end
end

git "Sync Master fluffy" do
	destination node[:fluffy][:app]
  repository node[:fluffy][:git]
	reference "master"
	user node[:fluffy][:user]
	group node[:fluffy][:user]
  action :sync
end

template node[:fluffy][:npmrc] do
  source "dot.npmrc.erb"
  owner node[:fluffy][:user]
  group node[:fluffy][:user]
end

template node[:fluffy][:config] do
  source "config.js.erb"
  owner node[:fluffy][:user]
  group node[:fluffy][:user]
end

bash "install fluffy nodejs dependencies" do
	# run as user - in login shell 
	# so npm will read .npmrc
	code <<-EOH
	su - #{node[:fluffy][:user]} -c '
  npm install node-http-proxy
	EOH
end


daemontools_service "fluffy" do
  template "fluffy"
  directory node[:fluffy][:sv]
  owner node[:fluffy][:user]
  group node[:fluffy][:user]
  log true 
	env 'NODE_PATH' => node[:fluffy][:npm]
  supports :start   => true,
           :stop    => true,
           :restart => true
  action [:kill]
end


