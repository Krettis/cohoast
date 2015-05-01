#!/bin/bash

VERSION=0.0.6
RELEASE_NAME="SAND"

### CONFIGURATION ###
#--------------------------------------------
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/"
HOSTS_FILE=$DIR"hosts.txt"
BACK_FILE=$DIR"backup/hosts.backup.txt"
LOCALHOST="127.0.0.1"
PORT="80"
DEFAULT_CATEGORY="uncategorized"
SUPPORTED_LANGUAGES=( "en" "nl" )
DEFAULT_LANG="en"

### LOAD FILES 
#--------------------------------------------
source $DIR.dot/.config
source $DIR.dot/.functions
source $DIR.dot/.art

locale_found=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1 | cut -d\" -f2)
if [ $(in_array "${SUPPORTED_LANGUAGES[@]}" $locale_found) == "y" ]; then
    lang=$locale_found 
else
    lang=$DEFAULT_LANG
fi
source $(echo $DIR".dot/lang/."$lang)

if ! chfn_exists cohoast; then
	source .dot/install.sh
	return;
fi 
use_manual=0
ch_options=(add block help)

### CONTROLLER
#--------------------------------------------
if [ $# -eq 0 ]; then

	## MENU	
	clear
	echo "$banner_menu"
	echo -e "Please select your action for the use of cohost\n"
	select menuselect in "$menu_option_add_host" $menu_option_quit; do
		case $menuselect in
			"$menu_option_add_host" )
				echo "ok"
				use_manual=1
				break;;
			$menu_option_quit )
				clear
				return;
		esac
	done
elif [ $(in_array "${ch_options[@]}" $1) == "y" ]; then

	if [ $1 == "add" ]; then
		if [ $# -gt 1 ]; then
			category=$DEFAULT_CATEGORY
			ipaddress=$LOCALHOST	
			portnumber=$PORT
			hostname=

			args=`getopt abo: $*`
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

			if [ -z $hostname ]; then
				show_usage add
				return
			fi

			backup_host_file $BACK_FILE
			source $DIR.dot/addhost.sh
			addHost
		else
			show_usage add
		fi
	elif [ $1 == "block" ]; then
		category=$BLOCK_CATEGORY
		ipaddress=$BLOCK_IP 
		portnumber=0

		if [ -z $2 ]; then
			show_usage block
			return
		fi

		hostname=$(dig +short -x $2)
		if [ -z $hostname ]; then
			echo $lng_block_nohost
			return
		fi

		source $DIR.dot/addhost.sh
		addHost
	else
		show_usage
	fi
else
	## NOTHING FOUND EXIT
	show_usage
	return
fi


# MANUAL ADD
#--------------------------------------------
if [ $use_manual -eq 1 ]; then
## get information
	category=$(giveprompt "${lng_which_category}" $DEFAULT_CATEGORY)
	ipaddress=$(giveprompt "${lng_add_ipaddress}" $LOCALHOST) 
	portnumber=$(giveprompt "${lng_add_port}" $PORT)
	hostname=$(giveprompt "${lng_add_virtual_host}" "")

	backup_host_file $BACK_FILE
	source $DIR.dot/addhost.sh
	addHost
fi


# CLEANUP
#--------------------------------------------

unset PORT LOCALHOST banner_menu
> hosts.tmp
rm -f hosts.tmp
