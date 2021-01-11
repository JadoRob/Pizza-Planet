#!/bin/bash
#Ask for the preferrred drink
clear
sleep 2
drink=$Drinks
20oz Bottle=2.99;
2-liter Bottle=3.99

function showOptions {
clear

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

echo "Hello welcome to the drinks sections"
echo""
echo "Please view and select the types and sizes of drinks available"
echo ""
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

echo "Which kind of drink do you prefer? [1-8] >> "
read option
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
echo "What size do you want? [9-10] >>"
read option
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

echo "Add a $size of $drink for $price to your order? [y/n] >>"
read question
done

echo "$size:$drink:$price" >> cart.data
echo "Thank you!!! Your order has been added"

 
sleep 2
 
