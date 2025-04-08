#!/bin/bash

root=~/Projects/Test/kotlin
rm $root/app.jar > /dev/null 2>&1

shopt -s globstar
kotlinc $root/src/**/*.kt -include-runtime -cp $(ls -d $root/lib/*.jar | tr "\n" ":") -d $root/classes -Xallow-no-source-files

shopt -u globstar
if [ $? -ne 0 ];then
	echo
	echo "Failed to compile Kotlin app!"
	exit 1
fi

jar cfm $root/app.jar $root/manifest.txt -C $root/classes . -C $root/lib .

echo
kotlin $root/app.jar