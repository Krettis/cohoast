#!/bin/bash


addHost(){
	echo $FILE_HOST" "$portnumber"adding host : "$1
	categoryformat="\n\n\n\n\t#####\n\t## $category\n\t#####\n\n\n" 
	lineformat=$(echo -e "$ipaddress:$portnumber\t$hostname\r")

	sed '/'"$lineformat"'/ d' $FILE_HOST > hosts.tmp
	foundcategory=$(sed -n '/'"## $category"'/ =' hosts.tmp)
	lineappend=3

	if [[ $foundcategory == '' ]] ; then
		echo -e "$categoryformat" >> hosts.tmp
	       lineappend=6
	fi

	insertline=$(($foundcategory+$lineappend))
	echo $foundcategory"linenumber:: "$insertline
	sed  "$insertline"'a\
		'"$lineformat" hosts.tmp > $FILE_HOST
}

