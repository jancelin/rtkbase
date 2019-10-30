FROM debian:10-slim
MAINTAINER Julien Ancelin<julien.ancelin@inra.fr>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN echo "deb    http://http.debian.net/debian sid main " >> /etc/apt/sources.list

#install 
RUN apt-get update \
  && apt-get install -t sid -y gcc git build-essential automake checkinstall ntp ntpstat zip unzip \
  && git clone -b rtklib_2.4.3 https://github.com/tomojitakasu/RTKLIB.git \
  && cd /RTKLIB/app \
  && make all \
  && make install \
  && cp /RTKLIB/app/str2str/gcc/str2str /bin \
  && make clean \
  && git clone https://github.com/Stefal/rtkbase.git \
  && apt-get autoremove -y gcc git build-essential automake checkinstall

WORKDIR /rtkbase/
COPY settings.conf settings.conf
COPY run_cast.sh run_cast.sh 
COPY check_timesync.sh check_timesync.sh
COPY rtkrcv.conf rtkrcv.conf
RUN chmod +x check_timesync.sh
RUN chmod +x run_cast.sh

ENV TCP_PORT 2000
ENV TCP_IP 172.24.1.1
ENV RECV_FORMAT ubx
ENV COM_PORT ttyACM0
ENV COM_PORT_SETTINGS 115200:8:n:1
ENV SVR_ADDR caster.centipede.fr
ENV SVR_PORT 2101
ENV SVR_PWD centipede
ENV MNT_NAME BASE
ENV RECEVEIVER Ublox_f9p
ENV RTCM_MSG 1006,1007,1008,1033,1077,1087,1097,1107,1117,1127,1019,1020,1042,1045,1046
ENV LAT 45.999381
ENV LON -1.213787
ENV ALT 50

#run any other process in the foreground
CMD /etc/init.d/ntp start & nohup /rtkbase/run_cast.sh in_serial $RUN & sleep infinity


