#!/bin/bash

clear

echo "Welcome to our pizza page"
echo ""
echo "Here are our selections for premade pizzas or custom make your own!!" 
echo 1\) Pepperoni Pizza
echo 2\) Meat lovers Pizza
echo 3\) Veggie Pizza
echo 4\) Cheese Pizza
echo 5\) Customize Your Own Pizza
echo 6\) Main Menu

echo ""

echo "Please make your selection from the pizzas above [1-5]"
read -p "or option 6 for main menu >> " choice

case $choice in
1) ./pepperoni.sh ;;
2) ./option2.sh ;;
3) ./Option3.sh ;;
4) ./cheese.sh ;;
5) ./custom.sh;;
6) ./menu2.sh ;;
esac

sleep 2
