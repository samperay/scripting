#!/bin/bash

echo "Print System Information"
LIB_PATH="$PWD/$(dirname $0)/../lib/uname.env"
source $LIB_PATH 
# system values that are imported from the lib modules 
# system values that are imported from the lib modules
echo "KERNEL: $KERNEL_NAME"
echo "NODENAME: $NODENAME"
echo "KERNEL_RELEASE: ${KERNEL_RELEASE}"
echo "KERNEL_VERSION: ${KERNEL_VERSION}"
echo "HARDWARE_VERSION: $HARDWARE_VERSION"
echo "OS: $OS"
echo "PROCESSOR: $PROCESSOR"
