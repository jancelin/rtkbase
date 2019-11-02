#!/bin/bash
set -ex

#install rtklib
apt-get update 
 apt-get install -y gcc git build-essential automake checkinstall ntp ntpstat zip unzip 

 git clone -b rtklib_2.4.3 https://github.com/tomojitakasu/RTKLIB.git 
 cd /RTKLIB/app 
 make all 
 make install 
 cp /RTKLIB/app/str2str/gcc/str2str /bin 
 make clean 
 apt-get autoremove -y gcc build-essential automake checkinstall

cd 
git clone https://github.com/jancelin/rtkbase.git

cd ./rtkbase/
chmod +x check_timesync.sh
chmod +x run_cast.sh
chmod +x copy_unit.sh
chmod +x network_check.sh
chmod +x ubxconfig.sh

./copy_unit.sh
systemctl enable str2str_tcp.service 
systemctl enable str2str_file.service 
systemctl enable str2str_ntrip.service 

#echo "0 4 * * * /rtkbase/archive_and_clean.sh" >> /var/spool/cron/root

cd
apt-get install -y nodejs npm
wget --no-check-certificate -P ./ https://raw.githubusercontent.com/coderaiser/cloudcmd/master/package.json

npm install --production
npm install gritty -g --unsafe-perm
npm i cloudcmd -g

cp ./rtkbase/install/user-menu.js /usr/local/lib/node_modules/cloudcmd/static/
cp ./rtkbase/install/cmd.service /etc/systemd/system/
systemctl enable cmd.service

