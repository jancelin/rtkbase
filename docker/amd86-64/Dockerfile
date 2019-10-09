#docker build -t jancelin/rtkbase:rtkbase -f Dockerfile .
#docker run -it  --rm --network host --entrypoint /bin/bash jancelin/rtkbase:rtkbase
#docker run  --rm --network host jancelin/rtkbase:rtkbase
#docker run  -d --rm --network host jancelin/rtkbase:rtkbase

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

#run any other process in the foreground
CMD nohup /rtkbase/run_cast.sh in_tcp out_caster & sleep infinity

