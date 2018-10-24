#!/bin/bash

lists="$(cat /home/lists)" 

for NFS_HOMES_USER_FILE in $(find /home/$lists/.config/dconf -type f -iname user); do 
  cp $NFS_HOMES_USER_FILE .
  printf %s\\n "user-db:test" > dconf-temporary-profile 
  env DCONF_PROFILE="dconf-temporary-profile" dconf dump / > user.txt 
  cp user.txt ../home/$NFS_HOMES/
  rm -rf dconf-temporary-profile
done

if "find /home/$lists/.config/dconf 
