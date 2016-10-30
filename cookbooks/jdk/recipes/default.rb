#
# Cookbook Name:: jdk
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# Tested using Ubuntu 14.04 LTS
# Installs jdk1.8.0_101

version = 'jdk1.8.0_101'


#Create directory for JDK to be placed into
directory '/usr/lib/jvm' do
	owner 'root'
	group 'root'
	mode 0755
	action :create
end

#Download JDK from Oracle website
execute "JDK download" do
	command 'wget -nv --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u101-b13/jdk-8u101-linux-x64.tar.gz"'
	cwd '/tmp'
	user 'root'
	group 'root'
end

#Untar JDK
execute "JDK untar" do
	command 'tar xzvf jdk-8u101-linux-x64.tar.gz -C /usr/lib/jvm'
	cwd '/tmp'
	user 'root'
	group 'root'
end

#Utilize update-alternatives to use downloaded JDK
execute "update-alternatives" do
	command "sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/#{version}/jre/bin/java 2000"
	user 'root'
	group 'root'
end
execute "update-alternatives" do
	command "sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/#{version}/bin/javac 2000"
	user 'root'
	group 'root'
end

#Create profile script for JDK paths
template "/etc/profile.d/jdk.sh" do
	source "jdk.erb"
	mode '0744'
	user 'root'
	group 'root'
	variables(
		:version => "#{version}"
		)
end