#
# Cookbook Name:: rsw
# Recipe:: default
#

directory node[:ram][:op]

user node[:rsw][:user] do
  comment "rsw daemon"
	home node[:rsw][:dir]
  shell "/bin/zsh"
	not_if 'id rsw'
end
[ node[:rsw][:dir],
  node[:rsw][:app] ].each do |dir|
directory dir do
  owner node[:rsw][:user]
  group node[:rsw][:user]
end
end

group "rvm" do
  group_name 'rvm'
  members [node[:rsw][:user]]
  append true
end

file "#{node[:rsw][:dir]}/.zshrc" do
  action :create_if_missing
end

cookbook_file File.join(node[:rsw][:app],"Rakefile") do
  source "Rakefile"
end

cookbook_file File.join(node[:rsw][:app],"Gemfile") do
  source "Gemfile"
end

bash 'bundle package' do
  cwd node[:rsw][:app]
  code %%
    rvm exec bundle package
  %
end
