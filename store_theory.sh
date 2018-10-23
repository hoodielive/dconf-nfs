for userfile in $(find projecthome/ -type f); do \ncp $userfile $userfile.bak\ndone
