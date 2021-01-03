#!/bin/bash

#----------------------------------------------------------------------
# Author: Robert Enojado
# Date: 12/30/2020

# Description: This script runs when option 2 Meat Lover's
# Pizza is selected from the main menu 

# Declared variables:
pizza="Meat Lover's Pizza"
small=9.99; medium=11.99; large=14.99

#----------------------------------------------------------------------
# function that displays the options to the user

function showOptions {
clear
echo "$pizza"
echo ""
echo "Please choose by selecting a number:"
echo ""
echo "Size				Crust"
echo "1. Small			4. Pan Crust"
echo "2. Medium			5. Thin Crust"
echo "3. Large			6. Stuffed Crust"
echo ""
echo "0. Back to main menu"
echo ""
}

#----------------------------------------------------------------------
# function that lets the user choose options
# sets variable $size depending on option chosen 

function getOrder {
read -p "What size $pizza would you like?: " option
case $option in
1) size="Small"; price=$small;;
2) size="Medium"; price=$medium;;
3) size="Large"; price=$large;;
esac

# sets variable $crust depending on option chosen
read -p "What kind of crust would you like this $pizza to have?: " option

case $option in
4) crust="Pan Crust";;
5) crust="Thin Crust";;
6) crust="Stuffed Crust";;
esac
}
#---------------------------------------------------------------------
# Show the menu options, and ask to choose
# Confirm order, if not confirmed, starts the order over

until [ "$question" == "y" ]
do
showOptions
getOrder
read -p "Add a $size $crust $pizza for $price to your order? y/n: " question
done
# Save the choices to a file
echo $size:$crust:$pizza:$price >> cart.data
echo "Thank you $name!, your order has been added. Returning to main menu ..." 
sleep 3
