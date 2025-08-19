#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

// DFA that accepts every string that starts with '01'
void processString(int *string)
{
    printf("\nProcessing: %d\n", *string);
}
int main()
{

    int input[] = {1, 0, 1, 1, 1,2, 1, 1, 1, 0};
    int lenOfInput = (sizeof(input) / sizeof(input[0])) - 1;
    int currState = 0;
    int is_invalid=0;

    for (int i = 0; i <= lenOfInput; i++)
    {
        if (input[i] != 0 && input[i] != 1)
        {
            printf("\nContains invalid symbols. Rejected!\n");
            return -1;
        }
    }
   for (int i = 0; i <= lenOfInput; i++)
        {
            switch (currState)
            {
            case 0:
                if (input[i] == 0)
                {
                    // moveToNext state
                    processString(&input[i]);
                    sleep(1);
                    currState = 1;
                    printf("q0 --0--> q1");
                }
                else if (input[0] == 1)
                {
                    processString(&input[i]);
                    sleep(1);
                    printf("q0 --1--> dead state\n");
                    currState = -1;
                    break;
                }
                break;
            case 1:
                if (input[i] == 1)
                {
                    // moveToNext state
                    processString(&input[i]);
                    sleep(1);
                    printf("q1 --1--> q2");
                    currState = 2;
                }
                else if (input[i] == 0)
                {
                    processString(&input[i]);
                    sleep(1);
                    printf("q1 --0--> dead state\n");
                    currState = -1;
                    break;
                }
                break;
            case 2:
                if (input[i] == 0 || input[i] == 1)
                {
                    processString(&input[i]);
                    sleep(1);
                    printf("q2--0,1-->q2");
                    currState = 2;
                }
                break;
            case -1:
                if (input[i] == 0 || input[i] == 1)
                {
                    processString(&input[i]);
                    sleep(1);
                    printf("dead state --0,1--> dead state\n");
                    currState = -1;
                    break;
                }
            default:
                break;
            }
        }
        sleep(0);
    
    if (currState == 2)
    {
        printf("\nAccepted");
    }
    else
    {
        printf("\nRejected");
    }
    return 0;
}
