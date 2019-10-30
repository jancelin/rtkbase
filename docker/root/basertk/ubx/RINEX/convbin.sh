#!/bin/bash
cd ./ubx/ &&
for file in ./*.ubx
do
  mkdir ./RINEX/${file} &&
  convbin ${file} -v 2.11 -r ubx -od -os -oi -ot -d ./RINEX/${file}/
  mv ${file} ./RINEX/${file}/${file}
  cd ./RINEX/${file}
    for f in *.obs
        do cp -- "$f" "${f%.obs}.19o"
    done 
    for z in *.19o
        do zip -r  "${z}.zip" ${z} &&
        rm ${z}
    done
 done
