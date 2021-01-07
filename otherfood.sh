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
#function showMenu() {
#	clear
#	printf "============================================\n"
#	printf "	                                   |\n"
#	printf "	Welcome to PIZZA PLANET!!          |\n"
#	printf "	                                   |\n"
#	printf "============================================\n"
#}

function showGraphic() {
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

function showOptions() {
	echo "Please choose by selecting a number:"
	echo 
	# read from otherfood.data, separate using ":" as the delimeter, print 
	# column 1 of all lines along with line number
	awk -F: '{print NR") "$2}' otherfood.data
	echo ""
	echo "0. Back to main menu"
	echo 
}

function getOrder() {
	read -p "What would you like?: " choice

	product=$(awk -v var="$choice" -F: '{if(NR==var) print $2}' otherfood.data)
	price=$(awk -v var="$choice" -F: '{if(NR==var) print $3}' otherfood.data)
}

#------------------------------------------------------------------------------------
# Start of script

until [ "$confirm" == "y" ]
do
	clear
	showGraphic | lolcat
	showOptions
	getOrder
	read -p "Great choice, add $product for \$$price to your order? [y/n]: " confirm 
done
# save the order to a file
echo $product:$price >> cart.data
echo "Thank you!, Your order has been added. Returning to the main menu..."
sleep 3