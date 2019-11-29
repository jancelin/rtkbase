#RTKbase----------------------------------------------------
#install dep
apt-get update 
apt-get install -y gcc git build-essential automake checkinstall zip unzip dos2unix bc xxd
#make rtklib
git clone -b rtklib_2.4.3 https://github.com/tomojitakasu/RTKLIB.git 
cd /RTKLIB/app 
make all 
make install 
cp /RTKLIB/app/str2str/gcc/str2str /bin 
make clean 
#install node.js npm & cmd + gritty
cd
apt-get install -y nodejs
curl https://www.npmjs.com/install.sh | sh
wget --no-check-certificate -P ./ https://raw.githubusercontent.com/coderaiser/cloudcmd/master/package.json
npm install --production
npm install gritty -g --unsafe-perm
npm install cloudcmd -g --unsafe-perm
##clone rtkbase
cd /
git clone -b 0.3.1 https://github.com/jancelin/rtkbase.git 
cd /rtkbase
./copy_unit.sh
##modify file.service because user is false
mv /etc/systemd/system/str2str_file.service /etc/systemd/system/str2str_file.service.bak
cp ./install/str2str_file.service /etc/systemd/system/str2str_file.service
systemctl enable str2str_tcp.service 
systemctl enable str2str_file.service 
systemctl enable str2str_ntrip.service 
##adapt cmd menu & enable service
mv /usr/lib/node_modules/cloudcmd/static/user-menu.js /usr/lib/node_modules/cloudcmd/static/user-menu.js.bak
cp ./install/user-menu.js /usr/lib/node_modules/cloudcmd/static/
cp ./install/cmd.service /etc/systemd/system/cmd.service
systemctl enable cmd.service 
##add tools
chmod +x ./convbin.sh
chmod +x ./status.sh
#crontab convbin
echo -e "0 4 * * * root /rtkbase/convbin.sh" >> /etc/crontab
cat /etc/crontab
#remove some tools
systemctl disable ntp
apt-get autoremove -y gcc build-essential automake checkinstall ntp
