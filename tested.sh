#!/bin/bash 
set -x
#set -n

for users in "cat /var/tmp/users"; do 
user=/home/$users/.config/dconf
  if $(find $users -type f -iname "user.txt") ; then
    echo "found in $users" 2>/dev/null
  else
    sudo -u "$users" bash <<EOF
	if "find /home/$users/.config/dconf -type f -iname "user" " ; then
		echo "user-db:test" > /home/$user/.config/dconf/dconf-temporary-profile
		env DCONF_PROFILE="dconf-temporary-profile" dconf dump / 1>/home/$users/.config/dconf/user.txt
	else
		echo "the user file is not there for $users, so operation terminated"
	fi
  fi
EOF
done

