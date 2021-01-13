#!/bin/bash

########### VARIABLES ###########
choices=("Premade Pizza" "Custom Pizza" "Other" "Drinks")
doneShopping=false
deliveryFee=0.00

########### FUNCTIONS ###########
showGraphic() {
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
    read -p "[1-4] >> " option
    
    case $option in
        1) ./menu.sh ;;
        2) ./custom.sh ;;
        3) ./otherfood.sh ;;
        4) ./Drinks.sh ;;
    esac
}

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

########### START SCRIPT ###########
./dependencies.sh   # checks for and installs required commands
. account.sh

showGraphic | lolcat
echo Welcome to Pizza Planet!
echo

if [[ $userId == 0 ]]; then read -p "Please enter your name >> " name; fi

printf "\nWhat can we get you today, $name?\n"

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
    recordOrder $(currentOrderNo)
    addOrder $userId $(currentOrderNo)
    printf "\nThank you for choosing Planet Pizza! You will be notified once your order is <ready/on the way>.\n"
    echo "Have a great day!"
fi
