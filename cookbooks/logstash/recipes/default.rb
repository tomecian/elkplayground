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

#Add kibana.conf logstash config file to conf.d so it knows to read the logfile
cookbook_file '/etc/logstash/conf.d/kibana.conf' do
  source 'kibana.conf'
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

#Add nginx_json_template.json to logstash config directory so it knows the template to use for ES
cookbook_file '/etc/logstash/nginx_json_template.json' do
  source 'nginx_json_template.json'
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

#Start logstash
service "logstash" do
	action :start
end
