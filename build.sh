#!/bin/bash

rm capp cppapp > /dev/null 2>&1

s1=0
s2=0

clear

echo "Building C"

clang main.c -o capp > /dev/null 2>&1

if [ $? -ne 0 ];then
	echo
	echo "Failed to build C app!"
	echo
	s1=1
fi

if [ $s1 -eq 0 ];then
	echo "C app was successfully"
	echo
	./capp
	echo
fi

echo
echo "Building C++"

g++ main.cpp -o cppapp > /dev/null 2>&1

if [ $? -ne 0 ];then
	echo
	echo "Failed to build C++ app!"
	echo
	s2=1
fi

if [ $s2 -eq 0 ];then
	echo "C++ app was builded successfully"
	echo
	./cppapp
	echo
fi

if [[ $s1 -eq 0 && $s2 -eq 0 ]];then
	echo
	echo "Done"
	echo
fi

