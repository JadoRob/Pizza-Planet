#!/bin/bash

################ GETTER/SETTERS ################
### Read Functions
### GET functions require arguments noted

get_id() {   # $1:Email
    for (( i=1; i < $(jq '.users | length' customers.json); i++ )); do  # starts at 1 since users[0] contains guest checkouts
        if [[ $(jq '.users['$i'].email' customers.json) == \"$1\" ]]; then
            echo $i
            break;
        fi
    done
}

get_email() {    # $1:UserID
    user=$1
    echo $(jq '.users['$user'].email' customers.json | sed "s/\"//g")   # prints email based on User ID
}

get_name() {     # $1:UserID
    user=$1
    echo $(jq '.users['$user'].name' customers.json | sed "s/\"//g")    # prints name based on User ID
}

get_orders() {   # $1:UserID
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


### Update Functions
### SET functions require User ID
### Prompts for email/name if not provided

set_email() {    # $1:UserID     $2:Email
    user=$1
    if [[ -z "$2" ]]; then
        ask_email
    else
        emailInp=$2
    fi

    emailInp=$(to_lowercase $emailInp)

    echo "$(jq '.users['$user'].email |= "'$emailInp'"' customers.json)" > customers.json   # change email in json file
}

set_name() {     # $1:UserID     $2:Name
    user=$1
    if [[ -z "$2" ]]; then  # if no args
        read -p "Name >> " nameInp
    else
        nameInp=$2
    fi
    echo "$(jq --arg newName "$nameInp" '.users['$user'].name |= $newName' customers.json)" > customers.json    # change name in json file
}


### Create Functions
### Adds data to json

add_user() {     # $1:Email      $2:Name
    user=$(jq '.users | length' customers.json)
    set_email $user $1
    echo
    set_name $user
    echo "$(jq '.users['$user'].orders |= []' customers.json)" > customers.json     # writes in new user info at the end of .users[] in json file
}

add_order() {    # $1:userId     $2:orderNo
    user=$1
    orderNo=$2
    echo "$(jq '.users['$user'].orders += ['$orderNo']' customers.json)" > customers.json    # adds order based on User ID
    echo "$(jq '.users[0].allOrders += ['$orderNo']' customers.json)" > customers.json    # adds order based on User ID
}


################ LOGIN/LOGOUT ################

login_user() {   # $1:Email
    userId=$(get_id $1)
    name=$(get_name $userId)
    email=$(get_email $userId)
    orders=( $(get_orders $userId) )
}

logout_user() {
    userId=0
    name=""
    email=""
    orders=()
    return
}

################ VALIDATORS ################
valid_email() {   # $1:Email
    if [[ -z $1 ]]; then
        return 0
    fi
    if [[ $1 =~ [A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4} ]]; then
        echo true
    else
        return 0
    fi
}

valid_menu_prompt() {  # $1:min    $2:max  $3:prompt   $4:errorMessage
    option=""   # reset reusable variable
    min=$1
    max=$2
    prompt=$3
    errorMessage="Invalid input. Please enter a number between [$1-$2]"
    if [[ -n $4 ]]; then errorMessage="$4"; fi
    
    while [[ ! ($option -ge $min && $option -le $max) ]]; do
        read -p "$prompt >> " option
        if [[ $option -lt $min || $option -gt $max ]]; then
            echo
            echo $errorMessage
            sleep 2
            printf "\e[1A\e[0K"
            printf "\e[1A\e[0K"
            printf "\e[1A\e[0K"
        fi
    done
}


################ PROMPTS ################

ask_email() {    # $1:Message
    emailInp=""
    if [[ -z $1 ]]; then
        message="Email Address"
    else
        message=$1
    fi
    while [[ ! $(valid_email $emailInp) ]]; do
        # if [[ userId -ne 0 ]]; then clear; fi
        read -p "$message >> " emailInp
        if [[ ! $(valid_email $emailInp) ]]; then
            echo -e "\nInvalid email. Please try again."
            sleep 1
            printf "\e[1A\e[0K"
            printf "\e[1A\e[0K"
            printf "\e[1A\e[0K"
        fi
    done
}

delivery_prompt() {
    valid_menu_prompt 1 2 "Enter [1] for Carryout, [2] for Delivery" "Invalid input. Please enter [1] for Carryout or [2] for Delivery"
    orderType=$option

    if [[ $((orderType)) == 2 ]]; then
        deliveryFee=5.00
        deliveryStatus="on the way"
    fi
}


################ GRAPHICS ################
show_graphic() {
	echo "                                          _.oo."
	echo "                   _.u[[/;:,.         .odMMMMMM'"
	echo "                 .o888UU[[[/;:-.  .o@P^    MMM^"
	echo "                oN88888UU[[[/;::-.        dP^"
	echo "               dNMMNN888UU[[[/;::-.   .o@P^"
	echo "              ,MMMMMMN888UU[[/;::-. o@^"
	echo "              NNMMMNN888UU[[[/~.o@P^"
	echo "              888888888UU[[[/o@^-.."
	echo "             oI8888uu[[[/o@P^:--.."
	echo "          .@^  YUU[[[/o@^;::---.."
	echo "        oMP     ^/o@P^;:::---.."
	echo "     .dMMM    .o@^ ^;::---..."
	echo "    dMMMMMMM@^ `      `^^^^"
	echo "   YMMMUP^"
	echo "    ^^"
	figlet "Pizza Planet"
	echo
}

################ MISC ################
to_lowercase() {     # $1:<string>
    echo $(echo $1 | tr '[A-Z]' '[a-z]')
}