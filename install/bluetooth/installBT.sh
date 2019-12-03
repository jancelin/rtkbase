# https://egjerde.com/blog/?p=66


#!/bin/bash
set -ex
bluetoothctl  << EOF
power on
discoverable on
quit
EOF



sudo nano /etc/systemd/system/dbus-org.bluez.service
                                                                                                          
[Unit]
Description=Bluetooth service
Documentation=man:bluetoothd(8)
ConditionPathIsDirectory=/sys/class/bluetooth

[Service]
Type=dbus
BusName=org.bluez
ExecStart=/usr/lib/bluetooth/bluetoothd -C --noplugin=sap
ExecStartPost=/usr/bin/sdptool add SP
NotifyAccess=main
#WatchdogSec=10
#Restart=on-failure
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
LimitNPROC=1
ProtectHome=true
ProtectSystem=full

[Install]
WantedBy=bluetooth.target
Alias=dbus-org.bluez.service


sudo nano /etc/systemd/system/rfcomm.service                                                                                                                   

[Unit]
Description=RFCOMM service
After=bluetooth.service
Requires=bluetooth.service

[Service]
ExecStart=/usr/bin/rfcomm watch hci0 1 getty rfcomm0 115200 vt100 -a root

[Install]
WantedBy=multi-user.target


sudo systemctl enable rfcomm
sudo systemctl start rfcomm
