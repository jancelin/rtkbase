#docker build -t jancelin/rtkbase:cmd -f Dockerfile.cmd .

FROM coderaiser/cloudcmd:latest
MAINTAINER Julien Ancelin<julien.ancelin@inra.fr>

RUN echo "deb    http://http.debian.net/debian sid main " >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y -t sid apt-transport-https ca-certificates gnupg2 software-properties-common && \
               curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - && \
               apt-key fingerprint 0EBFCD88 && \
               echo "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable" > /etc/apt/sources.list.d/docker.list && \
               apt-get update && \
               apt-get install  docker-ce-cli && \
               groupadd docker
RUN apt-get install -y docker-compose
COPY user-menu.js /usr/src/app/static/user-menu.js
ENTRYPOINT ["/usr/src/app/bin/cloudcmd.js"]
