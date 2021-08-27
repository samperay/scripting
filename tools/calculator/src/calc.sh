LIBPATH="${PWD}/$(dirname $0)/../lib"
source ${LIBPATH}/setup.env
source ${LIBPATH}/calculations.sh

set -x
# Start of the program
while [ "$#" -gt 0 ]; do
  case "$1" in
    -s| -sum)
      sum "$@"
      echo "Sum: " $?
      exit 0
      ;;
    -d| -diff)
      diff "$@"
      echo "Difference: " $?
      exit 0
      ;;
    -m| -mul)
      mul "$@"
      exit 0
      ;;
      *)
        usage
        exit 1
      ;;
  esac
done
