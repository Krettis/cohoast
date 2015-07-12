#!/bin/bash
# 
# MENU
keep_menu=1

while [ "$keep_menu" ]
do
  use_manual=0
  message=
  clear
  echo "$banner_menu"
  echo -e "Please select your action for the use of cohoast\n"
  select menuselect in "$menu_option_add_host" "$menu_option_backup" "$menu_option_quit"; do
    case "$menuselect" in
    "$menu_option_add_host" )
      use_manual=1
      break;;
     "$menu_option_backup" )
        backup_host_file "$BACK_FILE"
        message="\n""$lng_backup_success"
        break;;
      "$menu_option_quit" )
        keep_menu=
        clear
        return;
    esac
  done


  # MANUAL ADD
  #--------------------------------------------
  if [ "$use_manual" -eq 1 ]; then
  ## get information
    category=$(giveprompt "${lng_which_category}" "$DEFAULT_CATEGORY")
    ipaddress=$(giveprompt "${lng_add_ipaddress}" "$DEFAULT_IP") 
    portnumber=$(giveprompt "${lng_add_port}" "$DEFAULT_PORT")
    hostname=$(giveprompt "${lng_add_virtual_host}" "")

    backup_host_file "$BACK_FILE"
    source "$DIR".dot/addhost.sh
    addHost
    message="$lng_add_success"
  fi

  echo -e "$message"
  sleep 1
done
