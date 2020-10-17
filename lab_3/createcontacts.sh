#!/bin/bash

# define variables
filename="mycontacts.txt"
menu=("Enter a contact" "Show contacts" "Exit")
contact=("Full Name (First, Last): " "Date of Birth (dd-mm): " "phone (xxx-yyy-yyyy): " "email (name@domain.xyz): ")

# promote user to make a selection
for ((i = 0; i < ${#menu[@]}; ++i)); do
    echo "$(($i + 1)). ${menu[$i]}"
done
echo ""
read -p "Select: " x

# keep asking user until exit
while [[ $x -gt 0 || $x -lt 3 ]]; do
    case "$x" in
        1)
        arr=()
        # put user input into an array
        for ((i = 0; i < ${#contact[@]}; ++i)); do
            read -p "$(($i + 1)). ${contact[$i]}" arr[$i]
        done

        # stdout to file
        echo "${arr[@]}" >> $filename

        ;;
        2)
        # print contents
        if [ -s $filename ]
        then
            cat $filename
        else
            echo "$filename is empty"
        fi
        ;;
        3)
        # exit
        echo "bye"
        echo ""
        exit 0
        ;;
        *)
    esac

    echo ""
    for ((i = 0; i < ${#menu[@]}; ++i)); do
        echo "$(($i + 1)). ${menu[$i]}"
    done
    echo ""
    read -p "Select: " x
done
