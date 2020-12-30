#!/bin/bash 
#Welcome greetings!!!

echo "Veggie lovers, you are not left out here. Proceed through our menu selections."

sleep 3

#Sizes and Prices
pizza="Veggie lovers pizza"
small=7.25; medium=9.99; large=12.25

function showOptions {

clear
echo "$pizza"
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
echo "Which size of $pizza do you like?"
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
echo "Which crust of the $pizza do you want?"
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
until [ "$question" =="y" ]
do
showOptions
getOrder
read -p "Add a $size $crust $pizza for $price to your order? [Y/N] >> " yn
case $yn in
[Yy]* ) echo "Thanks!!! your order has been added to your cart"; break;;
[Nn]* ) echo "No problems, lets take your order again."; break;;
esac
done
read question
echo "$question"
done
echo "$size:$crust:$pizza:$price" >> cart.data
echo "Thank you $name!, your order has been added. Returning to the main menu ..."
sleep 3
