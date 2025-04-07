#!/bin/bash

clear
echo "Building C"
clang main.c -o capp
sleep 1
clear
./capp

sleep 2
clear

echo "Building C++"
g++ main.cpp -o cppapp
sleep 1
clear
./cppapp

sleep 2
clear
echo "Done"
sleep 1
clear
