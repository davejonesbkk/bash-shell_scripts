#!bin/bash

#check for DDOS attacks

netstat -an | egrep ":80|:443" | grep ESTABLISHED | awk '{print $5}' | grep -o -E "([0-9]{1,3}[\.]){3}[0,9]{1,3}" | sort -n | uniq -c | sort -nr 

