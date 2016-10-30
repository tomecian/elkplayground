#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS
# Installs kibana 5.0.0

#Download kibana deb package
execute "Download elasticsearch deb" do
	command "wget -nv https://artifacts.elastic.co/downloads/kibana/kibana-5.0.0-amd64.deb"
	cwd "/tmp"
	user "root"
	group "root"
end

#Install deb of kibana
dpkg_package "kibana-5.0.0" do
	source "/tmp/kibana-5.0.0-amd64.deb"
end

#Add kibana to init
execute "update-rc.d kibana" do
	command "sudo update-rc.d kibana defaults 95 10"
	user "root"
	group "root"
end

#Start kibana
service "kibana" do
	action :start
end