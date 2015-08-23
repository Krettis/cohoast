#!/bin/bash

function usage
{
  usagetxt main
}

function  usage_add
{
  usagetxt add
}
     #echo "remove | rm   Invoke the remove-host command"
      #echo "-f --file     The configuration file, in $BASEPATH/sites"
      #echo "ports         Lists the currently used ports per hostname"
      #echo "ls | l        Lists the hosts configuration files"
      #kecho "usage: cohoast [[add | a | remove | rm] [-h | --help] [-f | --file] [ ports ] [ ls | l ]]"

function usage_backup
{
  usagetxt backup
}

function usage_block
{
  usagetxt block
}

function usage_remove
{
  usagetxt remove
}

function usagetxt
{
  cat ${DIR}".dot/usage/${1}.txt"
}

#EOF
