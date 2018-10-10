#!/bin/bash 

file="user"

mkdir -p ./projecthome/nfshome{0..400}

if [ "$?" -eq 0 ]; then 
  echo "Project home environment was created succesfully..."
else
  echo "Project home environment creation failed..."
  exit 33;
fi

sleep 3 

echo 

echo "Let's see if we can get a simulated user binary file to change.."

sleep 3 

for homedir in ./projecthome/nfshome{0..400}/ ; do 
  (cd "$homedir" && cp ../../../createEnv/user .); 
  (cd "$homedir" && mkdir -p .config/dconf); 
done

if [ "$?" -eq 0 ]; then 
  echo 
  echo "Copy was successful!!!"
else
  echo "Copy was NOT successful, please check syntax!"  
  exit 33
fi

sleep 3

echo 

echo "Checking compliance..."

sleep 3 

echo 

if [ -e "$file" ]; then 
  echo "I have copied $file file to all 400 directories"
else
  echo "The $file file was not copied to all 400 directories"
fi
