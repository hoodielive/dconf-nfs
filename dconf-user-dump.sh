#!/bin/sh
# Change the way users store dconf settings - from binary to keyfile on NFS Mounted home directories. 
set -x

for users in $(cat /var/tmp/assign/users); do
    dconf=/home/$users/.config/dconf
    if [ -d "${dconf}" ]; then 
        echo "$users" >> /var/tmp/assign/with_dconf_directory.txt
    else
        echo "$users" >> /var/tmp/assign/bypass/without_dconf_directory.txt
    fi
done

for users in $(cat /var/tmp/assign/with_dconf_directory.txt); do
    if [ -f "/home/${users}/.config/dconf/user.txt" ]; then 
        echo "${users}" >> /var/tmp/assign/bypass/user_bypass.txt
    else
        echo "${users}" >> /var/tmp/assign/potential_operation_users.txt
    fi
done

for users in $(cat /var/tmp/assign/potential_operation_users.txt); do
    if [ -f "/home/${users}/.config/dconf/user" ]; then 
        echo "${users}" >> /var/tmp/assign/operate_on_these_users.txt
    fi
done

for opusers in $(cat /var/tmp/assign/operate_on_these_users.txt); do
    runuser $opusers --session-command="echo user-db:user > /home/$opusers/.config/dconf/dconf-contemporary-profile"
    runuser $opusers --session-command="env DCONF_PROFILE=/home/$opusers/.config/dconf/dconf-contemporary-profile \
        dconf dump / >/home/$opusers/.config/dconf/user.txt" 
    runuser $opusers --session-command="rm -rf /home/$opusers/.config/dconf/dconf-temporary-profile"
    cd /home
done

