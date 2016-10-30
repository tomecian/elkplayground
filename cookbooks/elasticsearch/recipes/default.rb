#
# Cookbook Name:: elasticsearch
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS
# Installs elasticsearch 5.0.0
# Default home dir: /usr/share/elasticsearch

#Download elasticsearch deb package
execute "Download elasticsearch deb" do
	command "wget -nv https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.0.0.deb"
	cwd "/tmp"
	user "root"
	group "root"
end

#Install deb of elasticsearch
dpkg_package "elasticsearch-5.0.0" do
	source "/tmp/elasticsearch-5.0.0.deb"
end

#Add elasticsearch to init
execute "update-rc.d elasticsearch" do
	command "sudo update-rc.d elasticsearch defaults 95 10"
	user "root"
	group "root"
end

#Start elasticsearch
service "elasticsearch" do
	action :start
end