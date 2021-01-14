#!/bin/bash

########## VARIABLES FOR ACTIVE USER ##########
### loginUser() fills these in
userId=0
name=""
email=""
orders=()

################ GETTER/SETTERS ################
### GET functions require arguments noted

getId() {   # $1:Email
    for (( i=1; i < $(jq '.users | length' customers.json); i++ )); do  # starts at 1 since users[0] contains guest checkouts
        if [[ $(jq '.users['$i'].email' customers.json) == \"$1\" ]]; then
            echo $i
            break;
        fi
    done
}

getEmail() {    # $1:UserID
    user=$1
    echo $(jq '.users['$user'].email' customers.json | sed "s/\"//g")   # prints email based on User ID
}

getName() {     # $1:UserID
    user=$1
    echo $(jq '.users['$user'].name' customers.json | sed "s/\"//g")    # prints name based on User ID
}

getOrders() {   # $1:UserID
    user=$1
    ordersLength=$(jq '.users['$user'].orders | length' customers.json)
    orderList=()
    for (( i = 0; i < ordersLength; i++ )); do
        curOrder=$(jq '.users['$user'].orders['$i']' customers.json)

        case $((
            (curOrder >= 1 && curOrder <= 9) * 1 +   
            (curOrder >= 10 && curOrder <= 99) * 2 +
            (curOrder >= 100 && curOrder <= 999) * 3 )) in   
                (1) orderList[$i]="000${curOrder}" ;;
                (2) orderList[$i]="00${curOrder}" ;;
                (3) orderList[$i]="0${curOrder}" ;;
        esac
    done
    echo "${orderList[@]}"
}

### SET functions require User ID
### Prompts for email/name if not provided
setEmail() {    # $1:UserID     $2:Email
    user=$1
    if [[ -z "$2" ]]; then
        askEmail
    else
        emailInp=$2
    fi

    emailInp=$(toLowercase $emailInp)

    echo "$(jq '.users['$user'].email |= "'$emailInp'"' customers.json)" > customers.json   # change email in json file
    
}

setName() {     # $1:UserID     $2:Name
    user=$1
    if [[ -z "$2" ]]; then  # if no args
        read -p "Name >> " nameInp
    else
        nameInp=$2
    fi
    echo "$(jq --arg newName "$nameInp" '.users['$user'].name |= $newName' customers.json)" > customers.json    # change name in json file

}

################ OTHER FUNCTIONS ################

loginUser() {   # $1:Email
    userId=$(getId $1)
    name=$(getName $userId)
    email=$(getEmail $userId)
    orders=( $(getOrders $userId) )
}

logoutUser() {
    userId=0
    name=""
    email=""
    orders=()
}

addUser() {     # $1:Email      $2:Name
    user=$(jq '.users | length' customers.json)
    setEmail $user $1
    echo
    setName $user
    echo "$(jq '.users['$user'].orders |= []' customers.json)" > customers.json     # writes in new user info at the end of .users[] in json file
}

addOrder() {    # $1:userId     $2:orderNo
    user=$1
    orderNo=$2
    echo "$(jq '.users['$user'].orders += ['$orderNo']' customers.json)" > customers.json    # adds order based on User ID
    echo "$(jq '.users[0].allOrders += ['$orderNo']' customers.json)" > customers.json    # adds order based on User ID
}

recordOrder() {     # $1:orderNo
    curOrder=$(currentOrderNo)
    case $((
        (curOrder >= 1 && curOrder <= 9) * 1 +
        (curOrder >= 10 && curOrder <= 99) * 2 +
        (curOrder >= 100 && curOrder <= 999) * 3 )) in
            (1) curOrder="000${curOrder}" ;;
            (2) curOrder="00${curOrder}" ;;
            (3) curOrder="0${curOrder}" ;;
    esac

    mkdir -p orders
    mv cart.data orders/order_$curOrder.data
}

currentOrderNo() {
    allOrdersLength=$(jq '.users[0].allOrders | length' customers.json)

    if [[ $allOrdersLength -eq 0 ]]; then
        lastOrder=0
    else
        lastOrder=$(jq '.users[0].allOrders[0]' customers.json)
        for (( i = 0; i < allOrdersLength; i++ )); do
            if [[ $(jq '.users[0].allOrders['$i']' customers.json) -gt $lastOrder ]]; then
                lastOrder=$(jq '.users[0].allOrders['$i']' customers.json)
            fi
        done
    fi
    ((lastOrder++))
    echo $lastOrder
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

    read -n 1 -s -r -p "Press any key to continue"
}

accountMenu() {
    option=''
    while [[ $option != "1" ]]; do
        if [[ $option != 2 ]]; then clear; fi

        echo "User ID: $userId"
        echo "Name: $name"
        echo "Email: $email"
        echo "Orders: $orders"
        echo 

        echo [1] Order
        echo [2] View Order History
        echo [3] Change Email address
        echo [4] Change Name
        echo "[5] Logout (order as guest)"
        echo
        read -p "Welcome, $name! What would you like to do? >> " option
        echo

        case $option in
            1) clear; return ;;
            2) clear; orderHistory ;;
            3) setEmail $userId; email=$(getEmail $userId); clear ;;
            4) setName $userId; name=$(getName $userId); clear ;;
            5) clear; logoutUser; return ;;
        esac
    done
}

validEmail() {   # $1:Email
    if [[ -z $1 ]]; then
        return 0
    fi
    if [[ $1 =~ [A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4} ]]; then
        echo true
    else
        return 0
    fi
}

askEmail() {    # $1:Message
    emailInp=""
    if [[ -z $1 ]]; then
        message="Email Address"
    else
        message=$1
    fi
    while [[ ! $(validEmail $emailInp) ]]; do
        clear
        read -p "$message >> " emailInp
        if [[ ! $(validEmail $emailInp) ]]; then
            echo -e "\nInvalid email. Please try again."
            sleep 1
        fi
    done
}

toLowercase() {     # $1:<string>
    echo $(echo $1 | tr '[A-Z]' '[a-z]')
}

########### START SCRIPT ###########

askEmail "Please enter your email address"

emailInp=$(toLowercase $emailInp)

if [[ $(getId $emailInp) ]]; then
    loginUser $emailInp
    accountMenu
else
    echo -e "No matches for $emailInp. Create account?\n"
    read -p "Enter [1] to create account. Enter [2] for guest checkout >> " inp
    if [[ inp -eq 1 ]]; then
        addUser $emailInp
        newUserId=$(( $(jq '.users | length' customers.json) - 1 )) # new user is at the end of json array (.users[].length - 1)
        newEmail=$(getEmail $newUserId)
        loginUser $newEmail
        accountMenu
    fi
fi
