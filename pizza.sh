#!/bin/bash
clear
pizza=$1
top1=$2
top2=$3
top3=$4
small=9.99; medium=11.99; large=14.99


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


function pizzaTop {
echo "Welcome to the $pizza pizza section of our menu!"
echo ""
echo "Your selection of $pizza pizza comes with toppings of:  "
if [[ $pizza == "Pepperoni" ]]
then
echo "Double Pepperoni and Chesse"
elif [[ $pizza == "Cheese" ]]
then
echo "Tripple cheese of Motzorella, Cheddar, and Gorgonzolla "
elif [[ $pizza == "Veggie" ]]
then
echo "Red Onions, Mushrooms and Black Olives "
elif [[ $pizza == "Meat" ]]
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
echo "What size $pizza pizza would you like? [1-3] >> "
read option
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
elif (($option == 0))
then
exit
elif (($option != 0 , 1 , 2 , 3))
then
echo "Sorry your selction was not valid please select another number"
getSize
fi
}
function getCrust {
echo "What kind of crust would you like this $pizza pizza to have? [4-6] >> "
read option
if (($option == 4 ))
then
crust="Pan Crust"
elif (($option == 5 ))
then
crust="Thin Crust"
elif (($option == 6))
then
crust="Stuffed Crust"
elif (($option == 0))
then
exit
elif (($option != 0 , 4 , 5 , 6))
then
echo "Sorry your selction was not valid please select another number"
getCrust
fi
}

until [ "$question" == "y" ]
do
showOptions
getSize
getCrust
echo "Add a $size $crust $pizza for $price to your order? [y/n] >> "
read question
done
echo "$size:$crust:$pizza pizza:$price:$top1:$top2:$top3" >> cart.data
echo "Thank you, your order has been added. Returning to the main menu."
sleep 3
exit
