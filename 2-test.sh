#!/bin/bash 

# Initial test 
# 1. Make a list of all the users that do not have a .config/dconf file instance 

for users in $(cat /var/tmp/users); do 
    dconf=/home/$users/.config/dconf
    if [ -d "${dconf}" ]; then
        echo "$users" >> /var/tmp/with_dconf_file.txt
    else
        echo "$users" >> /var/tmp/without_dconf_file.txt
    fi
done   

# 2. Make sure none of these users get added to the /var/tmp/users list. 

# Secondary tests 
# 1. Make sure that 'user.txt' is not found 
for users in $(cat /var/tmp/with_dconf_file.txt); do
    if [ -f "/home/${users}/.config/dconf/user.txt" ]; then
        echo "${users}" >> /var/tmp/user_bypass.txt 
    else 
        echo "${users}" >> /var/tmp/operation_on_users.txt
    fi
done
# 2. If user.txt is found - skip 
# 3. if user.txt is not found, is user file found? if not, skip, else become user and perform operation 

# 4. test if operation was successful, if it was rm dconf-temp-profile and log it to a file in /var/tmp
for opusers in $(cat /var/tmp/operation_on_users.txt); do 
  sudo -u $opusers bash <<EOF 
    cd /home/$opusers/.config/dconf 
    echo "user-db:test" > dconf-temporary-profile
    env DCONF_PROFILE="dconf-temporary-profile" dconf dump / 1> user.txt
    rm dconf-temporary-profile 
EOF 
done
# 5. If successful remove of dconf-temporary-profile - cd to next users dir 
