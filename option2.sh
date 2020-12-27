#!/bin/bash

pizza="Meat Lover's Pizza"
small=9.99; medium=11.99; large=14.99

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
echo "What size $pizza would you like?"
read option
cat "$option"
