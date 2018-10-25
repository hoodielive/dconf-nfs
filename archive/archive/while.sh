#!/bin/bash 

while read users; do 
  cd /home/$users/.config/dconf 
  if [ -f "user.txt" ]; then
   echo "found user.txt found in $users" 
 fi
done < "/var/tmp/users"
