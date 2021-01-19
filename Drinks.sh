#!/bin/bash
#Ask for the preferrred drink
clear
sleep 2
drink=$Drinks
20oz Bottle=2.99
2-liter Bottle=3.99

default="\e[0m"
red="\e[31m"
green="\e[32m"
blue="\e[94m"
yellow="\e[92m"

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
			echo -e "$red$errorMessage $yellow \n" 
			sleep 2
			printf "\e[1A\e[0K"
			printf "\e[1A\e[0K"
			printf "\e[1A\e[0K"
		fi
	done
}

function showOptions {

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

showGraphic | lolcat

printf "$green"
echo "Hello welcome to the drinks sections"
echo""
echo "Please view and select the types and sizes of drinks available"
echo ""
printf "$default"
echo "Drinks                        Size"
echo "1. Coke                       9. 20oz Bottle"
echo "2. Diet Coke                  10. 2-liter Bottle"
echo "3. Sprite"
echo "4. Pepsi Cola"
echo "5. Mountain Dew"
echo "6. Root Beer"
echo "7. Fanta Orange"
echo "8. Sierra Mist"
echo ""
echo "0. Back to selections"
echo ""

}

function getOrder {

printf "$blue"
menuValidation 1 8 "Which kind of drink do you prefer? [1-8]: "
drink=$option

if (($option == 1))
then
drink="Coke"
price="$size"
elif (($option == 2))
then
drink="Diet Coke"
price="$size"
elif (($option == 3))
then
drink="Sprite"
price="$size"
elif (($option == 4))
then
drink="Pepsi Cola"
price="$size"
elif (($option == 5))
then
drink="Mountain Dew"
price="$size"
elif (($option == 6))
then
drink="Root Beer"
price="$size"
elif (($option == 7))
then
drink="Fanta Orange"
price"=$size"
elif (($option == 8))
then
drink="Sierra Mist"
price="$size"
elif (($option == 0))
then 
exit
fi

menuValidation 9 10 "What size do you want? [9-10]: "
size=$option

if (($option == 9))
then 
size="20oz bottle"
price="2.99"
elif (($option == 10))
then
size="2-liter bottle"
price="3.99"
elif (($option == 0))
then 
exit
fi
}
until [ "$question" == "y" ]
do
showOptions
getOrder

printf "$blue"
echo "Add a $size of $drink for $price to your order? [y/n] >>"
read question
done
printf "$green"
echo "$size:$drink:$price" >> cart.data
echo "Thank you!!! Your order has been added"

sleep 2
exit
