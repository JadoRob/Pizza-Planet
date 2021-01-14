#!/bin/bash

#------------------------------------------------------------------------------------
# Author: Robert Enojado
# Date: 12/31/2020

# Description: This script runs when the other foods option is selected
# 	from the main menu. The menu and products are read from wings.data,
#	sides.data, or pasta.data, depending on user selection. The selection
#	is then saved to cart.data for the main script to process.


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

function showMenu() {
	echo "Please choose by selecting a number: "
	echo 
	echo "1. Wings"
	echo "2. Sides"
	echo "3. Pasta"
	echo
	echo "0. Return to Main Menu"
	echo
}

function showSubmenu() {
	echo "Here's our selection: "
	echo
	#show items in the sub menu and save the food type with .data to $file
	case $1 in
		1) awk -F: '{print NR". " $1}' wings.data; file="wings.data";;
		2) awk -F: '{print NR". " $1}' sides.data; file="sides.data";;
		3) awk -F: '{print NR". " $1}' pasta.data; file="pasta.data";;
	esac
	echo
}

#------------------------------------------------------------------------------------
# Start of script

until [ "$confirm" == "y" ]
do
	clear
	showGraphic | lolcat
	showMenu
	while true; do
		read -p "What kind of food are you hungry for?: " foodType
		[[ $foodType =~ ^[0-9]+$ ]] || { echo "Please enter a valid number: "; echo; continue; }
		if (($foodType >= 0 && $foodType <= 3)); then
			break
		else
			echo "Please choose a number listed above: "
			echo
		fi
	done
	if (($foodType==0)); then
		echo "Returning to Main Menu..."
		sleep 3
		exit
	fi
	showSubmenu $foodType
	while true; do
		read -p "What would you like?: " choice
		[[ $choice =~ ^[0-9]+$ ]] || { echo "Please enter a valid number: "; echo; continue; }
		if (($choice >= 1 && $choice <= 3)); then
			break
		else
			echo "Please choose a number listed above: "
			echo 
		fi
	done
	#Stores the line defined in $choice from the data file ($file)
	product=$(awk -v var="$choice" '{if(NR==var) print $0}' $file)
	item=$(echo "$product" | cut -d ":" -f1)
	price=$(echo "$product" | cut -d ":" -f2)
	read -p "Great choice, add $item for \$$price to your order? [y/n]: " confirm 
done
# save the order to a file
echo $product >> cart.data
echo "Thank you!, Your order has been added. Returning to the main menu..."
sleep 3