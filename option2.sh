#!/bin/bash

pizza="Meat Lover's Pizza"
small=9.99; medium=11.99; large=14.99

function showOptions {
clear
echo "$pizza"
echo ""
echo "Please choose by selecting a number:"
echo ""
echo "Size				Crust"
echo "1. Small			4. Pan Crust"
echo "2. Medium			5. Thin Crust"
echo "3. Large			6. Stuffed Crust"
echo "0. Back to main menu"
echo ""
}
function getOrder {
echo "What size $pizza would you like?"
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
fi
echo "What kind of crust would you like this $pizza to have?"
read option
if (($option == 4))
then
crust="Pan Crust"
elif (($option == 5))
then
crust="Thin Crust"
else
crust="Stuffed Crust"
fi
}
until [ "$question" == "y" ]
do
showOptions
getOrder
echo "Add a $size $crust $pizza for $price to your order?"
read question
echo "$question"
done
echo "$size:$crust:$pizza:$price" >> cart.data
echo "Thank you $name!, your order has been added. Returning to main menu ..." 
sleep 3
