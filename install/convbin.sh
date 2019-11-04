#!/bin/bash
#set -xv
cd ./data/ &&
for file in *.ubx
do
  filename="${file%.*}"
  echo ${filename}
  mkdir -p ./${filename} &&
  convbin ${file} -v 2.11 -r ubx -od -os -oi -ot -d ./${filename}/
  mv ./${filename}.ubx ./${filename}/${filename}.ubx
  mv ./${filename}.ubx.tag ./${filename}/${filename}.tag
  cd ./${filename}
    for f in *.obs
        do cp -- "$f" "${f%.obs}.19o"
    done 
    for z in *.19o
        do zip -r  "${z}.zip" ${z} &&
        rm ${z}
    done
 done
