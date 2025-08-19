#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// NFA that accepts every string that starts with '01'

// NFA States:
// q0: Initial state
// q1: After reading '0'
// q2: After reading '01' (Accepting state)

// Function to print current active states
void printStates(int states[], int numStates, char input)
{
    printf("Input '%c' -> Active states: { ", input);
    for (int i = 0; i < numStates; i++)
    {
        if (states[i])
        {
            printf("q%d ", i);
        }
    }
    printf("}\n");
}

// Function to process input through NFA
int processNFA(char *input)
{
    int len = strlen(input);

    // States: 0=q0(initial), 1=q1(after '0'), 2=q2(accepting, after '01')
    int currentStates[3] = {1, 0, 0}; // Start in q0
    int nextStates[3];

    printf("\nProcessing string: \"%s\"\n", input);
    printf("Initial state: { q0 }\n");
    printf("-------------------\n");

    for (int i = 0; i < len; i++)
    {
        char c = input[i];

        // Initialize next states
        nextStates[0] = 0;
        nextStates[1] = 0;
        nextStates[2] = 0;

        // Process transitions based on current states
        for (int state = 0; state < 3; state++)
        {
            if (currentStates[state])
            {
                switch (state)
                {
                case 0: // q0 (initial state)
                    if (c == '0')
                    {
                        nextStates[1] = 1; // q0 --0--> q1
                        printf("q0 --'%c'--> q1\n", c);
                    }
                    // No transition on '1' from q0 (dead end)
                    break;

                case 1: // q1 (after reading '0')
                    if (c == '1')
                    {
                        nextStates[2] = 1; // q1 --1--> q2
                        printf("q1 --'%c'--> q2 (accepting)\n", c);
                    }
                    // No transition on '0' from q1 (dead end)
                    break;

                case 2: // q2 (accepting state, after '01')
                    if (c == '0' || c == '1')
                    {
                        nextStates[2] = 1; // q2 --0,1--> q2 (stay accepting)
                        printf("q2 --'%c'--> q2 (remain accepting)\n", c);
                    }
                    break;
                }
            }
        }

        // Update current states
        for (int j = 0; j < 3; j++)
        {
            currentStates[j] = nextStates[j];
        }

        printStates(currentStates, 3, c);
        sleep(1);
    }

    printf("-------------------\n");

    // Check if we're in accepting state (q2)
    return currentStates[2];
}

int main()
{
    char input[100];
    int choice;

    printf("======================================\n");
    printf("NFA: Accepts strings starting with '01'\n");
    printf("======================================\n");

    printf("\nNFA Structure:\n");
    printf("States: q0 (initial), q1 (after '0'), q2 (accepting, after '01')\n");
    printf("Transitions:\n");
    printf("  q0 --0--> q1\n");
    printf("  q1 --1--> q2\n");
    printf("  q2 --0,1--> q2\n");
    printf("Accepting state: q2\n");
    printf("Language: All strings starting with '01'\n\n");

    // Test cases
    char testStrings[][20] = {
        "01",
        "010",
        "011",
        "0101",
        "01110",
        "10",
        "001",
        "1",
        "0",
        "01001101"};

    int numTests = sizeof(testStrings) / sizeof(testStrings[0]);

    printf("=== Testing predefined strings ===\n");

    for (int i = 0; i < numTests; i++)
    {
        printf("\nTest %d:\n", i + 1);
        int result = processNFA(testStrings[i]);

        if (result)
        {
            printf("Result: \"%s\" is ACCEPTED ✓\n", testStrings[i]);
        }
        else
        {
            printf("Result: \"%s\" is REJECTED ✗\n", testStrings[i]);
        }

        printf("----------------------------------------\n");
    }

    printf("\n=== Interactive Testing ===\n");

    while (1)
    {
        printf("\nEnter a binary string to test (or 'quit' to exit): ");
        scanf("%s", input);

        if (strcmp(input, "quit") == 0)
        {
            break;
        }

        // Validate input
        int valid = 1;
        for (int i = 0; i < strlen(input); i++)
        {
            if (input[i] != '0' && input[i] != '1')
            {
                valid = 0;
                break;
            }
        }

        if (!valid)
        {
            printf("Error: Please enter only binary digits (0 and 1)\n");
            continue;
        }

        int result = processNFA(input);

        if (result)
        {
            printf("Result: \"%s\" is ACCEPTED ✓\n", input);
            printf("Reason: String starts with '01'\n");
        }
        else
        {
            printf("Result: \"%s\" is REJECTED ✗\n", input);
            printf("Reason: String does not start with '01'\n");
        }
    }

    printf("\nThank you for testing the NFA!\n");
    return 0;
}
