#!/bin/bash

account_menu() {
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
        valid_menu_prompt 1 5 "Welcome, $name! What would you like to do?"
        echo

        case $option in
            1) clear; return ;;
            2) clear; order_history; clear ;;
            3) set_email $userId; email=$(get_email $userId) ;;
            4) set_email $userId; name=$(get_name $userId) ;;
            5) clear; logout_user; return ;;
        esac
    done
}

order_history() {

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

ask_email "Please enter your email address"

emailInp=$(to_lowercase $emailInp)

if [[ $(get_id $emailInp) ]]; then
    login_user $emailInp
    account_menu
else
    echo -e "\nNo matches for $emailInp. Create account?\n"
    read -p "Enter [1] to create account. Enter [2] for guest checkout >> " inp
    if [[ inp -eq 1 ]]; then
        add_user $emailInp
        newUserId=$(( $(jq '.users | length' customers.json) - 1 )) # new user is at the end of json array (.users[].length - 1)
        newEmail=$(get_email $newUserId)
        login_user $newEmail
        account_menu
    fi
fi
