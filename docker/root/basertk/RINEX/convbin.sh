#!/bin/bash

for file in ./ubx/*.ubx
do
  convbin -v 2.11 -ti 30 -r ubx -od on -os on -oi on -ot on -ol on -halfc on -d ./RINEX/ ${file} &&
  cp ${file} ./RINEX/ &&
  for f in ./RINEX/*.obs
    do mv -- "$f" "${f%.obs}.19O"
  done
done



