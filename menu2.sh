#!/bin/bash

clear

echo "Welcome to our menu page"
echo ""
echo "Here are our selections for our restaurant" 
echo 1\) Pizza
echo 2\) Wings
echo 3\) Sides
echo 4\) Drinks
echo 5\) Others
echo ""
sleep 2
read -p "PLease make your selection from above [1-5] >> " choice

case $choice in
1) ./pizza.sh ;;
2) ./wing.sh ;;
3) ./sides.sh ;;
4) ./drinks.sh ;;
5) ./others.sh ;;
esac

sleep 2
