#!/bin/bash

#Ensure no duplicate UIDs exist
#it is possible for an administrator to manually edit the /etc/passwd file and change the UID field
#Run the following script and verify no results are returned

cat /etc/passwd | cut -f3 -d":" | sort -n | uniq -c | while read x ; do
  [ -z "${x}" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    users= `awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs`
    echo "Duplicate UID ($2): ${users}"
  fi
done
