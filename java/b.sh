#!/bin/bash

root=~/Projects/Test/java

rm -rf $root/app.jar $root/classes > /dev/null 2>&1

shopt -s globstar
javac -d $root/classes -cp $(ls -d $root/lib/*.jar | tr "\n" ":") $root/src/**/*.java
shopt -u globstar

jar cfm $root/app.jar $root/manifest.txt -C $root/classes .

java -jar $root/app.jar