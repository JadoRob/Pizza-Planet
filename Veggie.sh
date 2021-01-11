#!/bin/bash 

clear
sleep 2
pizza="Veggie Pizza"
small=7.25; medium=9.99; large=12.25

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

echo "Veggie lovers, you are not left out here. Proceed through our menu selection"
echo ""
echo "Select your preferred number of choice"
echo ""
echo "Size                               Crust"
echo "1. Small                          4. Pan Crust"
echo "2. Medium                         5. Thin Crust"
echo "3. Large                          6. Stuffed Crust"
echo "0. Back to the main menu"
echo ""
}

function getOrder {
echo "Which size of $pizza do you like? [1-3] >> "
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
fi
echo "Which crust of the $pizza do you want? [4-6] >> "
read option
if (($option == 4))
then
crust="Pan Crust"
elif (($option == 5))
then
crust="Thin Crust"
elif (($option == 6))
then
crust="Stuffed Crust"
elif ((option == 0))
then
exit
fi
}
until [ "$question" == "y" ]
do
showOptions
getOrder

echo "Add a $size $crust $pizza for $price to your order? [y/n] >> " 
read question

done

echo "$size:$crust:$pizza:$price" >> cart.data

echo "Thank you your order has been added!!!"

sleep 3
