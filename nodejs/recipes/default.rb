#
# Author:: Marius Ducea   (marius@promethost.com)
# Author:: Curtis Schofie (chef@ram9.cc)
# Cookbook Name:: nodejs
# Recipe:: default
#
# Copyright 2010, Promet Solutions
# Copyright 2010, RAM9 
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "build-essential"

case node[:platform]
  when "centos","redhat","fedora"
    package "openssl-devel"
  when "debian","ubuntu"
    package "libssl-dev"
end

remote_file "/usr/local/src/node-v#{node[:nodejs][:version]}.tar.gz" do
	source "http://nodejs.org/dist/node-v#{node[:nodejs][:version]}.tar.gz"
  action :create_if_missing
end

bash "install nodejs from source" do
  cwd "/usr/local/src"
  code <<-EOH
    tar zxf node-v#{node[:nodejs][:version]}.tar.gz
    cd node-v#{node[:nodejs][:version]}
    ./configure --prefix=#{node[:nodejs][:dir]}
    make 
    make install
  EOH
  not_if do 
		File.exists?("#{node[:nodejs][:dir]}/bin/node") &&
		`#{node[:nodejs][:dir]}/bin/node -v`.include?("v#{node[:nodejs][:version]}")
	end
end

