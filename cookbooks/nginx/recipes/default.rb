#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS

execute 'apt-get update' do
	command 'apt-get update'
end

package "nginx" do
	action :install
	options "-y --force-yes"
end