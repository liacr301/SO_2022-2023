#!/bin/bash 
# This script checks the existence of a file 
echo "Checking..."
if [ "$#" -lt 1 ]; then
    echo "Número inválido de argumentos"
else
    if [[ -f $1 ]] ; then 
        echo "$1 existe." 
        if [[ -d $1 ]]; then
            echo "$1 é um diretório"
        else
            echo "$1 é um ficheiro"
        fi
        echo "Permissões:"
        {
        [[ -r $1 ]] && echo "Leitura";
        [[ -w $1 ]] && echo "Escrita";
        [[ -x $1 ]] && echo "Execução";
        }

    else 
        echo "$1 não existe" 
    fi 
fi
echo "...done."