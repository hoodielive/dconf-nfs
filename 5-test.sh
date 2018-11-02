#!/bin/bash 

# Role call
for users in $(cat /var/tmp/users); do 
    dconf=/home/$users/.config/dconf
    if [ -d "${dconf}" ]; then
        echo "$users" >> /var/tmp/assign/with_dconf_file.txt
    else
        echo "$users" >> /var/tmp/assign/bypass/without_dconf_file.txt
    fi
done   

# Make sure that if 'user.txt' is found, it is excluded from the change
for users in $(cat /var/tmp/assign/with_dconf_file.txt); do
    if [ -f "/home/${users}/.config/dconf/user.txt" ]; then
        echo "${users}" > /var/tmp/assign/bypass/user_bypass.txt 
    else 
        echo "${users}" > /var/tmp/assign/operation_on_users.txt
    fi
done

# The issue to solve is:
# 1. Enter user directories 
# 2. Become the user 
# 3. Run the commands as that user
# 4. Exit user without exiting script 
# 5. Go back to the home directory 
# 6. Wash, Rinse, Repeat until all users are gone.. 

for opusers in $(cat /var/tmp/assign/operation_on_users.txt); do
 runuser $opusers --session-command="cd /home/$opusers/.config/dconf"
 runuser $opusers --session-command="echo "user-db:user" > /home/$opusers/.config/dconf/dconf-temporary-profile"
 runuser $opusers --session-command="env DCONF_PROFILE='dconf-temporary-profile' dconf dump / > /home/$opusers/.config/dconf/user.txt"
 runuser $opusers --session-command="rm /home/$opusers/.config/dconf/dconf-temporary-profile"
 cd /home
done


