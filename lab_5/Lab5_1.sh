#!/bin/bash

# Lab5_1.sh
# Yifan Yao.740
# 11/16/2020
# Description: sed

# 1. Change the name Jon to John.
sed -i "s/Jon/John/g" datebook.txt

# 2. Append three asterisks to the end of lines starting with Fred.
sed -i "/^Fred/a ***" datebook.txt

# 3. Replace the line containing Jose with “JOSE HAS RETIRED”.
sed -i "s/^Jose.*/JOSE HAS RETIRED/g" datebook.txt

# 4. Change Popeye's birthday to 11/14/46. Assume you don't know Popeye's
# original sbirthday. Use a regular expression to search for it.
sed -i "/Popeye/s,[0-9]\+/[0-9]\+/[0-9]\+,11/14/46," datebook.txt

# 5. Delete the first two lines.
sed -i "1,2d" datebook.txt

# 6. Delete lines containing Lane.
sed -i "/Lane/d" datebook.txt

# 7. Print lines 2 through the last.
sed "1d" datebook.txt

# 8. Print all lines where the birthdays are in December or January.
sed -rn "/^[^:]*:[^:]*:[^:]*:(12|1)\//p" datebook.txt
