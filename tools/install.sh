#!/usr/bin/env sh

set -eu
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
  printf '%s' "${platform}"
}

if [ -z "${PLATFORM-}" ]; then
  PLATFORM="$(detect_platform)"
fi

# parse argv variables
while [ "$#" -gt 0 ]; do
  case "$1" in
    -h | --help)
      usage
      exit
      ;;
  esac
done
