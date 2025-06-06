#!/bin/bash

# for Termux and Linux
root=~/Projects/Test

mbash() {
    cd $root/bash
    ./app.sh
    exit
}

mc() {
    cd $root/clang
    rm app
    clang *.c -o app
    ./app
    exit
}

mcpp() {
    cd $root/cpp
    rm app
    g++ *.cpp -o app
    ./app
    exit
}

mjava() {
    cd $root/java
    rm -rf app.jar classes > /dev/null 2>&1
    shopt -s globstar
    javac -d classes -cp $(ls -d lib/*.jar | tr "\n" ":") src/**/*.java
    shopt -u globstar
    jar cfm app.jar manifest.txt -C classes .
    java -jar app.jar
    exit
}

mjs() {
    cd $root/javascript
    node app.js
    exit
}

mkt() {
    cd $root/kotlin
    #rm -rf app.jar classes > /dev/null 2>&1
    #shopt -s globstar
    #kotlinc src/**/*.kt -include-runtime -cp $(ls -d lib/*.jar | tr "\n" ":") -d classes -Xallow-no-source-files
    #shopt -u globstar
    #jar cfm app.jar manifest.txt -C classes . -C lib .
    #kotlin app.jar
    
    shopt -s globstar
    kotlinc src/**/*.kt -include-runtime -d app.jar
    kotlin app.jar
    exit
}

mphp() {
    cd $root/php
    echo Run PHP Script or Server?
    echo
    select i in Script Server Exit
    do
    case $i in
        Script)
            php -f index.php -c php.ini
            exit
        ;;
        Server)
            php -S 0.0.0.0:8000 -c php.ini -t ./
        ;;
        Exit)
            exit
        ;;
    esac
    done
}

mpy() {
    cd $root/python
    python3 main.py
    exit
}

main() {
    echo
    echo -e "\033[0;33mRun A Program\033[0m"
    echo
    select i in Bash C C++ Java JavaScript Kotlin PHP Python Exit
    do
        echo
        case $i in
            Bash) mbash;;
            C) mc;;
            C++) mcpp;;
            Java) mjava;;
            JavaScript) mjs;;
            Kotlin) mkt;;
            PHP) mphp;;
            Python) mpy;;
            Exit) exit;;
            *) main;;
        esac
    done
}

main