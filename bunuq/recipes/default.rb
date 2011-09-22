#
# Cookbook Name:: bunuq
# Recipe:: default
#
# Copyright 2010, RAM9 , Curtis Schofield 
#
# All rights reserved - Redistribute at your own peril
#
#
include_recipe "nodejs::npm"

user node[:bunuq][:user] do
  comment "bunuq daemon"
	home node[:bunuq][:dir]
  shell "/bin/zsh"
	not_if 'id bunuq'
end

[ node[:bunuq][:dir],
  node[:bunuq][:app]  ].each do |dir|
  owner node[:bunuq][:user]
  group node[:bunuq][:user]
  mode 0755
  recursive true
end

directory node[:bunuq][:sv]

file "#{node[:bunuq][:dir]}/.zshrc" do
  action :create
end

[node[:bunuq][:npm]].each do |dir| 
	directory dir do
		owner node[:bunuq][:user]
		group node[:bunuq][:user]
		mode 0755
		recursive true
	end
end

git "Sync Master Bunuq" do
	destination node[:bunuq][:app]
  repository node[:bunuq][:git]
	reference "master"
	user node[:bunuq][:user]
	group node[:bunuq][:user]
  action :sync
end

template node[:bunuq][:npmrc] do
  source "dot.npmrc.erb"
  owner node[:bunuq][:user]
  group node[:bunuq][:user]
end

template node[:bunuq][:config] do
  source "config.js.erb"
  owner node[:bunuq][:user]
  group node[:bunuq][:user]
end

bash "install bunuq nodejs dependencies" do
	# run as user - in login shell 
	# so npm will read .npmrc
	code <<-EOH
	su - #{node[:bunuq][:user]} -c '
	npm install irc && \ 
	npm install nstore  && \
	npm install socket.io  && \
	npm install express && \
	npm install jade && \
  npm install less && \
  npm install redis && \
  npm install vows '
	EOH
end


daemontools_service "bunuq" do
  template "bunuq"
  directory node[:bunuq][:sv]
  owner node[:bunuq][:user]
  group node[:bunuq][:user]
  log true 
	env 'NODE_PATH' => node[:bunuq][:npm]
  supports :start   => true,
           :stop    => true,
           :restart => true
  action [:kill]
end

