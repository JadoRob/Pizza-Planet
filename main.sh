#!/bin/bash

echo Welcome to Pizza Planet!

# Get name and insert into the variable, $name
read -p "Please enter your name: " name

# Updates value of $customerName in data.txt to the value of $name here
sed -i "s/customerName=.*/customerName=\"$name\"/" data.txt

# executes the file. Variables in data.txt now exist here
. data.txt 

echo "$customerName, pick your pizza"