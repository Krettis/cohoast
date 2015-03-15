#!/bin/bash


addHost(){
	echo $HOSTS_FILE" "$portnumber"adding host : "$1
	categoryformat="\n\n\n\n\t#####\n\t## $category\n\t#####\n\n\n" 
	lineformat=$(echo -e "$ipaddress:$portnumber\t$hostname\r")

	sed '/'"$lineformat"'/ d' $HOSTS_FILE > hosts.tmp
	foundcategory=$(sed -n '/'"## $category"'/ =' hosts.tmp)
	lineappend=3

	if [[ $foundcategory == '' ]] ; then
		echo -e "$categoryformat" >> hosts.tmp
	       lineappend=6
	fi

	insertline=$(($foundcategory+$lineappend))
	echo $foundcategory"linenumber:: "$insertline
	sed  "$insertline"'a\
		'"$lineformat" hosts.tmp > $HOSTS_FILE
}

