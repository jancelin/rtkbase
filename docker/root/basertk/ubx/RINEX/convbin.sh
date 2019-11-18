#!/bin/bash
#set -xv
apt-get install -y zip
cd ./data/ &&
for file in $(find . -maxdepth 1 -type f -mmin +60 -name "*.ubx");
#for file in $(find . -maxdepth 1 -type f -mtime -1 -mmin +60 -name "*.ubx*");
do
  #get file name
  fname="${file%.*}"
  #conb ubx > RINEX
  convbin ${file} -v 2.11 -r ubx -od -os -oi -ot -ti 5
  #change extension & zip obs
  mv  ${fname}.obs ${fname}.19o
  zip -m ${fname}.19o.zip ${fname}.19o
  #zip RINEX directory
  zip -m ${fname}_5s_rinex2_11 ${fname}.*
done
