#!/bin/bash

if ! type jq >/dev/null 2>&1
then
    sudo apt-get -y install jq
fi

if ! type figlet >/dev/null 2>&1
then
    sudo apt-get -y install figlet
fi

if ! type lolcat >/dev/null 2>&1
then
    sudo apt-get -y install lolcat
fi