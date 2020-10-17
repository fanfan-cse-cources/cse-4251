#!/bin/bash

# define variables
filename="mycontacts.txt"

# promote user to identify themselves
read -p "Your name (First name, Last name): " fullname
firstname=$(echo "$fullname" | awk -F "," '{print $1}')
echo "Hello, $firstname"

# print time
echo "Today is $(date +%A) and the current time is $(date +%l:%M:%S\ %p)."

# print contacts who born in today
if [[ $(grep $(date +%d-%m) $filename) ]];
then
    echo "These contacts are having a birthday today:"
else
    echo -e "Nobody born in today :(\n"
fi
# grep $(date +%d-%m) filename | awk '{print $1" "$2}'

# promote user to conduct a search
read -p "Enter a contact last name to search in file: " search
cat $filename | awk '{print $2}' | grep search

# if there is a match
empty="true"
while read line;
do
    var1=$(echo "$line" | awk '{print $2}')
    if [[ "${var1,,}" == "${search,,}" ]];
    then
        echo $line
        empty="false"
    fi
done < "$filename"

# otherwise
if [ $empty == "true" ];
then
    echo ""
    echo "Did not found $search from $(wc -l $filename | awk '{print $1}') record(s) from $filename:"
    sort $filename
fi

# good-bye message
echo -e "\nBye, $firstname. Current hour is: $(date +%H)"
