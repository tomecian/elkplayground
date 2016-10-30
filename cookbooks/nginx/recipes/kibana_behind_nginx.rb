#
# Cookbook Name:: kibana
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS
# Configures nginx to serve kibana with basic auth
# 
#Set defaults if no attributes are passed

if !node[:kibana].nil?
	if node[:kibana][:kibana_username].nil?
		username = "default"
	else
		username = node[:kibana][:kibana_username]
	end

	if node[:kibana][:kibana_password].nil?
		password = "default"
	else
		password = node[:kibana][:kibana_password]
	end
else
	username = "default"
    password = "default"	
end


#Generate an authenticated user

execute "create kibana user" do
	command "echo \"#{password}\" | htpasswd -c -i /etc/nginx/htpasswd.users #{username}"
end

#Move kibana nginx conf to sites-available
cookbook_file '/etc/nginx/sites-available/kibana' do
  source 'nginx_kibana.conf'
  owner 'root'
  group 'root'
  mode '0744'
  action :create
end

#Symlink into sites-enabled
execute "ln -nfs /etc/nginx/sites-available/kibana" do
	command "ln -nfs /etc/nginx/sites-available/kibana /etc/nginx/sites-enabled/kibana"
end

#Remove symlink of default
execute "rm /etc/nginx/sites-enabled/default" do
	command "rm /etc/nginx/sites-enabled/default"
end

#Restart nginx
service "nginx" do
	action :stop
end
service "nginx" do
	action :start
end
