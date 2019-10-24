FROM node:12-buster
MAINTAINER jancelin

COPY package.json .

RUN npm install --production && \
    npm i gritty
RUN npm i cloudcmd -g

RUN curl -fsSL https://get.docker.com/ | sh
#RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && \
#    chmod +x /usr/local/bin/docker-compose

RUN apt-get install python3-pip -y && pip3 install --no-cache-dir "docker-compose==1.24.1"

COPY user-menu.js /usr/local/lib/node_modules/cloudcmd/static/user-menu.js

WORKDIR /mnt/fs/basertk

ENV cloudcmd_terminal true
ENV cloudcmd_terminal_path gritty
ENV cloudcmd_open false

EXPOSE 8000
CMD cloudcmd
