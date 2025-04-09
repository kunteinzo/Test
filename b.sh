#!/bin/bash

echo -e "\033[0;33mSelect project to run\033[0m"
echo

# todo: Fix this

root=~/Projects/Test

freset="\033[0m"
fhide="\033[8m"

cno="\033[0m"
cc="\033[48;2;101;154;210m"
ccpp="\033[48;2;0;89;156m"
cjava="\033[48;2;237;139;0m"
ckt="\033[45m"
cphp="\033[48;2;119;123;179m"
cpy="\033[0;30m\033[48;2;255;212;59m"

select i in \
$(echo -e "${cc}${fhide}___${freset}${cc}C${fhide}____${cno}") \
$(echo -e "${ccpp}${fhide}__${freset}${ccpp}C++${fhide}___${cno}") \
$(echo -e "${cjava}${fhide}__${freset}${cjava}Java${fhide}__${cno}") \
$(echo -e "${ckt}${fhide}_${freset}${ckt}Kotlin${fhide}_${cno}") \
$(echo -e "${cphp}${fhide}__${freset}${cphp}PHP${fhide}___${cno}") \
$(echo -e "${cpy}${fhide}_${freset}${cpy}Python${fhide}_${cno}") \
$(echo -e "\033[47mexit${cno}")
do
echo
case $i in
C)
cd $root/clang
clang *.c -o app
./app
;;

C++)
cd $root/cpp
g++ *.cpp -o app
./app
;;

Java)
cd $root/java

rm -rf app.jar classes > /dev/null 2>&1

shopt -s globstar
javac -d classes -cp $(ls -d lib/*.jar | tr "\n" ":") src/**/*.java
shopt -u globstar

jar cfm app.jar manifest.txt -C classes .

java -jar app.jar
;;

Kotlin)
cd $root/kotlin

rm app.jar > /dev/null 2>&1

shopt -s globstar
kotlinc src/**/*.kt -include-runtime -cp $(ls -d lib/*.jar | tr "\n" ":") -d classes -Xallow-no-source-files

shopt -u globstar
if [ $? -ne 0 ];then
echo
echo "Failed to compile Kotlin app!"
exit 1
fi

jar cfm app.jar manifest.txt -C classes . -C lib .

echo
kotlin app.jar
;;

PHP)
cd $root/php
echo Run PHP Script or Server?
echo
select i in Script Server Exit
do
echo
case $i in
Script)
php -f index.php -c php.ini
;;
Server)
php -t ./ -S 0.0.0.0:8000 -c php.ini
;;
Exit)
exit
;;
esac
echo
done
;;
"${cpy}${fhide}_${freset}${cpy}Python${fhide}_${cno}")
cd $root/python
python main.py
;;
exit)
echo
exit
;;
*)
echo
;;
esac
echo
done