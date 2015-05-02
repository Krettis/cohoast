#!/bin/bash

addHost(){
	categoryname=$(echo $category | tr '[:lower:]' '[:upper:]')
	categoryformat="\n"$(cat $DIR.dot/art/category.txt | sed 's/CATEGORYNAME/'$categoryname'/g' | sed 's/nr/1/g' | sed 's/date_c/'$currentdate'/g' | sed 's/date_u/'$currentdate'/g')"\n\n\n\n\n\n"
	lineformat=$(echo -e "$ipaddress:$portnumber\t$hostname\r")
	echo -e "Adding host\nname: "$hostname"\nPortnumber: "$portnumber"\ncategory: "$category"\nIn file:"$HOSTS_FILE
echo $categoryname" "$lineformat

	sed '/'"$lineformat"'/ d' $HOSTS_FILE > hosts.tmp
	foundcategory=$(sed -n '/'"#  $categoryname"'/ =' hosts.tmp)
	lineappend=3
echo "found category: "$foundcategory

	if [[ $foundcategory == '' ]] ; then
		currentdate=$(date "+%Y-%m-%d")
	  lineappend=12

		echo -e "$categoryformat" >> hosts.tmp
	fi

	insertline=$(($foundcategory+$lineappend))
	echo $foundcategory"linenumber:: "$insertline
	sed  "$insertline"'a\
		'"$lineformat" hosts.tmp > $HOSTS_FILE
}

