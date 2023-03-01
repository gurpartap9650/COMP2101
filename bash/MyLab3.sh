#!/bin/bash
#Virtual Server Creation
#Now Command to check that whether the lxd is installed or not
if which lxc;then echo "lxd exists in this operating system"
else echo"lxd is not installed in this system installing lxd"
sudo snap install lxd fi
#command to make sure the installation of lxd?
ip a |grep -q | lxdbr0
if [$? -eq 0];then echo"lxbr0 file exixts"
otherwise echo "initializing Lxd" lxd init-auto fi

#command to make sure that COMP2101-S22 available or not ?
lxc list | grep -q | COMP2101-S22 if [$? -eq 0];then echo"container exists already"
else lxc launch images:ubuntu/focal COMP2101-S22 fi
#Command for the list of container COMP2101-S22 lxc list
#Command for the ip addresses of the container in etc/hosts file
cat/etc/hosts|grep -q| COMP2101-S22 if [$?=0];then echo"IP address has been already associated with the containerin etc/hosts file"
else a=$(lxc info COMP2101-S22|grep inet:|grep global|awl'{print$3}') fi
#Command to install Apache2 into the container
lxc exec COMP2101-S22 --apt-get install apache2
#retrieve webpage using the command curl
Curl http://COMP2101-S22
#echo "This webpage has been retrieved successfully"

