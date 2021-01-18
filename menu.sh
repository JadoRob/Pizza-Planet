#!/bin/bash

clear

default="\e[0m"
red="\e[31m"
green="\e[32m"
blue="\e[94m"
yellow="\e[92m"

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
	figlet "Pizza Planet"  | lolcat
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
                        echo -e "$red$errorMessage $yellow \n" 
                        sleep 2
                        printf "\e[1A\e[0K"
                        printf "\e[1A\e[0K"
                        printf "\e[1A\e[0K"
                fi
        done
}



showGraphic | lolcat
printf "$green"
echo "Welcome!"
echo "Here's our pizza menu: "
printf "$default"
echo ""
echo 1\) Pepperoni Pizza
echo 2\) Meat Lovers Pizza
echo 3\) Veggie Pizza
echo 4\) Cheese Pizza
echo 5\) Hawaiian Pizza
echo 6\) Buffalo Chicken Pizza
echo 7\) Philly Stake and Cheese pizza
echo 8\) Bacon Cheeseburger pizza
echo 9\) BBQ Chicken pizza
echo 10\) Supreme pizza
echo ""

menuValidation 1 10 "Please pick a premade pizza [1-10]: "
choice=$option


case $choice in
1) ./pizza.sh Pepperoni Pepperoni Cheese More\ Pepperoni ;;
2) ./pizza.sh Meat\ Lovers Pepperoni Sausage Bacon ;;
3) ./pizza.sh Veggie Red\ Onions Mushrooms Black\ Olives ;;
4) ./pizza.sh Cheese Motzorella Cheddar Gorgonzolla ;;
5) ./pizza.sh Hawaiian Pineapple Ham Tomatoes ;;
6) ./pizza.sh Buffalo\ Chicken Grilled\ Chicken Onions Jalapeno;;
7) ./pizza.sh Philly\ Stake\ and\ Cheese Stake Onions Green\Peppers;;
8) ./pizza.sh Bacon\ Cheeseburger Bacon Beef Cheese;;
9) ./pizza.sh BBQ\ Chicken Grilled\ Chicken Bacon Red\ Onions;;
10) ./pizza.sh Supreme Pepperoni Mushrooms Green\ Bell\ Peppers;;
esac
