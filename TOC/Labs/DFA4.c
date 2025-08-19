#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>

// DFA that accepts the string that contains substring '001'
void processString(int *string)
{
    printf("\nProcessing: %d\n", *string);
}
int main()
{

    // Test input containing '001' substring: 1001110110
    int input[] = {1, 0, 0, 1, 1, 1, 0, 1, 1, 0};
    int lenOfInput = (sizeof(input) / sizeof(input[0])) - 1;
    int currState = 0;

    // Validate input - only 0s and 1s allowed
    for (int i = 0; i <= lenOfInput; i++)
    {
        if (input[i] != 0 && input[i] != 1)
        {
            printf("\nContains invalid symbols. Rejected!\n");
            return -1;
        }
    }

    printf("Input string: ");
    for (int i = 0; i <= lenOfInput; i++)
    {
        printf("%d", input[i]);
    }
    printf("\n");

    // Process the input string through the DFA
    for (int i = 0; i <= lenOfInput; i++)
    {
        processString(&input[i]);

        switch (currState)
        {
        case 0: // Initial state
            if (input[i] == 0)
            {
                currState = 1;
                printf("q0 --0--> q1\n");
            }
            else // input[i] == 1
            {
                currState = 0;
                printf("q0 --1--> q0\n");
            }
            break;

        case 1: // Read first '0'
            if (input[i] == 0)
            {
                currState = 2;
                printf("q1 --0--> q2\n");
            }
            else // input[i] == 1
            {
                currState = 0;
                printf("q1 --1--> q0\n");
            }
            break;

        case 2: // Read '00'
            if (input[i] == 1)
            {
                currState = 3; // Accepting state - found '001'
                printf("q2 --1--> q3 (FOUND '001'!)\n");
            }
            else // input[i] == 0
            {
                currState = 2;
                printf("q2 --0--> q2\n");
            }
            break;

        case 3: // Accepting state - substring '001' found
            if (input[i] == 0 || input[i] == 1)
            {
                currState = 3;
                printf("q3 --0,1--> q3 (staying in accepting state)\n");
            }
            break;

        default:
            break;
        }
        sleep(1);
    }

    if (currState == 3)
    {
        printf("\nString ACCEPTED - Contains substring '001'\n");
    }
    else
    {
        printf("\nString REJECTED - Does not contain substring '001'\n");
    }
    return 0;
}
