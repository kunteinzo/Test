#!/bin/bash

root=~/Projects/Test

main() {
    echo
    echo -e "Run A Program"
    echo
    select i in C C++ Java Kotlin PHP Python Exit
    do
        echo
        case $i in
            C) 
                cd $root/clang
                rm app
                clang *.c -o app
                ./app
                exit
            ;;
            C++) 
                cd $root/cpp
                rm app
                g++ *.cpp -o app
                ./app
                exit
            ;;
            Java) 
                cd $root/java
                rm -rf app.jar classes > /dev/null 2>&1
                shopt -s globstar
                javac -d classes -cp $(ls -d lib/*.jar | tr "\n" ":") src/**/*.java
                shopt -u globstar
                jar cfm app.jar manifest.txt -C classes .
                java -jar app.jar
                exit
            ;;
            Kotlin) 
                cd $root/kotlin
                rm -rf app.jar classes > /dev/null 2>&1
                shopt -s globstar
                kotlinc src/**/*.kt -include-runtime -cp $(ls -d lib/*.jar | tr "\n" ":") -d classes -Xallow-no-source-files
                shopt -u globstar
                jar cfm app.jar manifest.txt -C classes . -C lib .
                kotlin app.jar
                exit
            ;;
            PHP) 
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
            ;;
            Python) 
                cd $root/python
                python3 main.py
                exit
            ;;
            Exit) 
                exit
            ;;
            *) main;;
        esac
    done
}
main