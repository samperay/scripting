#!/bin/bash 

# Write a script that upon invocation shows the time and date, lists all logged-in users, and gives the
# system uptime. The script then saves this information to a logfile


DATE=$(date)
USERS=$(who | awk -F' ' '{print $1}')
UPTIME=`uptime`
FILE=userslog

# Start of the script, nullfying the file 
>$FILE

echo "Date: $DATE" >>$FILE
echo "Users: $USERS" >> $FILE
echo "Uptime: $UPTIME ">>$FILE
echo "File has been saved !"
