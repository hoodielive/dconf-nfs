#!/bin/bash -
#===============================================================================
#
#          FILE: dconf-config.sh
#
#         USAGE: ./dconf-config.sh
#
#   DESCRIPTION: 
#
#       OPTIONS: ---
#  REQUIREMENTS: ---
#          BUGS: ---
#         NOTES: ---
#        AUTHOR: Larry 
#  ORGANIZATION: 
#       CREATED: 10/02/2018 10:53:17 PM
#      REVISION:  ---
#===============================================================================

#set -o nounset                                  # Treat unset variables as an error

for homedirs in $@; do 
  echo "user:db" > user_db
