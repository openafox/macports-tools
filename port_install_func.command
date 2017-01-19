#!/bin/bash 

# run with: sh port_install_func.command

#check if run with sudo
#sh sudo_check.command || exit
#check if macports installed / update
sh macports_update.command

#set break in for as \n
IFS=$'\n'
#get ports to install
STR="$(< ports.txt)"
tester="--->  No broken files found."
for i in $STR; do
    i=$(echo $i | sed 's/ *#.*//')  # remove comments
    #add pip install funcinality
    if [[ $i == pip* ]] || [[ $i == sudo* ]];
    then
        inst="$i"
    else
        inst="sudo port install $i"
    fi
    echo Running: $inst
    output=$( eval $inst )
    num=$(echo "$output" | wc -l)
    last=$(echo "$output" | tail -n1)
    if [ "$tester" == "$last" ] || [[ "$last" == *active. ]] || [[ "$last" == Requirement* ]];
    then
        echo Installed
    else
        echo ERROR!
        echo Out: "$output"
    fi    
done

echo Done
