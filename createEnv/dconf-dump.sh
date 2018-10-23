#!/bin/bash

for NFS_HOMES in "projecthome/nfshome*" ; do 
  cp projecthome/$NFS_HOMES/user .
  printf %s\\n "user-db:test" > dconf-temporary-profile 
  env DCONF_PROFILE="dconf-temporary-profile" dconf dump / > user.txt 
  cp user.txt ../home/$NFS_HOMES/
  rm -rf dconf-temporary-profile
done
