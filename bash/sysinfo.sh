#!/bin/bash
echo "My second script"
#dat1 is the variable which will provide the hostname
dat1=$(hostname)
#dat2 is a variable which will provide the fully qualified name of the domain
dat2=$(hostname -f)
#dat3 will provide the whole information regarding the system and grep will trim its operating system information
dat3=$(hostnamectl | grep Operating) 
#dat4 is the variable which will provide the host name IP address
dat4=$(hostname -I)
#dat5 is a variable which will give us the system information in which awk is used to provide only the fourth line and then tail is used here because we only want the last line 
dat5=$(df -h / | awk '{print $4}' | tail -n 1)
cat <<EOF
Report for:$dat1
===============
FQDN:$dat2
Name and version of operating system:$dat3
IP address:$dat4
Free Space In Root File System:$dat5
===============
EOF
