#!/bin/bash

# testing null string 


if [ "$string1" ]; then
  echo "String is NOT NULL"
else
  echo "String is NULL"
fi

exit 0
