#!/bin/bash

clear

echo "Hello $customer welcome to our Pepperoni Pizza section!!"

sleep 2

counter=1
size=(Small Medium Large)
cost=(9.99 11.99 15.99)

for c in ${cost[@]}
do
((counter++))
done

echo "The Pepperoni Pizza will come with pepperoni, cheese and a red tomatoe sauce."

sleep 3

counter=1

echo "These are the sizes we have available for our pepperoni pizza: "
echo "...................."
for s in ${size[@]} 
do
echo "$counter. $s"
((counter++))
done

counter=1

echo "...................."
echo ""
read -p "Please choose a size for your pizza [1-3] >> " selection
if [ $selection -eq 1 ]; then
echo "You have chosen ${size[0]} at ${cost[0]}. Small is always the safe bet!!"
elif [ $selection -eq 2 ]; then
echo "You have chosen ${size[1]} at ${cost[1]}. Medium is the way to go!!"
elif [ $selection -eq 3 ]; then
echo "You have chosen ${size[2]} at ${cost[2]}. Large is a good share size!!"
fi

sleep 2

counter=1
type=(Pan Thin Stuffed)

echo "These are the types of crusts we have available: "
echo "...................."
for t in ${type[@]}
do
echo "$counter. $t"
((counter++))
done
echo "...................."
echo ""
read -p "Please choose a type of crust for your pizza [1-3] >> " crust
if [ $crust -eq 1 ]; then
echo "You have chosen ${type[0]}. Pan is the traditional crust!!"
elif [ $crust -eq 2 ]; then
echo "You have chosen ${type[1]}. Thin is for those healthy eaters!!"
elif [ $crust -eq 3 ]; then
echo "You have chosen ${type[2]}. Stuffed is the best tasting!!"
fi

while true; do
read -p "So far we have $crust and $selection at $cost. Is this order correct? [Y/N] >>  " yn
case $yn in
[Yy]* ) echo "Thank you your order will be sent to your cart!!"; break;;
[Nn]* ) echo "Sorry for the mistake, let us begin again."; break;;
esac
done

read -p "Thank you for your order we are returning you to the main menu ... "

data=($crust $selection)
data >> cart.data
