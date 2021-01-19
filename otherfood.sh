#!/bin/bash

#------------------------------------------------------------------------------------
# Author: Robert Enojado
# Date: 12/31/2020

# Description: This script runs when the other foods option is selected
# 	from the main menu. The menu and products are read from wings.data,
#	sides.data, or pasta.data, depending on user selection. The selection
#	is then saved to cart.data for the main script to process.

default="\e[0m"
red="\e[31m"
green="\e[32m"
blue="\e[94m"

function showGraphic() {
	printf "%*s\n" $(((47+$COLUMNS)/2)) "                                          _.oo."
	printf "%*s\n" $(((48+$COLUMNS)/2)) "                   _.u[[/;:,.         .odMMMMMM'"
	printf "%*s\n" $(((45+$COLUMNS)/2)) "                 .o888UU[[[/;:-.  .o@P^    MMM^"
	printf "%*s\n" $(((42+$COLUMNS)/2)) "                oN88888UU[[[/;::-.        dP^"
	printf "%*s\n" $(((37+$COLUMNS)/2)) "               dNMMNN888UU[[[/;::-.   .o@P^"
	printf "%*s\n" $(((30+$COLUMNS)/2)) "              ,MMMMMMN888UU[[/;::-. o@^"
	printf "%*s\n" $(((24+$COLUMNS)/2)) "              NNMMMNN888UU[[[/~.o@P^"
	printf "%*s\n" $(((21+$COLUMNS)/2)) "              888888888UU[[[/o@^-.."
	printf "%*s\n" $(((20+$COLUMNS)/2)) "             oI8888uu[[[/o@P^:--.."
	printf "%*s\n" $(((18+$COLUMNS)/2)) "          .@^  YUU[[[/o@^;::---.."
	printf "%*s\n" $(((13+$COLUMNS)/2)) "        oMP     ^/o@P^;:::---.."
	printf "%*s\n" $(((9+$COLUMNS)/2)) "     .dMMM    .o@^ ^;::---..."
	printf "%*s\n" $(((6+$COLUMNS)/2)) "    dMMMMMMM@^ \`      \`^^^^"
	printf "%*s\n" $(((-29+$COLUMNS)/2)) "   YMMMUP^"
	printf "%*s\n" $(((-37+$COLUMNS)/2)) "    ^^"
	figlet -w $COLUMNS -c "Pizza Planet"
	echo
}

function showMenu() {
	printf "$green"
	echo "Please choose by selecting a number: "
	echo 
	printf "$default"
	echo "1. Wings"
	echo "2. Sides"
	echo "3. Pasta"
	echo
	echo "0. Return to Main Menu"
	echo
}

function setCurrentSubmenu() {
	file=$1
	totalItems=$(wc -l $file | cut -d " " -f 1)
}

function showSubmenu() {
	printf "$green"
	echo
	echo "Here's our selection: "
	echo
	printf "$default"
	#show items in the sub menu and save the food type with .data to $file
	case $1 in
		1) awk -F: '{print NR". " $1}' wings.data; setCurrentSubmenu "wings.data";;
		2) awk -F: '{print NR". " $1}' sides.data; setCurrentSubmenu "sides.data";;
		3) awk -F: '{print NR". " $1}' pasta.data; setCurrentSubmenu "pasta.data";;
	esac
	echo
}

function menuValidation() { 
	option=""
	min=$1
	max=$2
	prompt=$3
	errorMessage="Invalid input. Please enter a number between [$1-$2]"
	if [[ -n $4 ]]; then errorMessage="$4"; fi
	while [[ ! ($option -ge $min && $option -le $max) ]]; do
		printf "$blue"
		read -p "$prompt >> " option
			if [[ $option == 0 ]]; then
				echo $option
				echo "Returning to Main Menu..."
				sleep 3
				exit
			fi
		if [[ $option -lt $min || $option -gt $max ]]; then
			echo -e "$red$errorMessage $default \n" 
			sleep 2
			printf "\e[1A\e[0K"
			printf "\e[1A\e[0K"
			printf "\e[1A\e[0K"
		fi
	done
}

#------------------------------------------------------------------------------------
# Start of script

until [[ "$confirm" =~ [Yy] ]]
do
	clear
	showGraphic | lolcat
	showMenu
	menuValidation 1 3 "Please select a number [1-3]: "
	showSubmenu $option
	menuValidation 1 $totalItems "Please select a number [1-$totalItems]"
	product=$(awk -v var="$option" '{if(NR==var) print $0}' $file)
	item=$(echo "$product" | cut -d ":" -f1)
	price=$(echo "$product" | cut -d ":" -f2)
	read -p "Great choice, add $item for \$$price to your order? [y/n]: " confirm 
done
# save the order to a file
echo $product >> cart.data
echo "Thank you!, Your order has been added. Returning to the main menu..."
sleep 3