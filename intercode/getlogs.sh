#!/bin/bash 

# Get around n log lines of the files using the script. 
# The script shoud nullify all the contanets of the previous logs and are required to write only certain loglines 
# to the files. 


# Assign the vars
ROOT_UID=0
LINES=$2
LOG_DIR=/var/log


# Check for two arguments
if [ $# -ne 2 ]
then
  echo "Usage: ./getlogs log_file_name log_lines"
  exit 1
fi

# Check for authorization of the user
if [[ ${UID} -ne ${ROOT_UID} ]]
then
  echo "INFO: Non root user.. exiting"
fi

# Get total number of input lines from the command line or else it defalts to 50
if [ -n $2 ]
then 
  lines=$2
else
  lines=${LINES}
fi

# log into the log directory

if [[ -d ${LOG_DIR} ]]
then
  tail -n ${LINES} ${LOG_DIR}/$1 > /tmp/$1.temp
  mv /tmp/$1.temp ${LOG_DIR}/$1
  echo "INFO: Log Files Cleaned"
else
  echo "INFO: Unable to find the directory"
  exit 1
fi
