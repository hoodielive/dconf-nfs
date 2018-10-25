#!/bin/sh 

for users in $(cat /var/tmp/users); do 
user=/home/$users/.config/dconf
  if $(find $user -type f -iname "user.txt") ; then
    echo "found in $users" 2>/dev/null
  else
    echo "didn't find it in $users" 2>/dev/null
  fi
done

