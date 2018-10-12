#!/bin/bash 

projectDir="/home/master/Clones/shellscripting/bash/dconf-nfs/createEnv/projecthome/nfs*/"

#if [ -d "${projectDir}" ]; then
#if [ -d "/home/master/Clones/shellscripting/bash/dconf-nfs/createEnv/projecthome/nfshome{0..400}" ]; then
#  echo "Project directories exist..."; 
#else
#  echo "Project directories does NOT exist...";
#  exit 33 
#fi

for homedirs in ${projectDir} ; do
  if [ -d $homedirs ]; then
    echo "these directories exist"
  else
    echo "these directories do NOT exist"
    exit 33
  fi
done 

if [ -w "${projectDir}" ]; then
  echo "It is writeable as well..."
else
  echo "The directory is not writeable"
  exit 33
fi

for homedirs in ${projectDir} ; do 
  cd $homedirs && echo "user-db:user" > dconf-temporary-profile 
  env DCONF_PROFILE="${projectDir}/dconf-temporary-profile dconf dump" / 1> $projectDir/.config/dconf/user.txt
done 

echo $?

if [ "$?" -eq 0 ]; then 
  echo "Succeeded..."
else
  echo "No bueno..."
  exit 33
fi
