#!/bin/bash
#pinging the hosts...

PREFIX=192.168.56
for OCTET in `seq 100 120`
do
 echo -en "Pinging ${PREFIX}.${OCTET}.. "
 ping -c1 -w1 ${PREFIX}.${OCTET} >/dev/null 2>&1
 if [ $? -eq 0 ]
 then
 echo -e "\e[00;32mSUCCESS\e[00m"
 else
 echo -e "\e[00;31mFAIL\e[00m"
 fi
done
