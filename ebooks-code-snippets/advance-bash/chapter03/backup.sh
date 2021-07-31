#!/bin/bash

# backup modified files in last day 

BACKUPFILE=backup-$(date +%m-%d-%Y)

archive=${1:-$BACKUPFILE}

find . mtime -1 -type f -print0 | xargs -0 tar -rvf "$archive.tar"

exit 0


