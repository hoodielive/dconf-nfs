#!/bin/bash 

for dirs in $(cat /home/lists.txt); do
  cd $dirs && bash <<EOF
  su - $dirs   
  echo "in $dirs" 
  touch "vibration"
  whoami 
EOF
  cd /home
  echo "Out of $dirs" 
  whoami
done
