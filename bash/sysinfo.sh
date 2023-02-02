#!/bin/bash
echo "The fully qualified domain name for system is:"
hostname
echo "The information for host is:"
hostnamectl
echo "The IP address of this server is:"
hostname -I
echo "Available amount of storage in root system:"
df -h /
