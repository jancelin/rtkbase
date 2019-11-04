#!/bin/bash
#set -xv
cd ./data/ &&
for file in ./*.ubx
do
  mkdir ./${file} &&
  convbin ${file} -v 2.11 -r ubx -od -os -oi -ot -d ./${file}/
  mv ${file} ./${file}/${file}
  mv ${file}.tag ./${file}/${file}.tag
  cd ./${file}
    for f in *.obs
        do cp -- "$f" "${f%.obs}.19o"
    done 
    for z in *.19o
        do zip -r  "${z}.zip" ${z} &&
        rm ${z}
    done
 done
