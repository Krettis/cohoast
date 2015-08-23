#!/bin/bash

# shellcheck disable=SC2154,SC1004
function addHost
{
  local category="$1"
  local ipaddress="$2"
  local portnumber="$3"
  local hostname="$4"

  local current_date
  local file_format
  local category_name
  local category_format
  local line_format
  local line_append=7
  local insert_at_line_nr=0

  local line_found_category

  current_date=$(date "+%Y-%m-%d")
  file_format=${DIR}".dot/art/category.txt"
  category_name=$(echo "$category" | tr '[:lower:]' '[:upper:]')
  category_format="\n$(sed 's/CATEGORYNAME/'"$category_name"'/g' <  "$file_format" | sed 's/nr/##/g' | sed 's/date_c/'"$current_date"'/g' | sed 's/date_u/0000-00-00/g')\n\n\n\n\n\n"
  line_format=$(echo -e "$ipaddress:$portnumber\t$hostname\n")

  # Check if incoming is defined
  if [ ! $# -eq 4 ] || [ "$category" == "" ] || [ "$ipaddress" == "" ] || [ "$portnumber" == "" ] || [ "$hostname" == "" ]; then
    error_message "$lng_add_fail" 
    return
  fi

	# delete if the same line format is found
  sed '/'"$line_format"'/ d' "$FILE_HOST" > "$TEMP_FILE"

  line_found_category=$(sed -n '/'"#  $category_name"'/ =' "$TEMP_FILE")

	# A new category is added, with a different offset 
	if [[ $line_found_category == '' ]] ; then
	  line_append=$(($(wc -l < "$FILE_HOST")+11))
    echo -e "$category_format" >> "$TEMP_FILE"
	fi

	# adding the the new line of 
	insert_at_line_nr=$((line_found_category+line_append))
	atdf='a\
		'$line_format' \
		' 
	sed  "$insert_at_line_nr""$atdf" hosts.tmp > "$FILE_HOST"
  
	return 1
	echo -e "\nAdding the following\n\nHostname: ${hostname}\nPortnumber: ${portnumber}\nCategory: ${category}\nIn file: ${FILE_HOST}\n"

	echo "Found category on line: ${line_found_category}"
	echo "linenumber:: ${insertline}"
	echo "Inserted at line number: ${insert_at_line_nr}"
	echo -e "text category: $category_name \nline: ${line_format}"
}

#EOF
