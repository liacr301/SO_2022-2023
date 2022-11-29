#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char *argv[])
{

    char *endarg;
    float res;
    float arg_1;
    float arg_2;
    char option;

     if (argc == 4)
    {
        arg_1 = strtod(argv[1], &endarg);
        if (endarg == argv[1] || *endarg != '\0') // arg vazio ou não estritamente numérico
        {
            printf("1º operando invalido\n");
            return EXIT_FAILURE;
        }
        arg_2 = strtod(argv[3], &endarg);

        if (endarg == argv[3] || *endarg != '\0')
        {
            printf("2º operando invalido\n");
            return EXIT_FAILURE;
        }

        option = *argv[2];
    }
    else return EXIT_FAILURE;

    switch (option)
    {
        case '+':
            res = arg_1 + arg_2;
            printf("%.1lf + %.1lf = %.1lf",arg_1, arg_2, res);
            break;

        case '-':
            res = arg_1 - arg_2;
            printf("%.1lf - %.1lf = %.1lf",arg_1, arg_2, res);
            break;
        
        case '/':
            res = arg_1 / arg_2;    
            printf("%.1lf / %.1lf = %.1lf",arg_1, arg_2, res);
            break;
        
        case 'x':
            res = arg_1 * arg_2;
            printf("%.1lf * %.1lf = %.1lf",arg_1, arg_2, res);
            break;
        
        case 'p':
            res = pow(arg_1,arg_2);
            printf("%.1lf p %.1lf = %.1lf",arg_1, arg_2, res);
            break;

        default:
            printf("Error! operator is not correct");
    }    

    return 0;
}
