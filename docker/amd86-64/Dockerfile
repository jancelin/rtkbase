#docker build -t jancelin/rtkbase:rtkbase -f Dockerfile .
#docker run -it  --rm --network host --entrypoint /bin/bash --device=/dev/ttyACM4:/dev/ttyACM4 --privileged jancelin/rtkbase:rtkbase
#docker run  --rm --network -t rtk host jancelin/rtkbase:rtkbase
#docker run  -d --rm -t rtk --network host jancelin/rtkbase:rtkbase
#docker run  --rm --name rtk --network host  -e MNT_NAME=BASE -e SRV_ADDR=caster.centipede.fr -e SRV_PORT=2101 -e COM_PORT=ttyACM4  --device=/dev/ttyACM4:/dev/ttyACM4 --privileged jancelin/rtkbase:rtkbase


FROM debian:10-slim
MAINTAINER Julien Ancelin<julien.ancelin@inra.fr>

RUN  export DEBIAN_FRONTEND=noninteractive
ENV  DEBIAN_FRONTEND noninteractive
RUN dpkg-divert --local --rename --add /sbin/initctl
RUN echo "deb    http://http.debian.net/debian sid main " >> /etc/apt/sources.list

#install 
RUN apt-get update \
  && apt-get install -t sid -y gcc git build-essential automake checkinstall scons \
                               postgresql-client jq curl python-dev procps
RUN git clone -b rtklib_2.4.3 https://github.com/tomojitakasu/RTKLIB.git \
  && cd /RTKLIB/app \
  && make all \
  && make install \
  && cp /RTKLIB/app/str2str/gcc/str2str /bin \
  && make clean 

RUN git clone https://github.com/Stefal/rtkbase.git

WORKDIR /rtkbase/
COPY settings.conf settings.conf
COPY run_cast.sh run_cast.sh 
RUN chmod +x run_cast.sh

ENV TCP_PORT 2000
ENV TCP_IP 172.24.1.133
ENV RECV_FORMAT 'ubx'

ENV COM_PORT 'ttyACM4'
ENV COM_PORT_SETTINGS '115200:8:n:1'

ENV SVR_ADDR caster.centipede.fr
ENV SVR_PORT 2101
ENV SVR_PWD centipede
ENV MNT_NAME BAS

ENV RECEVEIVER 'Ublox_f9p'
ENV RTCM_MSG '1002,1006,1010,1097,1107,1117,1127'
ENV POSITION '46.16489 -0.94822 68.27'


#run any other process in the foreground
CMD nohup /rtkbase/run_cast.sh in_serial out_caster & sleep infinity


