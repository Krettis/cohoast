#!/bin/bash

function usage
{
  usagetxt main
}

function usage_add
{
  usagetxt add
}

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
