**TL;DR description:** ELK stack behind Nginx

----
Technologies in use
----
* chef-zero
* Vagrant
* ElasticStack
	* ElasticSearch 5.0.0
	* Kibana 5.0.0
	* LogStash 5.0.0

* Nginx
* JDK1.8
* VirtualBox
* AWS

----
Notes
----
A VM with at least 3GB of memory is required for the entire stack running on a single machine.
Your machine for local development should have a lot of free ram.
This repo utilizes Ubuntu 14.04 to get the job done.

----
Getting up to speed
----
Stuff you'll need to install:
1. [Get VirtualBox](https://www.virtualbox.org/wiki/Downloads)
2. [Get Vagrant](https://www.vagrantup.com/downloads.html)
3. [Add in the Vagrant plugin for aws](https://github.com/mitchellh/vagrant-aws)
4. [Get a Vagrant VM(you can use any, but everything is done with Ubuntu14.04 in mind)](http://www.vagrantbox.es)
	* [Especially this guy's](https://github.com/sepetrov/trusty64/releases/download/v0.0.5/trusty64.box)

Some reading:
1. [Getting started with ES (the ELK stack); Keep in mind, with the 5.0.0 release, things are different!](http://brewhouse.io/blog/2014/11/04/big-data-with-elk-stack.html)
2. [Nginx logs consumed by the ES](https://www.nginx.com/blog/monitoring-nginx-plus-statistics-elk)
3. [Hands on example with Nginx + ES!](https://github.com/elastic/examples)

----
Let's get stuff done already!
----
With the repo cloned, you can make use of the sample Vagrantfiles available in the vagrant folder.

**Make sure you fill in the needed items!**

For the local folder (meaning you want to use VirtualBox to do your chef stuff), run the following commands inside the dir:
1. vagrant box add vagrant1404 https://github.com/sepetrov/trusty64/releases/download/v0.0.5/trusty64.box
2. vagrant up --no-provision
	* This will create a VM and associate it with Virutalbox for you
	* The no provision will not run your chef node.json just yet, we have some small thing to take care of.
3. vagrant halt
4. Go to your VirtualBox console and modify the VM to have at least 3GB of ram (anything else and the entire stack can't really run)
5. vagrant snapshot save beforeprovision
	* This will let us save the current state of the VM
6. vagrant up --provision
7. From this point on you can use: **vagrant snapshot restore beforeprovision** so that the settings needed by the stack are in place
8. localhost:8080 on your machine's browser will bring you the Kibana dashboard ;)

For the aws folder (meaning you're going to fabricate with chef on a live AWS instance), run the following commands inside the dir:
1. vagrant plugin install vagrant-aws
2. vagrant box add dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
3. Make sure you have the following: 
	1. Valid AWS credentials set as ENV variables; 
	2. A keypair you can ssh with into an AWS box
	3. A security group to attach the instance to (something with SSH only to your internet router's IP)
3. vagrant up —-provider=aws
4. This will utilize an EC2 instance create call and get you an instance that will then be pushed through the Vagrant provisioning flow
5. The public IP generated will be your gateway to the Kibana dashboard ;)
6. If you're satisifed with the performance, go ahead and run: **vagrant destroy** and run though steps 1 to 4.
7. Utilized the AWS web console to create an AMI from the Vagrant AWS box. This is now your fabricated instance to deploy with.

