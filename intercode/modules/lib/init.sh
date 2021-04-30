


# Set your default inputs to true or false 
CI="${CI:-false}" [[ $CI == "false" ]] || CI='true'
INPUT1="${INPUT1:-false}" [[ $INPUT1 == "false" ]] || INPUT1='true'
INPUT2="${INPUT2:-false}" [[ $INPUT2 == "false" ]] || INPUT2='true'

LIB_PATH=$(realpath $(dirname "${BASH_SOURCE[0]}"))
REPO_PATH=$(realpath "$LIB_PATH/../")
SCRIPT_PATH=$(realpath "$(dirname $0)")
