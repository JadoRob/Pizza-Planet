#!/bin/bash

echo Welcome to Pizza Planet!
read -p "Please enter your name: " name
sed -i "s/customerName=.*/customerName=$name/" data.txt
echo "$name, pick your pizza"