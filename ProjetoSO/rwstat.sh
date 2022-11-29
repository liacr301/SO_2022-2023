# !/bin/bash 

# Joana Gomes, 
# Lia Cardoso, 107548


#PROBLEMA A RESOLVER --------> leitura dos argumetos, não está a ler o primeiro argumento (segundos) -----> problema em validate_argumments
#arrays para guardar valores
declare -A rchar_ar 
declare -A wchar_ar
declare -A opts 
declare -A info

order_args=0;


#funçao main
function main(){

    if [[ $# -lt 1 ]]; then
        echo "Needs, at least, 1 argumment"
        exit 1
    fi 

    validate_arguments $@ # -----> validar argumentos

    cd /proc/

    pid=$(ps -ef  | grep 'p' | awk '{print $2}') # ---> -ef = todos os processos; grep [p]rocess (stackoverflow)

    for i in $pid ;do
        if [ -d  $i ];then
            cd ./$i
            if [ -r ./io ];then
                rchar=$(cat /proc/$i/io | grep rchar |   grep -o -E '[0-9]+'  )
                wchar=$(cat /proc/$i/io | grep wchar |  grep -o -E '[0-9]+'  )
                rchar_ar[$i]=$rchar 
                wchar_ar[$i]=$wchar 
            fi
            cd ../
        fi
    done

    sleep $seconds #tempo de espera de s segundos para a segunda leitura

    #2ª leitura
    for i in $pid; do
        if [[ ${rchar_ar[$i]} ]];then
            if [ -d  $i ];then
                cd ./$i
                    if [ -r ./io ];then
                        rchar_1=${rchar_ar[$i]} 
                        wchar_1=${wchar_ar[$i]}
                        rchar_2=$(cat /proc/$i/io | grep rchar | grep -o -E '[0-9]+')
                        wchar_2=$(cat /proc/$i/io | grep wchar | grep -o -E '[0-9]+')
                        comm=$(cat /proc/$i/comm | tr " " "_")
                        dif_r="$(($char_2-$rchar_1))"
                        rater=$(echo "scale=2; $dif_r/$1 "| bc -l)
                        dif_w="$(($wchar_2-$wchar_1))"
                        ratew=$(echo "scale=2; $dif_w/$1 "| bc -l)
                        user=$(ls -ld /proc/$i | awk '{print $3}')

                            if [[ -v opts[u] && ! ${opts['u']} == $user ]]; then
                                continue
                            fi

                            #Seleção de processos a utilizar atraves de uma expressão regular
                            if [[ -v opts[c] && ! $comm =~ ${opts['c']} ]]; then
                                continue
                            fi

                            LANG=en_us_8859_1
                            start_date=$(ps -o lstart= -p $i) # data de início do processo atraves do PID
                            date_1=$(date +"%b %d %H:%M" -d "$startDate")
                            date_sec=$(date -d "$startDate" +"%b %d %H:%M"+%s | awk -F '[+]' '{print $2}')

                            if [[ -v opts[s] ]]; then                                                         #Para a opção -s
                                start=$(date -d "${opts['s']}" +"%b %d %H:%M"+%s | awk -F '[+]' '{print $2}') # data mínima

                                if [[ "$date_sec" -lt "$start" ]]; then
                                    continue
                                fi
                            fi

                            if [[ -v opts[e] ]]; then                                                       #Para a opção -e
                                 end=$(date -d "${opts['e']}" +"%b %d %H:%M"+%s | awk -F '[+]' '{print $2}') # data máxima

                                if [[ "$date_sec" -gt "$end" ]]; then
                                    continue
                                fi
                            fi

                            info[$i]=$(printf "%-15s %-15s %10s %15s %15s %15s %15s %15s\n" "$comm" "$user" "$PID" "${rchar_ar[$i]}" "${wchar_ar[$i]}" "$rater" "$ratew" "$date_1")

                            if [[ -v opts[m] || opts[M] ]]; then
                                if [[ -v opts[m] && -v opts[M] ]]; then
                                    pid_min=${opts[m]}
                                    pid_max=${opts[M]}
                                    
                                    if [[ $i > $pid_min && $i < $pid_max ]];then
                                        info[$i] = $(printf "%-15s %-15s %10s %15s %15s %15s %15s %15s\n" "$comm" "$user" "$i" "$rchar[$i]" "$wchar[$i]" "$rater" "$ratew" "$date")
                                    fi

                                elif [[ -v opts[m] ]]; then
                                    pid_min=${opts[m]}
                                    if [[ $i > $pid_min ]]; then
                                        info[$i] = $(printf "%-15s %-15s %10s %15s %15s %15s %15s %15s\n" "$comm" "$user" "$i" "$rchar[$i]" "$wchar[$i]" "$rater" "$ratew" "$date")
                                    fi

                                else
                                    pid_max=${opts[M]}
                                    if [[ $i < $pid_max ]]; then
                                        info[$i] = $(printf "%-15s %-15s %10% %15s %15s %15s %15s %15s\n" "$comm" "$user" "$i" "$rchar[$i]" "$wchar[$i]" "$rater" "$ratew" "$date")
                                    fi
                                fi
                            fi
                    fi
                cd ../
            fi
        fi

    done

    print_table # ---> print da tabela de acordo com opts
}

# menu de opções
function menu(){
	echo "OPÇÕES:"
	echo "  -c   "
	echo "  -s   "
	echo "  -e   "
	echo "  -u   "
	echo "  -m   "
	echo "  -M   "
	echo "  -p   "
	echo "  -r   "
	echo "  -w   "
	echo "Nota: O último argumento tem de ser um número"
	
}

# check if it has arguments 
function validate_arguments(){
    
    re='^[0-9]+([.][0-9]+)?$' #encontrar matches

    # note for later: $OPTARG ---> argumento a seguir a uma opção
    while getopts "c:s:e:u:m:M:p:rw" option ; do 

        if [[ -r "$OPTARG" ]]; then
            opts[$option]="empty"
        else
            opts[$option]="${OPTARG}"
        fi

        case $option in            
            c )
                str = ${opts['c']}
                if [[ ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]]; then
                    echo "ERROR: Invalid regex expression" >&2
                    menu
                    exit 1
                fi
                ;;

            s )
                str=${opt['s']}
                date_check='^((Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)) + [0-9]{1,2} + [0-9]{1,2}:[0-9]{1,2})'
                    if [[ ! "$str" =~ $date_check || ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]]; then
                        echo "ERROR: Invalid date"
                        menu
                        exit 1
                    fi
                ;;

            e )
                str=${opt['e']}
                date_check='^((Jan(uary)?|Feb(ruary)?|Mar(ch)?|Apr(il)?|May|Jun(e)?|Jul(y)?|Aug(ust)?|Sep(tember)?|Oct(ober)?|Nov(ember)?|Dec(ember)?)) + [0-9]{1,2} + [0-9]{1,2}:[0-9]{1,2})'
                    if [[ ! "$str" =~ $date_check || ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]]; then
                        echo "ERROR: Invalid date"
                        menu
                        exit 1
                    fi
                ;;
            
            u )
                
                str=${opts['u']}
                if [[ ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]]; then
                    echo "ERROR: Invalid user"
                    menu
                    exit 1
                fi
                ;;

            m )
                str=${opt['m']}
                if [[ ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]] ; then
                    echo "ERROR: Invalid PID" >&2; 
                    menu
                    exit 1
                fi
                ;;
            
            M)
                str=${opt['M']}
                if [[ ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]] ; then
                    echo "ERROR: Invalid PID" >&2; 
                    menu
                    exit 1
                fi
                ;;

            p)
                str=${opt['p']}
                if [[ ${str:0:1} == "-" || $str =~ $re || $str == "empty" ]] ; then
                    echo "ERROR: Invalid number" >&2; 
                    menu
                    exit 1
                fi
                ;;

            r | w)

                if [[ $order_args != 0 ]]; then
                    echo "ERROR: Invalid number" >&2; 
                    menu
                    exit 1
                else
                    order_args=1
                fi             
                ;;
            *) 
                echo "ERRO: Invalid option ($OPTARG)"
                menu
                exit 1
                ;;
        esac
    done

    if ! [[ ${@: -1} =~ $re ]]; then
        echo "Last argument has to be a number."
        menu
        exit 1
    else
        seconds=${@: -1}
    fi

}

function print_table()
{    
    printf "%-15s %-15s %10s %15s %15s %15s %15s %15s" "COMM" "USER" "PID" "READB" "WRITEB" "RATER" "RATEW" "DATE" 
    
    if [[ -v opts[r] ]]; then # ----> inversa
        order="-rn"
    else
        order="-n"
    fi

    if ! [[ -v opts[p] ]]; then # ----> nº de processos
        p=${#info[@]}
    else
        p=${opts['p']}
    fi

    if [[ -v opts[w] ]]; then
        if  [[ "$ordem" == "-rn" ]]; then
            ordem="-n"
        else
            ordem="-rn"
        fi
        
        printf '%s \n' "${info[@]}" | sort  -k5 $order | head -n $p
    elif [[ "$ordem" == "-rn" ]]; then
        printf '%s \n' "${info[@]}" | sort  -k6 | head -n $p
    else
        printf '%s \n' "${info[@]}" | sort  -k6 -rn | head -n $p
    fi
}


main $@
