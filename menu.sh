#!/bin/bash

clear

echo Welcome!

echo "Here's our pizza menu: "
echo ""
echo 1\) Pepperoni Pizza
echo 2\) Meat Lovers Pizza
echo 3\) Veggie Pizza
echo 4\) Cheese Pizza
echo 5\) Hawaiian Pizza
echo ""
read -p "Please pick a premade pizza [1-5] >> " choice

case $choice in
1) ./pizza.sh Pepperoni ;;
2) ./pizza.sh Meat ;;
3) ./pizza.sh Veggie ;;
4) ./pizza.sh Cheese ;;
5) ./pizza.sh Hawaiian ;;
esac
