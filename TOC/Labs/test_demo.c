#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

// Demo version of DFA that checks if given string is valid keyword or identifier

char *keywords[] = {
    "auto", "break", "case", "char", "const", "continue", "default", "do",
    "double", "else", "enum", "extern", "float", "for", "goto", "if",
    "int", "long", "register", "return", "short", "signed", "sizeof", "static",
    "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"};

int numKeywords = 32;

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

int isValidIdentifier(char *str)
{
    int state = 0;
    int len = strlen(str);

    if (len == 0)
        return 0;

    printf("DFA Processing for '%s':\n", str);

    for (int i = 0; i < len; i++)
    {
        char c = str[i];

        switch (state)
        {
        case 0: // Start state
            if (isalpha(c) || c == '_')
            {
                state = 1;
                printf("  q0 --'%c'--> q1\n", c);
            }
            else
            {
                printf("  q0 --'%c'--> REJECT\n", c);
                return 0;
            }
            break;

        case 1: // Valid identifier state
            if (isalnum(c) || c == '_')
            {
                state = 1;
                printf("  q1 --'%c'--> q1\n", c);
            }
            else
            {
                printf("  q1 --'%c'--> REJECT\n", c);
                return 0;
            }
            break;
        }
    }

    return (state == 1);
}

void testString(char *str)
{
    printf("\n=== Testing: '%s' ===\n", str);

    int validId = isValidIdentifier(str);

    if (validId)
    {
        if (isKeyword(str))
        {
            printf("Result: VALID C KEYWORD\n");
        }
        else
        {
            printf("Result: VALID C IDENTIFIER\n");
        }
    }
    else
    {
        printf("Result: INVALID\n");
    }
}

int main()
{
    printf("C Keyword/Identifier Checker using DFA\n");
    printf("======================================\n");

    // Test cases
    testString("int");        // keyword
    testString("variable");   // valid identifier
    testString("_valid");     // valid identifier with underscore
    testString("var123");     // valid identifier with numbers
    testString("123invalid"); // invalid - starts with digit
    testString("for");        // keyword
    testString("my-var");     // invalid - contains hyphen
    testString("_");          // valid identifier

    return 0;
}
