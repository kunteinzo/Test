#!/bin/bash

echo Select project to run
echo __________________

select i in C C++ Java Kotlin PHP Python exit
do
	echo
	case $i in
		C)
			echo $i
		;;
		
		C++)
			echo $i
		;;

		Java)
			java/b.sh
		;;

		Kotlin)
			kotlin/b.sh
		;;

		PHP)
			pho/b.sh
		;;

		Python)
			echo $i
		;;

		exit) 
			echo Cancel
		;;
	esac
	echo
	exit
done