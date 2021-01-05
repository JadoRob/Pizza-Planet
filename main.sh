#!/bin/bash

########### VARIABLES ###########
choices=("Premade Pizza" "Custom Pizza" "Other")
doneShopping=false
deliveryFee=0.00

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
        1) ./menu.sh ;;
        2) ./option156.sh ;;
        3) ./food.sh ;;
    esac
}

calcSubtotal() {   # Calculates total in cart.data
    subTotal=0

    for i in `cut -d ':' -f 4 cart.data`; do
        i=`echo $i | sed "s/\"//g"`
        subTotal=$(bc <<< "$subTotal + $i")
    done

    echo $subTotal
}

calcTax() {
    tax=$(echo "scale=2;$subTotal*.05" | bc -l)
    
    if [[ $tax < 1 ]]; then tax="0$tax"; fi

    echo $tax
}

displayCart() {
    echo '______________ YOUR CART ______________'
    cat cart.data | while read line; do
        echo
        echo "$(echo $line | cut -d ':' -f 3)             \$$(echo $line | cut -d ':' -f 4)"
        echo -e "  \u2022 Size: $(echo $line | cut -d ':' -f 1)"
        echo -e "  \u2022 Crust: $(echo $line | cut -d ':' -f 2)"
    done
    echo _______________________________________
    echo "                     SUBTOTAL: \$$(calcSubtotal)"
}

##### incomplete - future feature
#if grep -ixq "$email" customers.txt; then
#    echo 'email exists'
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
    clear
    displayCart
    read -p $'\nWould you like to add anything else (Y/N)? >> ' yn
    if [[ $yn =~ [Yy] ]]; then
        printf "\nWhat would you like to add?\n"
        displayOptions
    else
        doneShopping=true
        echo
    fi
done

read -p "Press 1 for carryout, 2 for delivery >> " orderType

if [[ $((orderType)) == 2 ]]; then deliveryFee=5.00; fi

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
    printf "\nThank you for choosing Planet Pizza! You will be notified once your order is <ready/on the way>.\n"
    echo "Have a great day!"
fi
