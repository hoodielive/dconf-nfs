#!/bin/sh 

for users in $(cat /var/tmp/users); do 
  cd /home/$users/.config/dconf 
  if $(find . -type f -iname "user.txt"); then 
    cp user.txt user.txt_justincasebackup
    :
    echo "exiting because this "
  
  fi 
  continue 
  sudo -u $users bash <<EOF 
  if $(find . -type f -iname "user"); then 
    printf %s\\n "user-db:test" > dconf-temporary-profile 
    env DCONF_PROFILE="dconf-temporary-profile" dconf dump / 1>user.txt
    rm dconf-temporary-profile 
  else
    echo "$user's stuff did not get set up properly" >> /var/tmp/hosts_that_require_review
  fi 
EOF
done 
