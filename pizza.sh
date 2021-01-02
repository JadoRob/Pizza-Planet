#!/bin/bash

clear

echo "Welcome to our pizza page"
echo ""
echo "Here are our selections for premade pizzas" 
echo 1\) Pepperoni Pizza
echo 2\) Meat lovers Pizza
echo 3\) Veggie Pizza
echo 4\) Cheese Pizza
echo ""
sleep 2
read -p "PLease make your selection from the premade pizzas above [1-4] >> " choice

case $choice in
1) ./pepperoni.sh ;;
2) ./option2.sh ;;
3) ./Option3.sh ;;
4) ./cheese.sh ;;
esac

sleep 2
