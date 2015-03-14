#!/bin/bash

SUCCESS=0

### CONFIGURATION ###
#--------------------------------------------
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"/"
#HOSTS_FILE="/etc/hosts"
HOSTS_FILE=$DIR"hosts.txt"
BACK_FILE=$DIR"backup/hosts.backup.txt"
LOCALHOST="127.0.0.1"
PORT="80"
DEFAULTCATEGORY="uncategorized"
SUPPORTED_LANGUAGES=( "en" "nl" )
DEFAULT_LANG="en"


### LOAD FILES 
#--------------------------------------------
source $DIR.dot/.functions
source $DIR.dot/.art

locale_found=$(locale | grep LANG | cut -d= -f2 | cut -d_ -f1 | cut -d\" -f2)
if [ $(in_array "${SUPPORTED_LANGUAGES[@]}" $locale_found) == "y" ]; then
    lang=$locale_found 
else
    lang=$DEFAULT_LANG
fi
source $(echo ".dot/lang/."$lang)


echo "$banner_menu"
echo -e "Please select your action for the use of cohost\n"
select menuselect in "$menu_option_add_host" $menu_option_quit; do
	case $menuselect in
		"$menu_option_add_host" )
			echo "ok"
			break;;
		$menu_option_quit )
			return;
	esac
done

# MANUAL ADD
#--------------------------------------------

## get information
category=$(giveprompt "${lng_which_category}" $DEFAULTCATEGORY)
ipaddress=$(giveprompt "${lng_add_ipaddress}" $LOCALHOST) 
portnumber=$(giveprompt "${lng_add_port}" $PORT)
hostname=$(giveprompt "${lng_add_virtual_host}" "")
echo -e "here are your answers:\n\n\t\t:: CATEGORY - $category\n\n\t\t$ipaddress:$portnumber\t$hostname\n\n"

## backup
current_time=$(date "+%Y%m%d-%H%M%S")
backup_comment=$(printf "# This is a backup from %s , made automatically. Only use this when the host file seems to be broken\n" $current_time) 
echo $backup_comment > $BACK_FILE
cat hosts.txt >> $BACK_FILE


categoryformat="\n\n\n\n\t#####\n\t## $category\n\t#####\n\n\n" 
lineformat=$(echo -e "$ipaddress:$portnumber\t$hostname\r")

sed '/'"$lineformat"'/ d' hosts.txt > hosts.tmp
foundcategory=$(sed -n '/'"## $category"'/ =' hosts.tmp)
lineappend=3


if [[ $foundcategory == '' ]] ; then
	echo -e "$categoryformat" >> hosts.tmp
       lineappend=6
fi

insertline=$(($foundcategory+$lineappend))
echo $founcategory"linenumber:: "$insertline
sed  "$insertline"'a\
	'"$lineformat" hosts.tmp > hosts.txt





# CLEANUP
#--------------------------------------------

#unset PORT LOCALHOST
unset $banner_menu
> hosts.tmp
rm -f hosts.tmp
