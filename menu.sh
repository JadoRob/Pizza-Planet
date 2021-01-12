#!/bin/bash

clear


function showGraphic() {
	echo "                                          _.oo."
	echo "                   _.u[[/;:,.         .odMMMMMM'"
	echo "                 .o888UU[[[/;:-.  .o@P^    MMM^"
	echo "                oN88888UU[[[/;::-.        dP^"
	echo "               dNMMNN888UU[[[/;::-.   .o@P^"
	echo "              ,MMMMMMN888UU[[/;::-. o@^"
	echo "              NNMMMNN888UU[[[/~.o@P^"
	echo "              888888888UU[[[/o@^-.."
	echo "             oI8888uu[[[/o@P^:--.."
	echo "          .@^  YUU[[[/o@^;::---.."
	echo "        oMP     ^/o@P^;:::---.."
	echo "     .dMMM    .o@^ ^;::---..."
	echo "    dMMMMMMM@^ `      `^^^^"
	echo "   YMMMUP^"
	echo "    ^^"
	figlet "Pizza Planet"  | lolcat
	echo
}

showGraphic | lolcat
echo "Welcome!"
echo "Here's our pizza menu: "
echo ""
echo 1\) Pepperoni Pizza
echo 2\) Meat Lovers Pizza
echo 3\) Veggie Pizza
echo 4\) Cheese Pizza
echo 5\) Hawaiian Pizza
echo 6\) Buffalo Chicken Pizza
echo 7\) Philly Stake and Cheese pizza
echo 8\) Bacon Cheeseburger pizza
echo 9\) BBQ Chicken pizza
echo 10\) Supreme pizza
echo ""
read -p "Please pick a premade pizza [1-10] >> " choice

case $choice in
1) ./pizza.sh Pepperoni Pepperoni Cheese More\ Pepperoni ;;
2) ./pizza.sh Meat\ Lovers Pepperoni Sausage Bacon ;;
3) ./pizza.sh Veggie Red\ Onions Mushrooms Black\ Olives ;;
4) ./pizza.sh Cheese Motzorella Cheddar Gorgonzolla ;;
5) ./pizza.sh Hawaiian Pineapple Ham Tomatoes ;;
6) ./pizza.sh Buffalo\ Chicken Grilled\ Chicken Onions Jalapeno;;
7) ./pizza.sh Philly\ Stake\ and\ Cheese Stake Onions Green\Peppers;;
8) ./pizza.sh Bacon\ Cheeseburger Bacon Beef Cheese;;
9) ./pizza.sh BBQ\ Chicken Grilled\ Chicken Bacon Red\ Onions;;
10) ./pizza.sh Supreme Pepperoni Mushrooms Green\ Bell\ Peppers;;
esac
