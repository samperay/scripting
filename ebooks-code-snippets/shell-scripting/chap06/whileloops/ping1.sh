#!/bin/bash
host=${1:-127.0.0.1}
echo $host
while ping -c3 $host
do
  sleep 10
done
echo "$host has stopped responding to pings"
