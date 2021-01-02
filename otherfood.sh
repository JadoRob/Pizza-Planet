#!/bin/bash

#--------------------------------------------------------------------------
# Author: robert Enojado
# Date: 12/31/2020

# Description: This script runs when the other foods option is selected
# from the main menu

# Declared variables:
# Products and prices will be read from otherfoods.data

product="null"
price=0
choice="null"

#--------------------------------------------------------------------------
# Function Declarations

# function that displays options for the user
# Hardcoded menu for now. Next version will display the list from a file
function showOptions() {
	clear
	echo "Welcome to Pizza Planet!"
	echo
	echo "Here's the menu, please select an option by choosing a number."
	echo
	echo "1. Buffalo Wings"
	echo "2. Honey BBQ Wings"
	echo "3. Garlic Parmesan Wings"
	echo "4. Breadsticks"
	echo "5. Mozzarella Sticks"
	echo "6. Chicken Alfredo"
	echo "7. Italian Sausage Marinara"
	echo "8. Pasta Primavera"
	echo
}

# This function will prompt the user, and store info into the 
# corresponding variables
function getOrder() {
	read -p "What will it be?: " choice
	case $choice in 
		1) product="Buffalo Wings"; price=7.99;;
		2) product="Honey BBQ Wings"; price=7.99;;
		3) product="Garlic Parmesan Wings"; price=7.99;;
		4) product="Breadsticks"; price=4.99;;
		5) product="Mozzarella Sticks"; price=5.99;;
		6) product="Chicken Alfredo"; price=6.99;;
		7) product="Italian Sausage Marinara"; price=6.99;;
		8) product="Pasta Primavera"; price=6.99;;
	esac
}

#--------------------------------------------------------------------------
# Start of script

until [ "$confirm" == "y" ]
do
	showOptions
	getOrder
	read -p "Add $product for $price to your order? y/n: " confirm
done
# Save the choices to a file
echo $product:$price >> cart.data
echo "Thank you!, Your order has been added. Returning to the main menu..."
sleep 3
