#!/bin/bash

addHost(){

	# config
	local current_date=$(date "+%Y-%m-%d")
	local file_format=${DIR}".dot/art/category.txt"
	local category_name=$(echo $category | tr '[:lower:]' '[:upper:]')
	local category_format="\n"$(cat $file_format | sed 's/CATEGORYNAME/'$category_name'/g' | sed 's/nr/##/g' | sed 's/date_c/'$current_date'/g' | sed 's/date_u/0000-00-00/g')"\n\n\n\n\n\n"
	local line_format=$(echo -e "$ipaddress:$portnumber\t$hostname\n")
	local line_append=7
	local insert_at_line_nr=0


	# delete if the same line format is found
	sed '/'"$line_format"'/ d' $HOSTS_FILE > hosts.tmp

	local line_found_category=$(sed -n '/'"#  $category_name"'/ =' hosts.tmp)

	# A new category is added, with a different offset 
	if [[ $line_found_category == '' ]] ; then
	  line_append=$(($(cat $HOSTS_FILE | wc -l)+11))
		echo -e "$category_format" >> hosts.tmp
	fi

	# adding the the new line of 
	insert_at_line_nr=$(($line_found_category+$line_append))
	atdf='a\
		'$line_format' \
		' 
	sed  "$insert_at_line_nr""$atdf" hosts.tmp > $HOSTS_FILE

	return	
	echo -e "\nAdding the following\n\nHostname: "$hostname"\nPortnumber: "$portnumber"\nCategory: "$category"\nIn file: "$HOSTS_FILE"\n"

	echo "Found category on line: "$line_found_category
	echo "linenumber:: "$insertline
	echo "Inserted at line number: "$insert_at_line_nr
	echo -e "text category: "$category_name" \nline: "$line_format
}

