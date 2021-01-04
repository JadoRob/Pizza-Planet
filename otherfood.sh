#!/bin/bash

#------------------------------------------------------------------------------------
# Author: Robert Enojado
# Date: 12/31/2020

# Description: This script runs when the other foods option is selected
# from the main menu

# Declared variables:
# Products and prices will be read from otherfoods.data
product="null"
price="0"
choice="null"

#------------------------------------------------------------------------------------
# Function Declarations

# function that displays options for the user
# Displayed by reading from the file otherfood.data
function showOptions() {
	clear
	echo "Please choose by selecting a number:"
	echo 
	# read from otherfood.data, separate using ":" as the delimeter, print 
	# column 1 of all lines along with line number
	awk -F: '{print NR") "$1}' otherfood.data
	echo ""
	echo "0. Back to main menu"
	echo 
}

function getOrder() {
	read -p "What would you like?: " choice
	product=$(awk -v var="$choice" -F: '{if(NR==var) print $1}' otherfood.data)
	price=$(awk -v var="$choice" -F: '{if(NR==var) print $2}' otherfood.data)
}

#------------------------------------------------------------------------------------
# Start of script

until [ "$confirm" == "y" ]
do
	showOptions
	getOrder
	read -p "Great choice, add $product for \$$price to your order? [y/n]: " confirm 
done
# save the order to a file
echo $product:$price >> cart.data
echo "Thank you!, Your order has been added. Returning to the main menu..."
sleep 3