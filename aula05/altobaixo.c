#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main (int argc, char **argv){

    if (argc != 3) {
        printf("Needs 2 arguments to work! One min number and one max!\n");
        exit(0);
    }

    int min_limit = atoi(argv[1]);
    int max_limit = atoi(argv[2]);
    int count = 0;
    int number_player;
    int rand_number = (rand() % (max_limit - min_limit + 1)) + min_limit;

    printf("Insere um número:");
    scanf("%d", &number_player);
    count++;
    while (number_player != rand_number){
        count++;
        if (number_player < rand_number){
            printf("O número secreto é mais alto!\n");
        }

        else
        {
            printf("O número secreto é mais baixo!\n");
        }
        printf("Insere um número:");
        scanf("%d", &number_player);
    }

    printf("ACERTOU!\n");
    printf("Realizou %d tentativas.\n", count);
    return 0;
    
}