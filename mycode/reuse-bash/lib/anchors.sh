

# A Library of fundamental values
# Intended for use by other scripts, not to be executed directly

# Set non-'false' by nearly every CI system in existence.
CI="${CI:-false}"  # true: _unlikely_ human-presence at the controls.
[[ $CI == "false" ]] || CI='true'  # Err on the side of automation

LIB_PATH=$(realpath $(dirname "${BASH_SOURCE[0]}"))
REPO_PATH=$(realpath "$LIB_PATH/../")  # Specific to THIS repository
SCRIPT_PATH=$(realpath "$(dirname $0)")
