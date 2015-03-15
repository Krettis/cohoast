#!/bin/bash



function usage
{
      echo -e "usage: cohoast optional: [[add ] [-h | --help] ]\n"
			echo "Only calling 'cohoast' will take you to a friendly menu"
			echo "where you can specify a lot more options for handling"
			echo -e "your hostfile.\n"

			echo "List of commands: "
      echo "add | a        Add a hostname to the localhost"
 
			#echo "-h | --help     Get more information about"
      #echo "               how to use a command"

     #echo "remove | rm   Invoke the remove-host command"
      #echo "-f --file     The configuration file, in $BASEPATH/sites"
      #echo "ports         Lists the currently used ports per hostname"
      #echo "ls | l        Lists the hosts configuration files"
      #kecho "usage: cohoast [[add | a | remove | rm] [-h | --help] [-f | --file] [ ports ] [ ls | l ]]"
}

function usage_add
{
#	echo "usage: cohoast add [ hostname ]"
#	echo "This will add a hostname to hosts-file"
}