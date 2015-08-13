#!/bin/bash
# MENU
keep_menu=1

# shellcheck disable=SC2154
while [ "$keep_menu" ]
do
  manual_add=0
  manual_remove=0
  message=
  clear
  echo "$banner_menu"
  echo -e "Please select your action for the use of cohoast\n"
  select menuselect in \
    "$menu_option_add_host"\
    "$menu_option_remove_host"\
    "$menu_option_backup"\
    "$menu_option_quit"\
    ; do
    case "$menuselect" in
    "$menu_option_add_host" )
      manual_add=1
      break;;
    "$menu_option_remove_host" )
      manual_remove=1
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
  if [ "$manual_add" -eq 1 ]; then
  ## get information
    category=$(giveprompt "${lng_which_category}" "$DEFAULT_CATEGORY")
    ipaddress=$(giveprompt "${lng_add_ipaddress}" "$DEFAULT_IP") 
    portnumber=$(giveprompt "${lng_add_port}" "$DEFAULT_PORT")
    hostname=$(giveprompt "${lng_add_virtual_host}" "")

    backup_host_file "$BACK_FILE"
    source "${DIR}.dot/add_host.sh"
    addHost "$category" "$ipaddress" "$portnumber" "$hostname"
    if [ $? -eq 1 ]; then
      message="$lng_add_success"
    fi
  fi

  # MANUAL REMOVE
  #--------------------------------------------
  if [ "$manual_remove" -eq 1 ]; then
    hostname_to_delete=$(giveprompt "${lng_prompt_remove_host}" "")
    backup_host_file "$BACK_FILE"
    source "$DIR".dot/remove_host.sh

    find_host_name=$(found_host "$hostname_to_delete") 
    if [ -z "$find_host_name" ]; then
      error_message "$lng_remove_nohost"
    else
      remove_host "$hostname_to_delete"
      message="$lng_remove_success"
    fi
  fi
  echo -e "$message"
  sleep 1
done
