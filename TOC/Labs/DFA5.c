#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// DFA that checks if given string is valid keyword or identifier of C programming language

// C keywords array
char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "int", "long", "register", "return", "short", "signed", "sizeof", "static",
    "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"};

int numKeywords = 32;

// Function to check if string is a C keyword
int isKeyword(char *str)
{
    for (int i = 0; i < numKeywords; i++)
    {
        if (strcmp(str, keywords[i]) == 0)
        {
            return 1;
        }
    }
    return 0;
}

// DFA to check if string is valid identifier
// States: 0 = start, 1 = valid identifier, -1 = invalid
int isValidIdentifier(char *str)
{
    int state = 0;
    int len = strlen(str);

    if (len == 0)
        return 0;

    printf("\nDFA Processing for identifier '%s':\n", str);
    printf("Initial state: q0\n");

    for (int i = 0; i < len; i++)
    {
        char c = str[i];
        printf("Processing character '%c' at position %d\n", c, i);

        switch (state)
        {
        case 0: // Start state
            if (isalpha(c) || c == '_')
            {
                state = 1;
                printf("q0 --[letter/underscore]--> q1 (valid start)\n");
            }
            else
            {
                state = -1;
                printf("q0 --[invalid]--> q_reject (invalid start character)\n");
                return 0;
            }
            break;

        case 1: // Valid identifier state
            if (isalnum(c) || c == '_')
            {
                state = 1;
                printf("q1 --[letter/digit/underscore]--> q1 (continue valid)\n");
            }
            else
            {
                state = -1;
                printf("q1 --[invalid]--> q_reject (invalid character)\n");
                return 0;
            }
            break;

        default:
            return 0;
        }
    }

    printf("Final state: q%d\n", state);
    return (state == 1);
}

int main()
{
    char input[100];
    int choice;

    printf("=== C Keyword/Identifier Checker using DFA ===\n\n");

    while (1)
    {
        printf("\nEnter a string to check: ");
        scanf("%s", input);

        printf("\nAnalyzing string: '%s'\n", input);
        printf("Length: %d characters\n", (int)strlen(input));

        // Check if it's a valid identifier using DFA
        int validId = isValidIdentifier(input);

        if (validId)
        {
            // Check if it's a keyword
            if (isKeyword(input))
            {
                printf("\nResult: '%s' is a VALID C KEYWORD\n", input);
                printf("Category: Reserved word in C language\n");
            }
            else
            {
                printf("\nResult: '%s' is a VALID C IDENTIFIER\n", input);
                printf("Category: User-defined identifier\n");
            }
        }
        else
        {
            printf("\nResult: '%s' is INVALID\n", input);
            printf("Category: Neither a valid keyword nor identifier\n");
        }

        // Show rules
        printf("\n--- Rules for C Identifiers ---\n");
        printf("1. Must start with letter (a-z, A-Z) or underscore (_)\n");
        printf("2. Can contain letters, digits (0-9), and underscores\n");
        printf("3. Case sensitive\n");
        printf("4. Cannot be a reserved keyword\n");

        printf("\nDo you want to test another string? (1 for Yes, 0 for No): ");
        scanf("%d", &choice);

        if (choice != 1)
        {
            break;
        }
    }

    printf("\nThank you for using the C Keyword/Identifier Checker!\n");
    return 0;
}