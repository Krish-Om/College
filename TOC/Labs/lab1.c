#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>
#include <string.h>

char *rev(char *s)
{
  char *str = s;
  int l = 0;
  int r = strlen(str) - 1;
  char t;

  while (l < r)
  {

    t = str[l];
    str[l] = str[r];
    str[r] = t;

    l++;
    r--;
  }
  return str;
}
void calculator()
{
  int x, y;
  char op;
  printf("Enter two numbers(x y) :");
  scanf("%d %d", &x, &y);
  printf("Enter the operation (+ - * /):");
  getchar();
  scanf("%c", &op);
p  switch (op)
  {
  case '+':
    printf("Sum:%d\n", x + y);
    break;
  case '-':
    printf("Difference:%d\n", x - y);
    break;
  case '*':
    printf("Product:%d\n", x * y);
    break;
  case '/':
    printf("Division:%f\n", x / y);
    break;
  default:
    printf("Invalid Operation!\n");
    break;
  }
}
int main()
{
  char s[100] = "DAD";
  char *strrev = rev(s);
  printf("%s", strrev);

  printf("\n\n");

  calculator();

  return 0;
}
