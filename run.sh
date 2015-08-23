#!/bin/bash
VERSION=0.6.0
RELEASE_NAME="Sand"

### CONFIGURATION ###
#--------------------------------------------
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/"
TEMP_FILE="${DIR}hosts.tmp"
FILE_HOST="${DIR}hosts.txt"
BACK_DIR="${DIR}backup/"
LOCALHOST="127.0.0.1"
SUPPORTED_LANGUAGES=( "en" "nl" )
LOG=0
# temporarily, should be an array
declare lng_block_nohost
declare lng_remove_nohost

### LOAD FILES 
#--------------------------------------------
source "${DIR}.dot/.config"
source "${DIR}.dot/.functions"
source "${DIR}.dot/.art"
load_user_config
load_language
load_file_locations

if ! chfn_exists cohoast; then
  source .dot/install.sh "$(pwd)"
  return;
fi
ch_options=(add backup block remove help)


### CONTROLLER
#--------------------------------------------
if [ $# -eq 0 ]; then
  source "$DIR".dot/menu.sh
elif [ $(in_array "${ch_options[@]}" $1) == "y" ]; then

	if [ "$1" == "add" ]; then
		if [ $# -gt 1 ]; then
			category="$DEFAULT_CATEGORY"
			ipaddress="$DEFAULT_IP"
			portnumber="$DEFAULT_PORT"
			hostname=

			args=$(getopt abo: $*)
			for i
			do
		 	case "$i"
		  	in
					-i|-a|--ip)
						ipaddress="$3";shift;
						shift;;	
					-h|--hostname)
						hostname="$3";shift;
						shift;;
					-c|--category)
						category="$3";shift;
						shift;;
					-p|--port)
						portnumber="$3";shift;
						shift;;	
					--)
					shift; break;;
			esac
			done

			if [ $# -eq 2 ]; then
				hostname="$2"
			fi

			if [ -z "$hostname" ]; then
				show_usage add
				return
			fi

      backup_host_file "$BACK_FILE"
			source "$DIR".dot/add_host.sh
			addHost "$category" "$ipaddress" "$portnumber" "$hostname"
		else
			show_usage add
		fi

  elif [ "$1" == "remove" ]; then

    if [ -z "$2" ]; then
      show_usage remove
      return
    fi

    source "$DIR".dot/remove_host.sh

    find_host_name=$(found_host "$2") 
    if [ -z "$(found_host "$2")" ]; then
      error_message "$lng_remove_nohost"
      return
    fi
    backup_host_file "$BACK_FILE"
    remove_host "$2"
  elif [ "$1" == "backup" ]; then
	
		message=
		use_annotation=1
		args=$(getopt abo: $*)
		for i
		do
	 	case "$i"
	  	in
				-c|--clean)
					use_annotation=0;shift;;
				-f)
					if [ -z "$3" ]; then
						break;
					fi
					BACK_FILE="$3";shift;
					shift;;
				-m)
					if [ -z "$3" ]; then
						break;
					fi
					message="$3";shift;
					shift;;
				--)
				shift; break;;
		esac
		done

		if [ ! -z "$2" ]; then
			show_usage backup 
			return
		fi

		if [ "$use_annotation" -eq 0 ]; then
			message=0
		fi

		backup_host_file "$BACK_FILE" "$message"
	elif [ "$1" == "block" ]; then
		if [ -z "$2" ]; then
			show_usage block
			return
		fi

    source "$DIR".dot/block_host.sh
    block_host "$BLOCK_CATEGORY" "$BLOCK_IP" "$2"
    if [ $? -eq 1 ]; then
      show_usage block
    fi
	else
		show_usage
	fi
else
	args=$(getopt abo: $* 2>/dev/null)
	
	for i
	do
 	case "$i"
  	in
			-v|--version)
				echo -e "v""$VERSION"" - ""$RELEASE_NAME"
				return;shift;;
			-*)
				shift; break;;
			--)
				shift; break;;
	esac
	done

	## NOTHING FOUND EXIT
	show_usage
	return
fi


# LOG / REPORT
#---------------------------------------------
if [ "$LOG" -eq 1 ]; then
	echo "$FILE_HOST"
	echo "$BACK_DIR"
	echo "$LOCALHOST"
	for i in "${SUPPORTED_LANGUAGES[@]}"; do echo $i; done	
	echo "$category"
	echo "$ipaddress"
	echo "$hostname"
	echo "$portnumber"
fi

# CLEANUP
#--------------------------------------------
unset FILE_HOST DEFAULT_PORT LOCALHOST FILE_LOCATION_HOST FILE_LOCATION_BACKUP banner_menu
unset VERSION RELEASE_NAME
rm -f "$TEMP_FILE"
#EOF
