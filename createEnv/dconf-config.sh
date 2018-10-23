#!/bin/bash 

projectDir="/home/master/Clones/shellscripting/bash/dconf-nfs/createEnv/projecthome/nfs*/"

#for homedirs in ${projectDir} ; do
for homedirs in ${1} ; do
  if [ -d $homedirs ]; then
    echo "these directories exist"
  else
    echo "these directories do NOT exist"
    exit 33
  fi
done 

#if [ -w "${projectDir}" ]; then
if [ -w "${1}" ]; then
  echo "It is writeable as well..."
else
  echo "The directory is not writeable"
  exit 33
fi

for homedirs in ${1} ; do 
  cd $homedirs && echo "user-db:user" > dconf-temporary-profile 
  env DCONF_PROFILE="dconf-temporary-profile" dconf dump /home/osanyin/Clones/dconf-nfs/createEnv/${1}/ 1> user.txt
done 

# check to see if that operation was successful 
if [ "$?" -eq 0 ]; then 
  echo "Succeeded..."
else
  echo "No bueno..."
  exit 33
fi
