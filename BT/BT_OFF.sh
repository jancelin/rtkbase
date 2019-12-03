#!/bin/bash
set -ex

bluetoothctl  << EOF
  power off
  discoverable off
  quit
EOF

killall rtkrcv
