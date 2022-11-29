#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv) // char **argv == *argv[]
{
    int i;
    char str[1000];
    strcpy(str, argv[1]);
    for (i=2; i < argc; i++)
    {
        strcat(str," ");
        strcat(str, argv[i]);
    }
    printf("String: %s\n", str);
    return EXIT_SUCCESS;
}
