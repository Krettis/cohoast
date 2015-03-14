#!/bin/bash

# INSTALL THE COHOAST CALL
echo -e "\nTrying to install cohoast call in profile..."

folder_cohoast=$(pwd)
profile_file=''
if [ "$(uname)" == "Darwin" ]; then
	profile_file='.bash_profile'
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	profile_file='.bashrc'
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    # Do something under Windows NT platform
		echo "Sorry windows is not supported for installation.\n Feel free to add this to your profile"
		return;
fi

function_to_insert="\n# Edit your hostfile within the terminal\nfunction cohoast() { . ${folder_cohoast}/run.sh \$@ ;}"

echo -e $function_to_insert >> ~/$profile_file && source ~/$profile_file

source .dot/.functions

if chfn_exists cohoast; then
echo -e "
*    *   *   *   *  * * 
  ** * Success! * **
    *  *   *  *  *
"
source run.sh
else 
 echo "Something went wrong :("
 echo "Try to add the function manually in your profile: \n"
 echo -e "\n$function_to_insert\n"
fi


return;