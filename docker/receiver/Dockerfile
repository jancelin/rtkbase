FROM debian:10-slim
MAINTAINER Julien Ancelin<julien.ancelin@inra.fr>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl

#install 
RUN apt-get update \
  && apt-get install -y  git dos2unix bc xxd \
  && git clone https://github.com/Stefal/rtkbase.git \
  && apt-get autoremove -y git

WORKDIR /rtkbase/receiver_cfg/

#run
CMD ./ubxconfig.sh /dev/ttyACM0 U-Blox_ZED-F9P_rtkbase.txt --force


