#!/bin/bash
REMOTE=${REMOTE:-https://github.com/krettis/cohoast.git}
TMPDIR=${TMPDIR:-/tmp}
DEST=${DEST:-${TMPDIR}/cohoast-master}
CURRENT_FOLDER="$(pwd)"


warn (){
  echo -e "\033[1;36mWarning: \033[1;37m$1\033[0;39m" > /dev/tty
}
message (){
  echo -e "\033[0;34mInfo: \033[1;37m$1\033[0;39m" > /dev/tty
}
an_error_occurred () {
  >&2 echo -e "\033[0;31mError:\033[1;31m $1\033[0;39m"
}


## test if command exists
ftest () {
  message "Checking for ${1}..."
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
      an_error_occurred "Missing \`${f}'! Make sure it exists and try again."
      return 1
    }
  done
  return 0
}

## main clone_cohoast
clone_cohoast()
{
  local passed=1
  message "Welcome to the 'cohoast' installer!"
  ## test for require features
  features git || return $?

  ## build
  {
    cd "${TMPDIR}"
    message "Creating temporary files..."
    test -d "${DEST}" && { warn "Already exists: '${DEST}'"; }
    rm -rf "${DEST}"
    message "Fetching latest 'cohoast'..."
    git clone --depth=1 "${REMOTE}" "${DEST}" > /dev/null 2>&1
  } >&2

  if [ ! "$?" -eq 0 ];then
    an_error_occurred "Cloning the github repo failed"
    passed=0
  fi
  return $passed
}

# INSTALLATION for the man page
install_man_page () {
  local manfolder=
  local folder_cohoast=

  manfolder="$(get_man_folder)"
  folder_cohoast=$(pwd)

  if [ "$manfolder" ]; then
    sudo cp "${folder_cohoast}/man/cohoast.1" "${manfolder}/"
    message "Installed the manual (man cohoast)"
  else
    an_error_occurred "Failed to install manual"
  fi
}

# currently only osx
get_man_folder () {
  local man_folder=
  if [ -d "/usr/share/man/man1" ]; then
    man_folder="/usr/share/man/man1"
  fi
  echo "$man_folder"
}

# INSTALL THE COHOAST CALL
call_in_profile () { 
  message "Trying to install cohoast call in profile..."

  cd "${DEST}"
  folder_cohoast=$(pwd)
  profile_file=''
  if [ "$(uname)" == "Darwin" ]; then
    profile_file='.bash_profile'
  elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    profile_file='.bashrc'
  elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    message "Sorry windows is not supported for installation.\n Feel free to add this to your profile"
    return;
  fi

  function_to_insert="\n# Edit your hostfile within the terminal\nfunction cohoast() { . ${folder_cohoast}/run.sh \$@ ;}"
  $(echo -e $function_to_insert >> ~/$profile_file) && source ~/$profile_file && source "${folder_cohoast}/.dot/.functions"


  if ! chfn_exists cohoast; then
    warn "Something went wrong :(\n
    Try to add the function manually in your profile: \n
    \n$function_to_insert\n"
  fi

  return;
}

finalize(){
  cd "$CURRENT_FOLDER"
  if [ $? -eq 0 ]; then
    message "Installation completed!\nType '\033[0;36mcohoast\033[1;37m' to execute or '\033[0;36mman cohoast\033[1;37m' for the manual"
  fi
}

if [ -z "$1" ]; then
  clone_cohoast
else
 DEST="$1"
fi
call_in_profile
install_man_page
finalize

