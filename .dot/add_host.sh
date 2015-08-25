#!/bin/bash

# shellcheck disable=SC2154,SC1004
function addHost
{
  local category="$1"
  local ipaddress="$2"
  local portnumber="$3"
  local hostname="$4"

  local character_column=16
  local characters_left
  local space=1
  local line_format
  local insert_at_line_nr
  local updated_hosts

  # Check if incoming is defined
  if [ ! $# -eq 4 ] || [ "$category" == "" ] || [ "$ipaddress" == "" ] || [ "$portnumber" == "" ] || [ "$hostname" == "" ]; then
    error_message "$lng_add_fail"
    return 1
  fi

  characters_left=$((character_column-${#ipaddress}))
  if [ $characters_left -gt 1 ]; then
    space=$(printf '%0.s ' $(seq 1 $characters_left))
  fi

  # delete if the same line format is found
  line_format=$(echo -e "${ipaddress}${space}${hostname}    #port:$portnumber")
  delete_line_format=$(echo -e "${hostname}")
  sed '/'"$delete_line_format"'/ d' "$FILE_HOST" > "$TEMP_FILE"

  # adding the the new line of
  insert_at_line_nr=$(set_category "$category")
  atdf='a'$line_format' '
  updated_hosts=$(sed  "$insert_at_line_nr""$atdf" "$TEMP_FILE")

  echo -e "$updated_hosts" > "$TEMP_FILE"
  update_hosts_file
  return 0
}

function set_category()
{
  local current_date
  local category_name
  local category_format
  local file_format
  local line_found_category
  local line_append=7
  local category_lines=11
  local newlines="\n"
  local lines_in_file

  category_name=$(echo "$1" | tr '[:lower:]' '[:upper:]')
  line_found_category=$(sed -n '/'"#  $category_name"'/ =' "$TEMP_FILE")

  # A new category is added, with a different offset
  if [[ $line_found_category == '' ]] ; then
    lines_in_file=$(wc -l < "$FILE_HOST")
    if [ $lines_in_file -gt 11 ]; then
      newlines="\n\n\n"
      category_lines=13
    fi

    current_date=$(date "+%Y-%m-%d")
    file_format="${DIR}.dot/art/category.txt"
    category_format="${newlines}$(sed 's/CATEGORYNAME/'"$category_name"'/g' <  "$file_format" \
                        | sed 's/nr/##/g' \
                        | sed 's/date_c/'"$current_date"'/g' \
                        | sed 's/date_u/0000-00-00/g')\n\n\n\n\n\n"

    line_append=$((lines_in_file+category_lines))
    echo -e "$category_format" >> "$TEMP_FILE"
  fi

  echo $((line_append+line_found_category))
}

#EOF
