#!/bin/bash

root=~/Projects/Test/kotlin
rm $root/app.jar > /dev/null 2>&1

shopt -s globstar
kotlinc $root/src/**/*.kt -include-runtime -d $root/app.jar
shopt -u globstar
if [ $? -ne 0 ];then
	echo
	echo "Failed to compile Kotlin app!"
	exit 1
fi

echo
kotlin $root/app.jar