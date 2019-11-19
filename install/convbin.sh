#!/bin/bash
#set -xv
#This script should be run from a crontab
#(crontab -l | grep . ; echo -e "0 4 * * * /rtkbase/convbin.sh\n") | crontab -
#You can customize archive_name, rinex, observ_data, and archive_rotate in settings.conf

BASEDIR=$(dirname "$0")
source ${BASEDIR}/settings.conf
cd ${datadir}

#archive and compress previous day's gnss data.
for file in $(find . -maxdepth 1 -type f -mmin +1 -name "*.ubx");
do
  #get file name
  fname="${file%.*}"
  #conb ubx > RINEX
  /usr/local/bin/convbin ${file} -v ${rinex} -r ubx -hm ${mnt_name} -od -os -oi -ot -ti ${observ_data} &&
  #change extension & zip obs
  mv  ${fname}.obs ${fname}.19o &&
#When IGN ppp will work
#  zip -m ${fname}.19o.zip ${fname}.19o && 
  #zip RINEX & UBX
  zip -m ${fname}-UBX ${fname}.ubx ${fname}.ubx.tag &&
  zip -m ${fname}-RINEX_${mnt_name}-${observ_data}s-${file_rotate_time}h ${fname}.*
done

#delete gnss data older than x days.
find . -maxdepth 1 -type f -name "*.zip" -mtime +${archive_rotate} -delete
