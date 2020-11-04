#!/bin/tcsh -f

# dirtree_explorer.sh
# Yifan Yao.740
# 11/03/2020
# Description: print the file system structure under this directory in the form of a tree

# if there is an parameter passed to script, set it as current directory
# otherwise, set the current directory as default
if($#argv == 0) then
    set thisdir = "."
    echo "The current directory is: `pwd`"
else
    set thisdir = $argv[1]
    echo "The current directory is: $thisdir"
endif

# promote user to make a decision
echo "1.Enter a directory name"
echo "2.Print the directory tree on terminal"
echo "3.Print the directory tree to a file"
echo "4.Exit"
echo -n "Select: "
set decision = $<

while($decision != 4)
    # promote user to set directory
    if($decision == 1) then
        echo -n "Enter a directory name: "
        set thisdir = $<
        echo "The current directory is: $thisdir"
    # print dirtree
    else if($decision == 2) then
        if($?TREEPREFIX) then
            set prefix = "$TREEPREFIX"
        else
            set prefix = ""
        endif
        # print the head of the tree
        echo "$prefix|"
        set filelist = `ls -A $thisdir`
        # print each file
        foreach file ($filelist)
            echo "${prefix}|------${file}"
            # if it is a dir
            if(-d "$thisdir/$file") then
                if($file == $filelist[$#filelist]) then
                    setenv TREEPREFIX "${prefix} "
                else
                    setenv TREEPREFIX "${prefix}| "
                endif
                # echo $0 "$thisdir/$file"
            endif
        end
        # print the tail of the tree
        echo "$prefix"
    # save dirtree to file
    else if($decision == 3) then
        # promote user to input file name
        echo -n "Save to: "
        set saveto = $<
        echo > $saveto

        if($?TREEPREFIX) then
            set prefix = "$TREEPREFIX"
        else
            set prefix = ""
        endif
        echo "$prefix|" >> $saveto
        set filelist = `ls -A $thisdir`
        foreach file ($filelist)
            echo "${prefix}|------${file}" >> $saveto
            if(-d "$thisdir/$file") then
                if($file == $filelist[$#filelist]) then
                    setenv TREEPREFIX "${prefix} "
                else
                    setenv TREEPREFIX "${prefix}| "
                endif
            endif
        end
        echo "$prefix" >> $saveto
    endif

    # promote user to make decision again
    echo "1.Enter a directory name"
    echo "2.Print the directory tree on terminal"
    echo "3.Print the directory tree to a file"
    echo "4.Exit"
    echo -n "Select: "
    set decision = $<
end
