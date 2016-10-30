#
# Cookbook Name:: apache2-utils
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

package "apache2-utils" do
	action :install
	options "-y --force-yes"
end