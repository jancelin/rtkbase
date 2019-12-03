 GNU nano 3.2                                                                                                                    /rtkbase/BT/BT_ON.sh                                                                                                                               
#!/bin/bash
set -ex

#bluetoothctl  << EOF
#  power on
#  discoverable on
#  quit
#EOF

#FILE=/dev/rfcomm0

#while [ ! -d "$file" ]
#do 
#    echo "BT devise Not Connected"
#    sleep 1
#done 
sleep 1
rtkrcv -s -o ./rover/rtkrcv.conf << EOF
status 1
EOF
