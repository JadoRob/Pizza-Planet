#!/bin/bash

accountMenu() {
    option=''
    while [[ $option != "1" ]]; do
        if [[ $option != 2 ]]; then clear; fi

        echo "User ID: $userId"
        echo "Name: $name"
        echo "Email: $email"
        echo
        echo [1] Order
        echo [2] View Order History
        echo [3] Change Email address
        echo [4] Change Name
        echo "[5] Logout (order as guest)"
        echo
        menuValidation 1 5 "Welcome, $name! What would you like to do?"
        echo

        case $option in
            1) clear; return ;;
            2) clear; orderHistory; clear ;;
            3) setEmail $userId; email=$(getEmail $userId) ;;
            4) setName $userId; name=$(getName $userId) ;;
            5) clear; logoutUser; return ;;
        esac
    done
}

orderHistory() {

    for order in ${orders[@]}; do
        echo "[ORDER# $order]"
        echo "-------------------------------------------------------------------"
        cat "orders/order_$order.data" | while read line; do
            if [[ $(echo $line | awk -F ':' '{printf NF}') == 2 ]]; then
                echo $line | awk -F ':' '{ printf " - %-55s $%s\n", $1, $2 }'
            elif [[ $(echo $line | awk -F ':' '{printf NF}') == 3 ]]; then
                echo $line | awk -F ':' '{ printf " - %-55s $%s\n", $2, $3 }'
                echo -e "    \u2022 "$(echo $line | awk -F ':' '{print $1}')
            else
                echo $line | awk -F ':' '{ printf " - %-55s $%s\n", $1" "$3, $4 }'
                echo -e "    \u2022 "$(echo $line | awk -F ':' '{print $2}')
                echo -e "    \u2022 Toppings: "$(echo $line | awk -F ':' '{for (i = 5; i < NF; i++) printf $i", "} {if (NF > 4) printf $(NF)}')
            fi
        done
        echo -------------------------------------------------------------------
        printf "\n\n"
    done

    read -n 1 -s -r -p "Press any key to continue >> "
}


########### START SCRIPT ###########

askEmail "Please enter your email address"

emailInp=$(toLowercase $emailInp)

if [[ $(getId $emailInp) ]]; then
    loginUser $emailInp
    accountMenu
else
    echo -e "\nNo matches for $emailInp. Create account?\n"
    read -p "Enter [1] to create account. Enter [2] for guest checkout >> " inp
    if [[ inp -eq 1 ]]; then
        addUser $emailInp
        newUserId=$(( $(jq '.users | length' customers.json) - 1 )) # new user is at the end of json array (.users[].length - 1)
        newEmail=$(getEmail $newUserId)
        loginUser $newEmail
        accountMenu
    fi
fi
