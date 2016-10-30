#
# Cookbook Name:: logstash
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS
# Installs logstash 5.0.0
# Default home dir: /usr/share/logstash

#Download logstash deb package
execute "Download logstash deb" do
	command "wget -nv https://artifacts.elastic.co/downloads/logstash/logstash-5.0.0.deb"
	cwd "/tmp"
	user "root"
	group "root"
end

#Install deb of logstash
dpkg_package "logstash-5.0.0" do
	source "/tmp/logstash-5.0.0.deb"
end

#Start logstash
service "logstash" do
	action :start
end
