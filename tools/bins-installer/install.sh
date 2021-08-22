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

SUPPORTED_TARGETS="x86_64-apple-darwin"


has() {
  command -v "$1" 1>/dev/null 2>&1
}

error() {
  printf '%s\n' "${RED}x $*${NO_COLOR}" >&2
}

info() {
  printf '%s\n' "${BOLD}${GREY}>${NO_COLOR} $*"
}

warn() {
  printf '%s\n' "${YELLOW}! $*${NO_COLOR}"
}

completed() {
  printf '%s\n' "${GREEN}✓${NO_COLOR} $*"
}

usage() {
cat << EOF
install.sh [ option ]

Fetch and install the latest version of binary, if the binary is
installed it will be udpated to latest version.

Options
  -b, --base-dir
    Override the bin installation directory [default: ${BIN_DIR}]

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

detect_platform(){
  platform="$(uname -s | tr '[:upper:]' '[:lower:]')"

  case "${platform}" in
    darwin) platform="apple-darwin";;
    linux)  platform="linux"
  esac

  printf '%s' "${platform}"
}

detect_arch() {
  arch="$(uname -m | tr '[:upper:]' '[:lower:]')"

  case "${arch}" in
    amd64) arch="x86_64" ;;
  esac

  printf '%s' "${arch}"
}

detect_target() {
  arch="$1"
  platform="$2"
  target="$arch-$platform"
  printf '%s' "${target}"
}

# Check for build available
is_build_available() {
  arch="$1"
  platform="$2"
  target="$3"

  good=$(
    IFS=" "
    for t in $SUPPORTED_TARGETS; do
      if [ "${t}" = "${target}" ]; then
        printf 1
        break
      fi
    done
  )

  if [ "${good}" != "1" ]; then
    error "${arch} build for ${platform} not available"
    printf "\n" >&2
    exit 1
  fi
}

confirm() {
  printf "%s " "${MAGENTA}?${NO_COLOR} $* ${BOLD}[y/n]${NO_COLOR}"
  set +e
  read -r yn </dev/tty
  rc=$?
  set -e
  if [ $rc -ne 0 ]; then
    error "Error reading from prompt (please re-run with the 'y/n' option)"
    exit 1
  fi

  if [ "$yn" != "y" ] && [ "$yn" != "yes" ]; then
    error 'Aborting (please answer "y" to continue)'
    exit 1
  fi
}

check_bin_dir() {
  bin_dir="$1"

  if [ ! -d "${BIN_DIR}" ]; then
    erorr "install location doesn't appear to be directory"
    info "make sure the location exists & is a directory, then try again"
    usage
    exit 1
  fi

  good=$(
    IFS=:
      for path in ${PATH}; do
        if [ "${path}" = "${bin_dir}" ]; then
          printf 1
          break
        fi
      done
  )

  if [ "${good}" != "1" ]; then
    warn "Bin directory ${bin_dir} not in your \$PATH"
  fi
}

install() {
  ext="$1"

  if test_writable "${BIN_DIR}"; then
    sudo=""
    msg="installaing startship, please wait.."
  else
    warn "escalated permissions are required to install to ${BIN_DIR}"
    elevate_priv
    sudo="sudo"
    msg="installaing startship as root, please wait.."
  fi

  info "$msg"

  archive=$(get_tmpfile "$ext")
  download "${archive}" "${URL}"
  unpack "${archive}" "${BIN_DIR}" "${sudo}"
}

test_writable() {
  path="${1:-}/test.txt"
  if touch "${path}" 2>/dev/null; then
    rm ${path}
    return 0
  else
    return 1
  fi
}

elevate_priv() {
  if ! has sudo; then
    error 'cannot find sudo command, please install sudo'
    exit 1
  fi

  if ! sudo -v; then
    error "superuser not granted, aborting.."
    exit 1
  fi
}

get_tmpfile() {
  suffix="$1"
  if has mktmp; then
    printf "%s.%s" "$(mktemp)" "${suffix}"
  else
    printf "/tmp/starship.%s" "${suffix}"
  fi
}

download() {
  file="$1"
  url="$2"

  if has curl; then
    cmd="curl --fail --silent --location --output $file $url"
  elif has wget; then
    cmd="wget --quiet --output-document=$file $url"
  elif has fetch; then
    cmd="fetch --quiet --output=$file $url"
  else
    error "No HTTP download program(curl,wget,fetch) found, exiting.."
    return 1
  fi

  $cmd && return 0 || rc=$?

  error "command failed(exit code $rc)"
  printf "\n" >&2
  info "mainly starship not supporting config"
  return $rc
}

unpack() {
  archive=$1
  bin_dir=$2
  sudo=${3-}
  flags=$(test -n "${VERBOSE-}" && echo "-xzvf" || echo "-xzf")
  $sudo tar "${flags}" "${archive}" -C "${bin_dir}"
  return 0
}

# set the defaults incase no option explictily defined by user
if [ -z "${PLATFORM-}" ]; then
  PLATFORM="$(detect_platform)"
fi

if [ -z "${BIN_DIR-}" ]; then
  BIN_DIR=/usr/local/bin
fi

if [ -z "${ARCH-}" ]; then
  ARCH="$(detect_arch)"
fi

if [ -z "${BASE_URL-}" ]; then
  BASE_URL="https://github.com/starship/starship/releases"
fi

# verbose while untarring the package
if [ -n "${VERSOSE-}" ]; then
  VERBOSE=v
  info "${BOLD}Verbose${NO_COLOR}: yes"
else
  VERBOSE=
fi

# parse argv variables
while [ "$#" -gt 0 ]; do
  case "$1" in
    -b | --bin-dir)
      BIN_DIR="$2"
      shift $2
      ;;
    -v | --verbose)
      VERBOSE=1
      shift $2
      ;;
    -h | --help)
      usage
      exit
      ;;
    -b=* | --bin-dir=*)
      BIN_DIR="${1#*=}"
      shift 1
      ;;
    -v=* | --verbose=*)
      VERBOSE="${1#*=}"
      shift 1
      ;;
    *) error "Unknown Option: $1"
       usage
       exit 1
      ;;
  esac
done

# Start of the main program
TARGET="$(detect_target "${ARCH}" "${PLATFORM}")"
is_build_available "${ARCH}" "${PLATFORM}" "${TARGET}"
info "${BOLD}Bin directory${NO_COLOR}: ${GREEN}${BIN_DIR}${NO_COLOR}"
info "${BOLD}Platform${NO_COLOR}:      ${GREEN}${PLATFORM}${NO_COLOR}"
info "${BOLD}Arch${NO_COLOR}:          ${GREEN}${ARCH}${NO_COLOR}"
EXT=tar.gz
URL="${BASE_URL}/latest/download/starship-${TARGET}.${EXT}"
info "Tarball URL: ${UNDERLINE}${BLUE}${URL}${NO_COLOR}"
confirm "Install Starship ${GREEN}latest${NO_COLOR} to ${BOLD}${GREEN}${BIN_DIR}${NO_COLOR}?"
check_bin_dir "${BIN_DIR}"

install "${EXT}"
completed "Starship installed"
