#!/bin/bash

echo "User ID is: " $EUID

if [[ $EUID -ne 0 ]]; then
  echo "Must run as root"
  exit 1
fi

echo \

#Check the uptime

echo "Host uptime: " ` uptime | awk '{ print $2 }' `
echo \

#Check RAM & Disk space

echo "Total available RAM in Mb is: "  `free -m | awk '/Mem:/ { print $4 }' `
echo \

echo "Disk storage: " 
lsblk
echo \

#Check the network connection

if ping -c 1 -W 3 google.com;
  then
  echo "Network OK"
else
  echo "Network is down"
  exit 1
fi
echo \

echo `cat /proc/cpuinfo | grep "cpu cores"`
echo \

echo `cat /proc/cpuinfo | grep "model name"`
echo \

#Get the network device name & and host IP address

echo "Network device is: " `ip addr show | grep "2:" | awk '{ print $2 }'`

echo "Host IP is: " `ip addr show enp0s3 | grep -w "inet" | awk '{ print $2 }'`
