#!/bin/bash
REMOTE=${REMOTE:-https://github.com/krettis/cohoast.git}
TMPDIR=${TMPDIR:-/tmp}
DEST=${DEST:-${TMPDIR}/cohoast-master}

## test if command exists
ftest () {
  echo "  info: Checking for ${1}..."
  if ! type -f "${1}" > /dev/null 2>&1; then
    return 1
  else
    return 0
  fi
}

## feature tests
features () {
  for f in "${@}"; do
    ftest "${f}" || {
      echo >&2 "  error: Missing \`${f}'! Make sure it exists and try again."
      return 1
    }
  done
  return 0
}

## main setup
setup () {
  echo "  info: Welcome to the 'cohoast' installer!"
  ## test for require features
  features git || return $?

  ## build
  {
    echo
    cd "${TMPDIR}"
    echo "  info: Creating temporary files..."
    test -d "${DEST}" && { echo "  warn: Already exists: '${DEST}'"; }
    rm -rf "${DEST}"
    echo "  info: Fetching latest 'cohoast'..."
    git clone --depth=1 "${REMOTE}" "${DEST}" > /dev/null 2>&1
    cd "${DEST}"
    install_man_page
  } >&2
  return $?
}

# INSTALLATION for the man page
install_man_page () {
  set -v
  local manfolder=
  local folder_cohoast=
  local message="Failed to install manual"

  manfolder="$(get_man_folder)"
  folder_cohoast=$(pwd)

  if [ "$manfolder" ]; then
    cp "${folder_cohoast}/man/cohoast.1" "${manfolder}/"
    message="Installed the manual (man cohoast)"
  fi
  echo "$message"
  call_in_profile
}

# currently only osx
get_man_folder () {
  local man_folder=
  if [ -d "/usr/share/man/man1"]; then
    man_folder="/usr/share/man/man1"
  fi
  echo "$man_folder"
}

# INSTALL THE COHOAST CALL
call_in_profile () { 
  echo "Trying to install cohoast call in profile..."

  folder_cohoast=$(pwd)
  profile_file=''
  if [ "$(uname)" == "Darwin" ]; then
    profile_file='.bash_profile'
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    profile_file='.bashrc'
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    echo "Sorry windows is not supported for installation.\n Feel free to add this to your profile"
    return;
  fi

  function_to_insert="\n# Edit your hostfile within the terminal\nfunction cohoast() { . ${folder_cohoast}/run.sh \$@ ;}"
  echo $function_to_insert >> ~/$profile_file && source ~/$profile_file && source "${folder_cohoast}/.dot/.functions"


  if chfn_exists cohoast; then
    echo "Installation completed!"
    echo "Type 'cohoast' to execute or 'man cohoast' for the manual"
  else 
    echo "Something went wrong :("
    echo "Try to add the function manually in your profile: \n"
    echo -e "\n$function_to_insert\n"
  fi

  return;
}

setup

