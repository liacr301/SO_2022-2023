#!/bin/bash 
echo "Write a number:"
read var1;
echo "Write another number:"
read var2;


function compare() {

    if [[ $var1 == $var2 ]] ; then
        return 0;

    else
        if [[ $var1 > $var2 ]]; then
            return 1; # 1º é maior do que 2º

        else
            return 2; # 1ª é menor do que 2ª

        fi
    fi
}

compare $var1 $var2

