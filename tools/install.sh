# This script can be used as a reference for writing any scripts
# that can be used as an installer.

#!/usr/bin/env sh
set -eu

# Plan Of Action
: '
- Define your terminal output colors, variables to be used globally...etc
- Write an function to detect e.g platform, arch, target.
- Check if build is available from the repository URL.
- Prompt to install the binary.
- Set path for the binary to install in /usr/local/bin
- Install function to be called
  - Check for the binary path writable i.e sudo permission exists ?
  - if sudo exists, then elevate the privilidges
  - download from the path
  - unpack the binary to the path
- Exception handling for vars, case statements, etc 
'

# Set terminal colors
BOLD="$(tput bold 2>/dev/null || printf '')"
GREY="$(tput setaf 0 2>/dev/null || printf '')"
UNDERLINE="$(tput smul 2>/dev/null || printf '')"
RED="$(tput setaf 1 2>/dev/null || printf '')"
GREEN="$(tput setaf 2 2>/dev/null || printf '')"
YELLOW="$(tput setaf 3 2>/dev/null || printf '')"
BLUE="$(tput setaf 4 2>/dev/null || printf '')"
MAGENTA="$(tput setaf 5 2>/dev/null || printf '')"
NO_COLOR="$(tput sgr0 2>/dev/null || printf '')"

has() {
  command -v "$1" 1>/dev/null 2>&1
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

usage() {
cat << EOF
install.sh [ option ]

Fetch and install the latest version of binary, if the binary is
installed it will be udpated to latest version.

Options
  -V, --verbose
    Enable verbose output for the installer

  -f, -y, --force, --yes
    Skip the confirmation prompt during installation

  -p, --platform
    Override the platform identified by the installer [default: ${PLATFORM}]

  -h, --help
    Dispays this help message
EOF
}

# check for sudo binary installed
if ! has sudo; then
  error 'Could not find the command "sudo", need to get permission for install.'
  info "rerun this script. Otherwise, please run this script as root, or install sudo"
  exit 1
fi

# check for sudo permission granted
if ! has sudo -v; then
  error "superuser not granted, aborting.."
  exit 1
fi

# find your platform
detect_platform(){
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

  case "${platform}" in
    darwin) platform="apple-darwin";;
    linux) platform="linux"
  esac
}

if [ -z "${PLATFORM-}" ]; then
  PLATFORM="$(detect_platform)"
  echo ${PLATFORM}
fi

# parse argv variables
while [ "$#" -gt 0 ]; do
  case "$1" in
    -h | --help)
      usage
      exit
      ;;
    *) error "Unknown Option: $1"
       usage
       exit 1
      ;;
  esac
done
