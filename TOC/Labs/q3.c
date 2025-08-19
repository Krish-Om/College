#include<string.h>
#include<stdio.h>
#include<stdlib.h>

int main(int argc, char const *argv[])
{
    char str[] ="Samriddhi";
    // char* prefix,suffix,substring;

    int len_of_str = strlen(str);
    printf("Prefixes: \n");
    for (int i = 0; i < len_of_str-1; i++)
    {
        for(int j =0;j<=i;j++){
            printf("%c",str[j]);
        }
        printf("\n");

    }
    printf("\n\nSubstrings:\n");
    for (int i = 1; i < len_of_str-1; i++)
    {
        for(int j = 1;j<=i;j++){
            printf("%c",str[j]);
        }
        printf("\n");
    }

    printf("\n\nSuffixes:\n");
    for(int i=1;i<len_of_str;i++){
        for(int j = 1;j<=i;j++)
        {
            printf("%c",str[j]);
        }
        printf("\n");
    }
        
    return 0;
}
