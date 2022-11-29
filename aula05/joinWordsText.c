#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// check later!

int main(int argc, char *argv[]) // char **argv == *argv[]
{
    int i;
    char str[1000];
    char letters_only[1000];
    char *letters;

    

    for (i = 1; i < argc; i++)
    {
        if (isalpha(*argv[i]) != 0)
            letters_only[i-1] = *argv[i];
        else
            printf("Elemento não tem apenas números at: %s \n", argv[i]);
    }

    strcpy(str, letters_only[1]);
    for (i=2; i < sizeof(letters_only); i++)
    {
        strcat(str," ");
        strcat(str, letters_only[i]);
    }
    printf("String: %s \n", str);
    return EXIT_SUCCESS;

}