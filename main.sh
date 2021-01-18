#!/bin/bash

################ MENU FUNCTIONS ################
welcome() {
    showGraphic | lolcat
    echo Welcome to Pizza Planet!
    echo
    echo [1] Login/Register.
    echo [2] Continue as guest
    echo
        menuValidation 1 2 "[1-2]"
        echo
        if [[ $option == 1 ]]; then
            clear
            . account.sh
        fi

    # Ask for name if not logged in
    if [[ $userId == 0 ]]; then
        clear
        showGraphic | lolcat
        printf "Welcome to Pizza Planet!\n\n"
        read -p "Please enter your name >> " name
        clear
    fi
}

mainMenu() {  # Displays main menu
    printf "What can we get you today, $name?\n"
    echo --------------------------------------------
    for i in ${!choices[@]}; do
        echo $(($i+1))\) ${choices[$i]}
    done
    echo --------------------------------------------
    echo

    menuValidation 1 4 "[1-4]"
    
    case $option in
        1) ./menu.sh ;;
        2) ./custom.sh ;;
        3) ./otherfood.sh ;;
        4) ./Drinks.sh ;;
    esac
}


################ CART FUNCTIONS ################

displayCart() {
    echo '____________________________ YOUR CART ____________________________'
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
    echo ___________________________________________________________________
    printf "%64s" "SUBTOTAL: \$$(calcSubtotal)"
}

emptyCart() {
    if [[ ! -f cart.data || -z $(grep '[^[:space:]]' cart.data) ]]; then
        echo true
    else
        echo false
    fi
}

confirmCart() {
    # Order additional items
    while [ $doneShopping = false ]; do
        clear
        if [[ $(emptyCart) == true ]]; then
            echo "Cart is empty. Returning to main menu..."
            sleep 1
            clear
            mainMenu
        else
            displayCart
            read -p $'\nWould you like to add anything else (Y/N)? >> ' yn
            if [[ $yn =~ [Yy] ]]; then
                printf "\nWhat would you like to add?\n"
                mainMenu
            else
                doneShopping=true
                echo
            fi
        fi
    done
}


################ ORDERS FUNCTIONS ################

recordOrder() {     # $1:orderNo
    curOrder=$(getCurrentOrderNo)
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

getCurrentOrderNo() {
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

################ CHECKOUT FUNCTIONS ################

calcSubtotal() {   # Calculates total in cart.data
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

calcTax() {
    tax=$(echo "scale=2;$subTotal*.05" | bc -l)
    
    if [[ $tax < 1 ]]; then tax="0$tax"; fi

    echo $tax
}

checkout() {
    deliveryPrompt

    # Calculate totals & tax
    subTotal=$(calcSubtotal)
    tax=$(calcTax)
    grandTotal=$(bc <<< $tax+$subTotal+$deliveryFee)

    printf "\nLooks great, your total before tax comes to \$$subTotal\n\n"

    # Display totals
    echo "     Subtotal: \$$subTotal"
    echo " Delivery Fee:  \$$deliveryFee"
    echo "Estimated Tax:  \$$tax"
    echo "   GrandTotal: \$$grandTotal"
    echo

    read -p "Confirm purchase (Y/N)? " yn

    if [[ $yn =~ [Yy] ]]; then
        printf "\nThank you for choosing Planet Pizza! You will be notified once your order is $deliveryStatus.\n"
        recordOrder $(getCurrentOrderNo)
        addOrder $userId $(getCurrentOrderNo)
        echo "Have a great day!"
    fi
}


################ MENU/CHECKOUT VARIABLES ################
choices=("Premade Pizza" "Custom Pizza" "Other" "Drinks")
doneShopping=false
deliveryFee=0.00
deliveryStatus="ready"

########## ACTIVE USER VARIABLES ##########
### loginUser() fills these in
userId=0
name=""
email=""
orders=()


########### START SCRIPT ###########
./dependencies.sh   # checks for and installs required commands
. functions.sh  # imports functions

welcome
mainMenu
confirmCart
checkout
