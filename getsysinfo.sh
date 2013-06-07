#!/bin/bash

#getting server information from the script.
#   Author: Mr.Sunil Kumar
#
#   Name: getsysinfo
#   File: getsysinfo.sh
#   Created: May 30, 2013
#
#   Purpose: Extracts the system information
#
# --------------------------------------------


#### General Information on the server

#OS=`cat /etc/SuSE-release | awk '{print $1}' | head -1`
JUMP=`ls /etc/SuSE-release`

if [ $JUMP = "openSUSE"]; then
OS="openSUSE"
else 
OS="CentOS"
fi

case $OS in
openSUSE) 

echo -e "\e[00;31mOS:`uname -n`\e[00m "

UPTIME=`uptime | tr -s " " | awk -F" " '{print $3}' | sed '$s/.$//'`
CPUSPEED=`cat /proc/cpuinfo | grep "model name" | cut -d"@" -f2`
#TRAM=`free -m | tr -s ' ' | grep ^Mem | awk -F" " '{print $2}'`
TOTALRAM=`cat /proc/meminfo  | grep ^MemTotal  | awk -F":" '{print $2}'`
OSVER=`cat /etc/issue | head -1 | awk -F" " '{print $3 " " $4}'`
KERVER=`uname -a | tr -s ' ' | awk -F" " '{print $3}'`
NUMHDD=`ls /dev/sd? | wc -l`
CPUINFO=`cat /proc/cpuinfo | grep "model name" | cut -d" " -f3,4,5`

##### Network Information for OpenSUSE/SUSE ######

ETHCOUNT=`ls /etc/sysconfig/network/ifcfg-eth? | wc -l`
arr=( $(ls /etc/sysconfig/network/ifcfg-eth?) ) 
hddnum=( $(ls /dev/sd?) )
FIRSTNWADAPTER=`for i in "${arr[@]}"; do echo $i; done | awk -F"-" '{print $2}'  | head -1`
SECONDNWADAPTER=`for i in "${arr[@]}"; do echo $i; done | awk -F"-" '{print $2}'  | tail -1`
harddisk=`for i in "${hddnum[@]}"; do echo $i; done | sed 's/^.\{5\}//'`
ETH0=`ifconfig -a | grep $FIRSTNWADAPTER | awk '{print $1}'`
IPADDRETH0=`ifconfig -a | grep "inet addr" | head -1 | cut -d":" -f2 | awk '{print $1}'`
eth1gw=`route -n | egrep "Gateway|$FIRSTNWADAPTER" | grep -v Gateway | head -1 | awk -F" " '{print $2}'`
eth2gw=`route -n | egrep "Gateway|$SECONDNWADAPTER"| grep -v Gateway | tail -1 | awk -F" " '{print $2}'`
ETH1=`ifconfig -a | grep $SECONDNWADAPTER| awk '{print $1}'`
IPADDRETH1=`ifconfig -a | grep "inet addr" | head -2  | cut -d":" -f2 | awk '{print $1}'|tail -1`


##### Hardware information on the system  #####

SERIAL=`dmidecode | grep -i "Serial Number" | uniq -c | head -1 | awk -F" " '{print $4}'`
PRODUCT=`dmidecode | grep -i "Product Name" | head -1 | awk -F":" '{print $2}'`
ARCH=`lscpu | grep Architecture | awk -F":" '{print $2}'`
CPUOPS=`lscpu | grep op-mode | awk -F":" '{print $2}'`
CPUCOUNT=`lscpu | grep "CPU(s):" | awk -F":" '{print $2}'`


#Display Hardware/System informations

echo -e "\e[00;35mhostname       \e[00m" : $HOSTNAME
echo -e "\e[00;35muptime        \e[00m " : $UPTIME
echo -e "\e[00;35mRAM   \e[00m         " : $TOTALRAM
echo -e "\e[00;35mkernel version \e[00m" : $KERVER
echo -e "\e[00;35mOS version     \e[00m" : $OSVER
echo -e "\e[00;35mhdd            \e[00m" : $harddisk

echo -e "\e[00;35mcpu            \e[00m" : $CPUINFO
echo -e "\e[00;35mcpu speed      \e[00m" : $CPUSPEED
echo -e "\e[00;35mserial         \e[00m" : $SERIAL
echo -e "\e[00;35mproduct        \e[00m" : $PRODUCT
echo -e "\e[00;35march           \e[00m" : $ARCH
echo -e "\e[00;35mcpuarch        \e[00m" : $CPUOPS
echo -e "\e[00;35mcpucount       \e[00m" : $CPUCOUNT

### Displaying ethernet adapters

echo -e "\e[00;35methadapters    \e[00m"               : $ETHCOUNT
echo -e "\e[00;35m$FIRSTNWADAPTER    \e[00m       " : $IPADDRETH0
echo -e "\e[00;35mGateway        \e[00m"              : $eth1gw
echo -e "\e[00;35m$SECONDNWADAPTER    \e[00m       " : $IPADDRETH1
echo -e "\e[00;35mGateway        \e[00m"               : $eth2gw
;;

CentOS|Red|red) 

echo -e "Redhat/Centos ..."

echo -e "\e[00;31mOS:`cat /etc/issue | head -1 | awk -F" " '{print $1}'`\e[00m "

UPTIME=`uptime | tr -s " " | awk -F" " '{print $3}' | sed '$s/.$//'`
CPUSPEED=`cat /proc/cpuinfo | grep "model name" | cut -d"@" -f2`
#TRAM=`free -m | tr -s ' ' | grep ^Mem | awk -F" " '{print $2}'`
TOTALRAM=`cat /proc/meminfo  | grep ^MemTotal  | awk -F":" '{print $2}'`
#OSVER=`cat /etc/issue | head -1 | awk -F" " '{print $1}'`
OSVER=`cat /etc/issue | head -1 | awk -F" " '{print $3 " " $4}'`
KERVER=`uname -a | tr -s ' ' | awk -F" " '{print $3}'`
NUMHDD=`ls /dev/sd? | wc -l`
CPUINFO=`cat /proc/cpuinfo | grep "model name" | cut -d" " -f3,4,5`

##### Network Information for OpenSUSE/SUSE ######

ETHCOUNT=`ls /etc/sysconfig/network-scripts/ifcfg-eth? | wc -l`
#arr=( $(ls /etc/sysconfig/network-scripts/ifcfg-eth?) )
arr=( $(ls /etc/sysconfig/network-scripts/ifcfg-eth? | sed 's/^\/etc\/sysconfig\/network-scripts\/ifcfg-//') )
hddnum=( $(ls /dev/sd?) )
#FIRSTNWADAPTER=`for i in "${arr[@]}"; do echo $i; done | awk -F"-" '{print $2}'  | head -1`
FIRSTNWADAPTER=${arr[0]}
#SECONDNWADAPTER=`for i in "${arr[@]}"; do echo $i; done | awk -F"-" '{print $2}'  | tail -1`
SECONDNWADAPTER=${arr[1]}
harddisk=`for i in "${hddnum[@]}"; do echo $i; done | sed 's/^.\{5\}//'`
ETH0=`ifconfig -a | grep $FIRSTNWADAPTER | awk '{print $1}'`
IPADDRETH0=`ifconfig -a | grep "inet addr" | head -1 | cut -d":" -f2 | awk '{print $1}'`
#eth1gw=`route -n | egrep "Gateway|$FIRSTNWADAPTER" | grep -v Gateway | head -1 | awk -F" " '{print $2}'`
eth1gw=`cat /etc/sysconfig/network-scripts/ifcfg-$FIRSTNWADAPTER | grep GATEWAY | awk -F"=" '{print $2}'`
#eth2gw=`route -n | egrep "Gateway|$SECONDNWADAPTER"| grep -v Gateway | tail -1 | awk -F" " '{print $2}'`
eth2gw=`cat /etc/sysconfig/network-scripts/ifcfg-$SECONDNWADAPTER | grep GATEWAY | awk -F"=" '{print $2}'`
ETH1=`ifconfig -a | grep $SECONDNWADAPTER| awk '{print $1}'`
IPADDRETH1=`ifconfig -a | grep "inet addr" | head -2  | cut -d":" -f2 | awk '{print $1}'|tail -1`
NETMASK1=`cat /etc/sysconfig/network-scripts/ifcfg-$FIRSTNWADAPTER | grep NETMASK | awk -F"=" '{print $2}'`
NETMASK2=`cat /etc/sysconfig/network-scripts/ifcfg-$SECONDNWADAPTER | grep NETMASK | awk -F"=" '{print $2}'`

##### Hardware information on the system  #####

SERIAL=`dmidecode | grep -i "Serial Number" | uniq -c | head -1 | awk -F" " '{print $4}'`
PRODUCT=`dmidecode | grep -i "Product Name" | head -1 | awk -F":" '{print $2}'`
ARCH=`lscpu | grep Architecture | awk -F":" '{print $2}'`
CPUOPS=`lscpu | grep op-mode | awk -F":" '{print $2}'`
CPUCOUNT=`lscpu | grep "CPU(s):" | awk -F":" '{print $2}'`


#Display Hardware/System informations

echo -e "\e[00;35mhostname       \e[00m" : $HOSTNAME
echo -e "\e[00;35muptime(HH:MM) \e[00m " : $UPTIME
echo -e "\e[00;35mRAM   \e[00m         " : $TOTALRAM
echo -e "\e[00;35mkernel version \e[00m" : $KERVER
echo -e "\e[00;35mOS version     \e[00m" : $OSVER
echo -e "\e[00;35mhdd            \e[00m" : $harddisk

echo -e "\e[00;35mcpu            \e[00m" : $CPUINFO
echo -e "\e[00;35mcpu speed      \e[00m" : $CPUSPEED
echo -e "\e[00;35mserial         \e[00m" : $SERIAL
echo -e "\e[00;35mproduct        \e[00m" : $PRODUCT
echo -e "\e[00;35march           \e[00m" : $ARCH
echo -e "\e[00;35mcpuarch        \e[00m" : $CPUOPS
echo -e "\e[00;35mcpucount       \e[00m" : $CPUCOUNT

### Displaying ethernet adapters

#echo -e "\e[00;35methadapters    \e[00m"               : $ETHCOUNT
echo -e "\e[00;35m$FIRSTNWADAPTER    \e[00m       " : $IPADDRETH0
echo -e "\e[00;35mGateway        \e[00m"              : $eth1gw
echo -e "\e[00;35mGenmask        \e[00m"             : $NETMASK1
echo -e "\e[00;35m$SECONDNWADAPTER    \e[00m       "  : $IPADDRETH1
echo -e "\e[00;35mGateway        \e[00m"               : $eth2gw
echo -e "\e[00;35mGenmask        \e[00m"             : $NETMASK2

;;

*)
echo "This script is designed only for Redhat/SuSE"
;;
esac

