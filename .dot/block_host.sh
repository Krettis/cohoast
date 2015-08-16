#!/bin/bash

# shellcheck disable=SC2154
function block_host()
{
  local category="$1"
  local blockip="$2"
  local address="$3"

  if [ ! $# -eq 3 ]; then
    return 1
  fi

  if [ ${#category} -lt 3 ]; then
    return 1
  fi

  source "$DIR".dot/valid_ip.sh
  valid_ip "$blockip"
  if [ $? -eq 1 ] ; then
    return 1
  fi
  if [ "${#address}" -lt 5 ]; then
    return 1
  fi

  valid_ip "$address"
  if [ $? -eq 0 ]; then
    hostname=$(dig +short -x "$2")
    if [ -z "$hostname" ]; then
      echo "$lng_block_nohost"
      return 1
    fi
  else
    source "$DIR".dot/valid_url.sh
    valid_url "$address"
    if [ $? -eq 1 ]; then
      return 1
    fi
    hostname="$address"
  fi

  source "$DIR".dot/add_host.sh
  addHost "$category" "$blockip" "80" "$hostname"
  return 0
}

