#!/bin/bash 

<<<<<<< HEAD
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

# 4. test if operation was successful, if it was rm dconf-temp-profile and log it to a file in /var/tmp
#for opusers in $(cat /var/tmp/assign/operation_on_users.txt); do 
#  runuser $opusers cd /home/$opusers/.config/dconf && 
#    echo "user-db:user" > "dconf-temporary-profile" &&  
#    env DCONF_PROFILE="dconf-temporary-profile" dconf dump / 1>user.txt && 
#    rm dconf-temporary-profile &&
#    # exit user - but if you exit here, it will exit the script, so you may need to trap this some way.
#    kill -INT $$ && 
#    cd /home
#done

# The issue to solve is:
# 1. Enter user directories 
# 2. Become the user 
# 3. Run the commands as that user
# 4. Exit user without exiting script 
# 5. Go back to the home directory 
# 6. Wash, Rinse, Repeat until all users are gone.. 

for opusers in $(cat /var/tmp/assign/operation_on_users.txt); do
    runuser $opusers -c "cd /home/$opusers/.config/dconf && \ 
        printf %s\\n "user-db:user" > dconf-temporary-profile && \
        DCONF_PROFILE='dconf-temporary-profile' dconf dump / 1>user.txt  && \
        rm dconf-temporary-profile < /dev/null >> /var/tmp/log_file_here 2>&1 &"
    cd /home
    if [ "$EUID" -ne 0 ]; then 
        opuser=root
    fi
done

=======
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
  cd /home
done
>>>>>>> ca3d3362f6fb803ea7e93416e8d35ddb01658351
# 5. If successful remove of dconf-temporary-profile - cd to next users dir 
