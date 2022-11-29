#!/bin/bash 
# Conditional block if 
if [[ $1 -gt 5 && $1 -lt 10 ]]; then 
    echo "O arg é maior que 5 e menor que 10" 
else 
    echo "O arg não é maior que 5 e menor que 10" 
fi