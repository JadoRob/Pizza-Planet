#!/bin/bash

################ MENU FUNCTIONS ################
welcome() {
    clear
    show_graphic | lolcat -a -d 8
    printf "$green"
    echo Welcome to Pizza Planet!
    echo
    printf "$default"
    echo [1] Login/Register.
    echo [2] Continue as guest
    echo
    validate_menu 1 2 "[1-2]"
    echo
    if [[ $option == 1 ]]; then
        clear
        . account.sh
    fi

    #Ask for name if not logged in
    if [[ $userId == 0 ]]; then
        header
        printf "$blue"
        read -p "Please enter your name >> " name
    fi
}

# welcome() {
#     show_graphic | lolcat -a -d 8 
#     echo Welcome to Pizza Planet!
#     echo
#     echo [1] Login/Register.
#     echo [2] Continue as guest
#     echo
#         validate_menu 1 2 "[1-2]"
#         echo
#         if [[ $option == 1 ]]; then
#             clear_content 5
#             . account.sh
#         fi

#     # Ask for name if not logged in
#     if [[ $userId == 0 ]]; then
#         clear_content 7
#         #show_graphic | lolcat
#         printf "Welcome to Pizza Planet!\n\n"
#         read -p "Please enter your name >> " name
        
#     fi
# }

main_menu() {  # Displays main menu
    header
    printf "$green"
    if [[ -z $1 ]]; then
        printf "What can we get you today, $name?\n"
    else
        printf "$1\n"
    fi
    printf "$default"
    echo --------------------------------------------
    for i in ${!choices[@]}; do
        echo $(($i+1))\) ${choices[$i]}
    done
    echo --------------------------------------------
    echo

    validate_menu 1 4 "[1-4]"
    
    case $option in
        1) ./menu.sh ;;
        2) ./custom.sh ;;
        3) ./otherfood.sh ;;
        4) ./Drinks.sh ;;
    esac
}


################ CART FUNCTIONS ################

display_cart() {
    header
    echo -e $green'____________________________'$default 'YOUR CART' $green'____________________________'
    printf "$default"
    cat cart.data | while read line; do
        if [[ $(echo $line | awk -F ':' '{printf NF}') == 2 ]]; then
            echo $line | awk -F ':' '{ printf "\n  %-55s $%s\n", $1, $2 }'
        elif [[ $(echo $line | awk -F ':' '{printf NF}') == 3 ]]; then
            echo $line | awk -F ':' '{ printf "\n  %-55s $%s\n", $2, $3 }'
            echo -e "    \u2022 "$(echo $line | awk -F ':' '{print $1}')
        else
            echo $line | awk -F ':' '{ printf "\n  %-55s $%s\n", $1" "$3, $4 }'
            echo -e "    \u2022 "$(echo $line | awk -F ':' '{print $2}')
            echo -e "    \u2022 Toppings: "$(echo $line | awk -F ':' '{for (i = 5; i < NF; i++) printf $i", "} {if (NF > 4) printf $(NF)}')
        fi
    done
    echo -e $green'___________________________________________________________________'$default
    printf "%64s" "SUBTOTAL: \$$(calc_subtotal)"
    echo
}

empty_cart() {
    if [[ ! -f cart.data || -z $(grep '[^[:space:]]' cart.data) ]]; then
        echo true
    else
        echo false
    fi
}

confirm_cart() {
    # Order additional items
    while [ $doneShopping = false ]; do
        header
        if [[ $(empty_cart) == true ]]; then
            echo "Cart is empty. Returning to main menu..."
            sleep 1
            clear
            main_menu
        else
            display_cart
            printf "$blue"
            read -p $'\nWould you like to add anything else (Y/N)? >> ' yn
            printf "$default"
            if [[ $yn =~ [Yy] ]]; then
                # printf "\nWhat would you like to add?\n"
                main_menu "What would you like to add?"
            else
                doneShopping=true
                echo
            fi
        fi
    done
}


################ ORDERS FUNCTIONS ################

record_order() {     # $1:orderNo
    curOrder=$(get_current_order_no)
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

get_current_order_no() {
    allOrdersLength=$(jq '.users[0].allOrders | length' customers.json)

    currentOrderNum=$(( $allOrdersLength + 1 ))

    echo $currentOrderNum
}

################ CHECKOUT FUNCTIONS ################

calc_subtotal() {   # Calculates total in cart.data
    subTotal=0

    while read line; do
        if [[ $(echo $line | awk -F ':' '{printf NF}') == 2 ]]; then
            i=$(echo $line | awk -F ':' '{ printf "%s", $2 }')
        elif [[ $(echo $line | awk -F ':' '{printf NF}') == 3 ]]; then
            i=$(echo $line | awk -F ':' '{ printf "%s", $3 }')
        else
            i=$(echo $line | awk -F ':' '{ printf "%s", $4 }')
        fi

        subTotal=$(bc <<< "$subTotal + $i")
    done < cart.data

    echo $subTotal
}

calc_tax() {
    tax=$(echo "scale=2;$subTotal*.05" | bc -l)
    
    if [[ $tax < 1 ]]; then tax="0$tax"; fi

    echo $tax
}

checkout() {
    delivery_prompt

    # Calculate totals & tax
    subTotal=$(calc_subtotal)
    tax=$(calc_tax)
    grandTotal=$(bc <<< $tax+$subTotal+$deliveryFee)

    printf $green"\nLooks great, your total before tax comes to \$$subTotal\n\n"$default

    # Display totals
    echo "     Subtotal: \$$subTotal"
    echo " Delivery Fee:  \$$deliveryFee"
    echo "Estimated Tax:  \$$tax"
    echo "   GrandTotal: \$$grandTotal"
    echo
    printf $blue
    read -p "Confirm purchase (Y/N)? " yn

    if [[ $yn =~ [Yy] ]]; then
        printf "$green\nThank you for choosing Planet Pizza! You will be notified once your order is $deliveryStatus.\n"
        record_order $(get_current_order_no)
        add_order $userId $(get_current_order_no)
        echo "Have a great day!"
    fi
}


################ MENU/CHECKOUT VARIABLES ################
choices=("Premade Pizza" "Custom Pizza" "Other" "Drinks")
doneShopping=false
deliveryFee=0.00
deliveryStatus="ready"

########## ACTIVE USER VARIABLES ##########
### login_user() fills these in
userId=0
name=""
email=""
orders=()


########### START SCRIPT ###########
./dependencies.sh   # checks for and installs required commands
. functions.sh  # imports functions

welcome
main_menu
confirm_cart
checkout
