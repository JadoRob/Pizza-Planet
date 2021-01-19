#!/bin/bash
clear
pizza=$1
top1=$2
top2=$3
top3=$4
small=9.99; medium=11.99; large=14.99

default="\e[0m"
red="\e[31m"
green="\e[32m"
blue="\e[94m"
yellow="\e[92m"

clear

function showGraphic () {
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
	figlet "Pizza Planet" | lolcat
	echo
}

showGraphic | lolcat

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


function pizzaTop {
printf "$green"
echo "Welcome to the $pizza pizza section of our menu!"
echo ""
echo "Your selection of $pizza pizza comes with toppings of:  "
printf "$blue"
if [[ $pizza == "Pepperoni" ]]
then
echo "Double Pepperoni and Chesse"
elif [[ $pizza == "Cheese" ]]
then
echo "Tripple cheese of Motzorella, Cheddar, and Gorgonzolla "
elif [[ $pizza == "Veggie" ]]
then
echo "Red Onions, Mushrooms and Black Olives "
elif [[ $pizza == "Meat Lovers" ]]
then
echo "Pepperoni, Sausage and Bacon"
elif [[ $pizza == "Hawaiian" ]]
then
echo "Pineapple, Ham and Tomato"
elif [[ $pizza == "Buffalo Chicken" ]]
then
echo "Grilled Chicken, Onions and Jalapeno"
elif [[ $pizza == "Philly Stake and Cheese" ]]
then
echo "Stake, Onions and Green Peppers"
elif [[ $pizza == "Bacon Cheeseburger" ]]
then
echo "Bacon, Beef and Cheese"
elif [[ $pizza == "BBQ Chicken" ]]
then
echo "Grilled Chicken, Bacon and Red Onions"
elif [[ $pizza == "Supreme" ]]
then
echo "Pepperoni, Mushrooms and Green Bell Peppers"
fi
}

pizzaTop

function showOptions {
printf "$default"
echo ""
echo "$pizza Pizza Menu Options"
echo ""
echo "Size                      Crust"
echo "1. Small                  4. Pan Crust"
echo "2. Medium                 5. Thin Crust"
echo "3. Large                  6. Stuffed Crust"
echo "0. Back to Main Menu"
echo ""
}

function getSize {
printf "$blue"
menuValidation 1 3 "Please select a size for your $pizza pizza [1-3]: "
size=$option
if (($option == 1))
then
size="Small"
price=$small
elif (($option == 2))
then
size="Medium"
price=$medium
elif (($option == 3))
then
size="Large"
price=$large
fi
}

function getCrust {
printf "$blue"
menuValidation 4 6 "Please select a crust for your $pizza pizza [4-6]: "
crust=$option

if (($option == 4 ))
then
crust="Pan Crust"
elif (($option == 5 ))
then
crust="Thin Crust"
elif (($option == 6))
then
crust="Stuffed Crust"
fi
}

until [ "$question" == "y" ]
do
showOptions
getSize
getCrust

printf "$blue"
echo "Add a $size $crust $pizza for $price to your order? [y/n] >> "
read question
done
printf "$green"
echo "$size:$crust:$pizza pizza:$price:$top1:$top2:$top3" >> cart.data
echo "Thank you, your order has been added. Returning to the main menu."
sleep 3
exit

