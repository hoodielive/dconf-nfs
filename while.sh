#!/bin/bash 

while read users; do 
  cd /home/$users/.config/gconf 
  if [ -f "user.txt" ]; then
   echo "found user.txt found in $users" 
 else 
   continue
 fi
done < "$(cat /var/tmp/users)"
