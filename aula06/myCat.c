#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

/* SUGESTÂO: utilize as páginas do manual para conhecer mais sobre as funções usadas:
 man fopen
 man fgets
*/

#define LINEMAXSIZE 80 /* or other suitable maximum line size */


int main(int argc, char *argv[])
{
    FILE *fp = NULL;
    char line [LINEMAXSIZE]; 
    int i;
    int num_line = 0;
    int j;
    int complete;

    /* Validate number of arguments */
    if( argc < 2 )
    {
        printf("USAGE: %s fileName\n", argv[0]);
        return EXIT_FAILURE;
    }
    
    /* Open the file provided as argument */
    for ( i = 1; i < argc; i++) {
        errno = 0;
        fp = fopen(argv[i], "r");
        if( fp == NULL )
        {
            perror ("Error opening file!");
            return EXIT_FAILURE;
        }

        /* Read all the lines of the file */
        j = 1; complete = 1;
        while( fgets(line, sizeof(line), fp) != NULL )
        {
            num_line = num_line + 1;

            if (complete){
                printf("%d ->", j);
            }
            printf("%s", line);
            int linesize = strlen(line);
            if (line[linesize-1]!= '\n') {
                complete = 0;
            }
            else {
                complete = 1;
                j++;
            }
            printf("\n");/* not needed to add '\n' to printf because fgets will read the '\n' that ends each line in the file */
        }

        fclose(fp);
        num_line = 0;
    }

    return EXIT_SUCCESS;
}
