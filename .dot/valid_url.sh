#!/bin/bash

function valid_url()
{
  regex="^(([a-zA-Z0-9]|[a-zA-Z0-9][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*([A-Za-z0-9]|[A-Za-z0-9][A-Za-z0-9\-]*[A-Za-z0-9]){2,}$"
  string="$1"
  if [[ $string =~ $regex ]]
  then
    return 0
  else
    return 1
  fi
}
#EOF