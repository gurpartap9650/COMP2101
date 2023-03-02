#!/bin/bash
#Virtual Server Creation
#Now Command to check that whether the lxd is installed or not
if which lxc; then
    echo "lxd exists in this operating system"
else
    echo "lxd is not installed in this system installing lxd"
    sudo snap install lxd
fi
#command to make sure the installation of lxd?
if ip a | grep -q lxdbr0; then
    echo "lxdbr0 file exists"
else
    echo "initializing Lxd"
    lxd init --auto
fi
#command to make sure that COMP2101-S22 is available or not?
if lxc list | grep -q COMP2101-S22; then
    echo "Container already exists"
else
    lxc launch images:ubuntu/focal COMP2101-S22
fi
#Command for the list of containers
lxc list
#Command for the IP address of the container in /etc/hosts file
if grep -q COMP2101-S22 /etc/hosts; then
    echo "IP address has already been associated with the container in /etc/hosts"
else
    a=$(lxc info COMP2101-S22 | grep inet | grep global | awk '{print $3}')
    echo "$a COMP2101-S22" | sudo tee -a /etc/hosts
fi
#Command to install Apache2 into the container
lxc exec COMP2101-S22 -- apt-get install apache2 -y
#Retrieve webpage using the command curl
lxc exec COMP2101-S22 -- curl http://localhost
#echo "the webpage is successfully retrieved
exit
