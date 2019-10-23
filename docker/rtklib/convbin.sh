#!/bin/bash

for file in *.ubx
do
  convbin.exe -v 2.10 -ti 30 -r ubx -od on -os on -oi on -ot on -ol on -halfc on ${file}
done
