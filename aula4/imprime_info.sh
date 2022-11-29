#!/bin/bash 
function imprime_info()
{
    echo $(date)
    echo $HOSTNAME 
    echo $USER
    return 0
}