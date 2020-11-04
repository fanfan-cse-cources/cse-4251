#!/bin/tcsh -f

# guess_game.sh
# Yifan Yao.740
# 11/03/2020
# Description: guessing game and calculate average attempts

# promote user to make a decision
echo "1. Run the guess game"
echo "2. Exit"
echo -n "Select: "
set decision = $<
set round = 0
set total = 0

clear

while ($decision != 2)
    @ round ++
    # promote user to guess the number
    echo "guess the number"
    set answer = $<

    # set the random number of goal
    set goal = `tr -dc A-Za-z0-9 < /dev/urandom | od -d | head -c 10 | tr -d 0 | tr -d ' '`

    # set counter
    set count = 1

    # keep asking user until get a correct number
    while ($answer != $goal )
        if ($answer < $goal ) then
            echo "too small"
        else
            echo "too large"
        endif
        @ count ++
        set answer = $<
    end

    # output count when user make a correct guess
    echo "correct!"
    echo "using $count rounds"

    @ total += $count

    # clear screen and promote user to make a decision
    echo "1. Run the guess game"
    echo "2. Exit"
    echo -n "Select: "
    set decision = $<
    clear
end

# print exit message and output for average
echo "Exiting the guessing game"
awk 'BEGIN{printf "Your average of rounds is: %.2f\n",('$total'/'$round')}'
