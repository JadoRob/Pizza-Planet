#!/bin/bash

clear

counter=1
pizza=Custom\ Pizza
small=9.99; medium=11.99; large=14.99
toppings=("Parmesan Cheese" Ham "Motzorella Cheese" Broccoli Bacon Pepperoni Sausage Pineapple Tomato "Green Peppers" Jalapeno Onions Chicken "Red Peppers")

echo "Welcome to the customize pizza section of our menu!"
echo ""
echo "Custom Pizza Menu Options"
echo ""

function showToppings {

for t in ${!toppings[@]}
do
echo "$counter. ${toppings[$t]}"
((counter++))
done
}

showToppings

echo ""

read -p "Please choose your first topping to add for your pizza >> " sel1

if (($sel1 == 1 ));
then
sel1=${toppings[0]}
elif (($sel1 == 2 ));
then
sel1=${toppings[1]}
elif (($sel1 == 3 ));
then
sel1=${toppings[2]}
elif (($sel1 == 4 ));
then
sel1=${toppings[3]}
elif (($sel1 == 5 ));
then
sel1=${toppings[4]}
elif (($sel1 == 6 ));
then
sel1=${toppings[5]}
elif (($sel1 == 7 ));
then
sel1=${toppings[6]}
elif (($sel1 == 8 ));
then
sel1=${toppings[7]}
elif (($sel1 == 9 ));
then
sel1=${toppings[8]}
elif (($sel1 == 10 ));
then
sel1=${toppings[9]}
elif (($sel1 == 11 ));
then
sel1=${toppings[10]}
elif (($sel1 == 12 ));
then
sel1=${toppings[11]}
elif (($sel1 == 13 ));
then
sel1=${toppings[12]}
elif (($sel1 == 14 ));
then
sel1=${toppings[13]}
fi

read -p "Please choose your second topping to add for your pizza >> " sel2
 
if (($sel2 == 1 ));
then
sel2=${toppings[0]}
elif (($sel2 == 2 ));
then
sel2=${toppings[1]}
elif (($sel2 == 3 ));
then
sel2=${toppings[2]}
elif (($sel2 == 4 ));
then
sel2=${toppings[3]}
elif (($sel2 == 5 ));
then
sel2=${toppings[4]}
elif (($sel2 == 6 ));
then
sel2=${toppings[5]}
elif (($sel2 == 7 ));
then
sel2=${toppings[6]}
elif (($sel2 == 8 ));
then
sel2=${toppings[7]}
elif (($sel2 == 9 ));
then
sel2=${toppings[8]}
elif (($sel2 == 10 ));
then
sel2=${toppings[9]}
elif (($sel2 == 11 ));
then
sel2=${toppings[10]}
elif (($sel2 == 12 ));
then
sel2=${toppings[11]}
elif (($sel2 == 13 ));
then
sel2=${toppings[12]}
elif (($sel2 == 14 ));
then
sel2=${toppings[13]}
fi

read -p "Please choose your third topping to add for your pizza >> " sel3

if (($sel3 == 1 ));
then
sel3=${toppings[0]}
elif (($sel3 == 2 ));
then
sel3=${toppings[1]}
elif (($sel3 == 3 ));
then
sel3=${toppings[2]}
elif (($sel3 == 4 ));
then
sel3=${toppings[3]}
elif (($sel3 == 5 ));
then
sel3=${toppings[4]}
elif (($sel3 == 6 ));
then
sel3=${toppings[5]}
elif (($sel3 == 7 ));
then
sel3=${toppings[6]}
elif (($sel3 == 8 ));
then
sel3=${toppings[7]}
elif (($sel3 == 9 ));
then
sel3=${toppings[8]}
elif (($sel3 == 10 ));
then
sel3=${toppings[9]}
elif (($sel3 == 11 ));
then
sel3=${toppings[10]}
elif (($sel3 == 12 ));
then
sel3=${toppings[11]}
elif (($sel3 == 13 ));
then
sel3=${toppings[12]}
elif (($sel3 == 14 ));
then
sel3=${toppings[13]}
fi

echo ""
echo "Your three toppings were $sel1, $sel2, $sel3 on your custom pizza. "
echo ""



function showOptions {
echo "These are our sizes and crusts available: "
echo ""
echo "Size                      Crust"
echo "1. Small                  4. Pan Crust"
echo "2. Medium                 5. Thin Crust"
echo "3. Large                  6. Stuffed Crust"
echo "0. Back to Main Menu"
echo ""
}

function getOrder {
echo "What size $pizza would you like? [1-3] >> "
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
echo "What kind of crust would you like this $pizza to have? [4-6] >> "
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

showOptions
getOrder

while true; do
read -p "Add a $size $crust $pizza with $sel1, $sel2, $sel3 for $price to your order? [y/n] >> " yn
case $yn in
[Yy]* ) echo "Thank you, your order has been added to the cart!!"; break;;
[Nn]* ) echo "Sorry for the confusion lets begin again."; sleep 2 ;./custom.sh; break;;
esac
done


echo "$size:$crust:$pizza:$price:$sel1:$sel2:$sel3" >> cart.data
echo "Returning to the main menu."
sleep 3
./menu.sh
