#!/bin/bash
#
# run_cast.sh: script to run NTRIP caster by STR2STR
# You can read the RTKLIB manual for more str2str informations:
# https://github.com/tomojitakasu/RTKLIB

BASEDIR=$(dirname "$0")
source ${BASEDIR}/settings.conf   #import settings

in_serial="serial://$COM_PORT:$COM_PORT_SETTINGS#$RECV_FORMAT"
#in_serial="serial://${com_port}:${com_port_settings}#${receiver_format}"
in_tcp="tcpcli://$TCP_IP:$TCP_PORT#$RECV_FORMAT"


out_caster="ntrips://:$SVR_PWD@$SVR_ADDR:$SVR_PORT/$MNT_NAME#rtcm3 -msg $RTCM_MSG -p $POSITION -i $RECEVEIVER"
out_tcp="tcpsvr://:$SVR_PORT"
out_file="file://${datadir}/${file_name}::T::S=${file_rotate_time} -f ${file_overlap_time}"


# start NTRIP caster


    mkdir -p ${logdir} ${datadir}
    
    case "$2" in
      out_tcp)
      #echo ${cast} -in ${!1} -out $out_tcp
      ${cast} -in ${!1} -out ${out_tcp} &
      ;;

    out_caster)
      #echo ${cast} -in ${!1} -out $out_caster
      ${cast} -in ${!1} -out ${out_caster} &
      ;;

    out_file)
      #echo ${cast} -in ${!1} -out $out_caster
      ${BASEDIR}/check_timesync.sh  #wait for a correct date/time before starting to write files
      ret=$?
      if [ ${ret} -eq 0 ]
      then
        ${cast} -in ${!1} -out ${out_file} &
      fi
      ;;
      
    esac





