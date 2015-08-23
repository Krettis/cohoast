#!/bin/bash

function remove_host
{
  local line_format
  line_format=$(found_host "$1")
	# delete if the same line format is found
  if [ ! -z "$line_format" ]; then
	  sed '/'"$line_format"'/ d' $FILE_HOST > hosts.tmp
    if [ "$(diff "$FILE_HOST" hosts.tmp)" ]; then
      cat hosts.tmp > "$FILE_HOST"
    fi
  fi
}

function found_host
{
  word=${1/\./\\.}
  find_host_name=$(sed -n 's/\([0-9]\+\.[0-9]\+:[0-9]\+\t'"$word"'\)\s\{0,\}$/\1/p' "$FILE_HOST")
  echo "$find_host_name"
}

#EOF
