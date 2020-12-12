#!/bin/bash 

# File Operatuions
# -b FILE - True if the FILE exists and is a block special file.
# -c FILE - True if the FILE exists and is a special character file.
# -d FILE - True if the FILE exists and is a directory.
# -e FILE - True if the FILE exists and is a file, regardless of type (node, directory, socket, etc.).
# -f FILE - True if the FILE exists and is a regular file (not a directory or device).
# -G FILE - True if the FILE exists and has the same group as the user running the command.
# -h FILE - True if the FILE exists and is a symbolic link.
# -g FILE - True if the FILE exists and has set-group-id (sgid) flag set.
# -k FILE - True if the FILE exists and has a sticky bit flag set.
# -L FILE - True if the FILE exists and is a symbolic link.
# -O FILE - True if the FILE exists and is owned by the user running the command.
# -p FILE - True if the FILE exists and is a pipe.
# -r FILE - True if the FILE exists and is readable.
# -S FILE - True if the FILE exists and is socket.
# -s FILE - True if the FILE exists and has nonzero size.
# -u FILE - True if the exists and set-user-id (suid) flag is set.
# -w FILE - True if the FILE exists and is writable.
# -x FILE - True if the FILE exists and is executable.

# Check file exists 

FILE=/etc/passwd

# Method - 1
if test -f ${FILE};
then 
  echo "Method-1: File Exists"
else
  echo "Error: File Not Found"
fi


# Method - 2
test -f ${FILE} && echo "Method-2: File Exists"

# Method -3 
[ -f ${FILE} ] && echo "Method-3: File Exists" 
      
    # or 

[[ -f ${FILE} ]] && echo "Method-4: File Exists"

