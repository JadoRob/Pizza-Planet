#!/bin/bash

########### VARIABLES ###########
choices=("Pepperoni Pizza" "Meat Lover's Pizza" "Veggie Pizza") # Menu items
doneShopping=false  # Will be used below in a WHILE loop

########### FUNCTIONS ###########
displayOptions() {  # Displays menu items
    echo --------------------------------------------
    for i in ${!choices[@]}; do
        echo $(($i+1))\) ${choices[$i]}
    done
    echo --------------------------------------------
    echo
    selectOption
}

selectOption() {
    read -p "[1-2] >> " option
    case $option in
        1) ./option1.sh ;;
        2) ./option2.sh ;;
    esac
}

calcTotal() {   # Calculates total in cart.data
    total=0

    for i in `cut -d ':' -f 4 cart.data`; do
        i=`echo $i | sed "s/\"//g"`
        total=$(bc <<< "$total + $i")
    done

    echo $total
}

##### incomplete - future feature
#if grep -ixq "$customer" customers.txt; then
#    echo 'customer exists'
# This checks lines for exact name match
#fi

########### START SCRIPT ###########

> cart.data     # Clear cart

echo Welcome to Pizza Planet!
echo
read -p "Please enter your name >> " customer

printf "\nWhat can we get you today, $customer?\n"

displayOptions

# Order additional items
while [ $doneShopping = false ]; do
    read -p $'\nWould you like to add anything else (Y/N)? ' yn
    if [[ $yn =~ [Yy] ]]; then
        printf "\nWhat would you like to add?\n"
        displayOptions
    else
        doneShopping=true
    fi
done

checkoutTotal=`calcTotal`   # calculate total

printf "\nLooks great, your total comes to \$$checkoutTotal\n\n"

read -p "Confirm purchase (Y/N)? " yn   # Yes will print goodbye message. For now, ends script regardless of answer

if [[ $yn =~ [Yy] ]]; then
    printf "\nThank you for choosing Planet Pizza! You will be notified once your order is <ready/on the way>.\n"
    echo "Have a great day!"
fi
