#!/bin/bash
set -ex

bluetoothctl << EOF
  power on
  discoverable on
  quit
EOF
