#!/bin/bash

########### VARIABLES ###########
choices=("Pepperoni Pizza" "Meat Lover's Pizza" "Veggie Pizza") # Menu items
doneShopping=false  # Will be used below in a WHILE loop

########### FUNCTIONS ###########
displayOptions() {  # Displays menu items
    for i in ${!choices[@]}; do
        echo $(($i+1))\) ${choices[$i]}
    done
}

calcTotal() {   # Calculates total in cart.data
    total=0

    for i in `cut -d ':' -f 4 cart.data`; do
        i=`echo $i | sed "s/\"//g"`
        total=$(bc <<< "$total + $i")
    done

    echo $total
}

########### START SCRIPT ###########
read -p "Hello and welcome to Pizza Planet! May we have your name please? " customer

printf "\nWhat can we get you today, $customer?\n"

displayOptions

while [ $doneShopping = false ]; do # Doesn't do anything yet. For now, just repeats until you answer with anything but Yy
    read -p $'\nWould you like to add anything else (Y/N)? ' yn
    if [ $yn == "Y" ] || [ $yn == "y" ]; then
        printf "\nWhat would you like to add?\n"
        displayOptions
    else
        doneShopping=true
    fi
done

checkoutTotal=`calcTotal`   # calculate total

printf "\nLooks great, your total comes to \$$checkoutTotal\n\n"

read -p "Confirm purchase (Y/N)? " yn   # Yes will print goodbye message. For now, ends script regardless of answer

if [ $yn == "Y" ] || [ $yn == "y" ]; then
    printf "\nThank you for choosing Planet Pizza! You will be notified once your order is <read/on the way>.\n"
    echo "Have a great day!"
fi