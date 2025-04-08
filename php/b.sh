#!/bin/bash

root=~/Projects/Test/php

echo Run PHP Script or Server?
echo

select i in Script Server Exit
do
	echo
	case $i in
		Script)
			php -f $root/index.php -c $root/
		;;
		Server)
			php -t $root/ -S 0.0.0.0:8000 -c $root/
		;;
		Exit)
			Cancel
		;;
	esac
	echo
	exit
done