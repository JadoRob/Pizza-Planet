#!/bin/bash
#Ask for the preferrred drink
drink=$Drinks
20oz bottle=2.99;
2-liter bottle=3.99
clear
echo "Hello welcome to the drinks sections"
sleep 3

function showOptions {
clear


echo""
echo "Please view the types and sizes of drinks available"
echo ""
echo "Drinks                        Size"
echo "1. Coke                       5. 20oz Bottle"
echo "2. Diet Coke                  6. 2-liter Bottle"
echo "3. Sprite"
echo "4. Root Beer"
echo ""
echo "0. Back to selections"
echo ""
}

function getOrder {
echo "Which kind of drink do you prefer? [1-4] >> "
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

drink="Sprite"
price="$size"

then
drink="Root Beer"
price="$size"
fi
echo "What size do you want? [5-6] >>"
read option
if (($option == 4))
then 
size="20oz bottle"
price="2.99"
else
size="2-liter bottle"
price="3.99"
fi
}
until [ "$question" == "y" ]
do
showOptions
getOrder

echo "Add $size of $drink for $price to your order? [y/n] >>"
read question
done

echo "$size:$drink:$price" >> cart.data
echo "Thank you!!! Your order has been added"

 
sleep 2
 
