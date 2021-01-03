#!/bin/bash
clear
pizza=$1
small=9.99; medium=11.99; large=14.99

function showOptions {
clear

echo "Welcome to the $pizza pizza section of our menu!"
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
function getOrder {
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
./menu.sh
fi
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
./menu.sh
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
echo "Thank you, your order has been added. Returning to the main menu."
sleep 3
./menu.sh
