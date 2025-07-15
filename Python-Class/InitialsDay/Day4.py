# # n =int(input("Enter a number:"))
# # prod =1
# # i =1
# # for i in range(1,n+1):
# #     prod *=i

# # print(prod)
# # # while(i<=n):
# # #     prod *= i
# #     i+=1

# # print(prod)
# ## using func

# def factLoop(n=5)->int:
#     prod:int = 1
#     for i in range(1,n+1):
#         prod *= i

#     return prod


# # print(fact())

# # Tail recursion
# def facto(n,i=1)-> int:
#     if n <=1:
#         return i
#     return facto(n-1,n*i)

# # print(fact(5))
# #Normal recursion
# def fact(n=5)-> int:
#     if(n==0 or n ==1):
#         return 1
#     else:
#         return n*fact(n-1)

# #lamda function
# factorial= lambda x : x if(x<=1) else x*factorial(x-1)
# print(factorial(5))


# import math

# print(math.factorial(5))

# key:int = int(input("Enter a key"))
# match key:
#     case 1:
#         print(factLoop())
#     case _:
#         print(0)


# Stack
"""Start of OOP, Data structure"""


class Stack:
    def __init__(self, size):
        self.size: int = size
        self.top: int = -1
        self.stack = [None] * size

    def push(self, x):
        if not (self.top == self.size - 1):
            self.top += 1
            self.stack[self.top]=x
        else:
            return "Overflow"

    def pop(self):
        if not (self.top == -1):
            remove = self.stack[self.top]
            self.top -= 1
            print(f"Removed:{remove}")
        else:    
            return "Underflow"

    def peek(self):
        if not self.top == -1:
            return self.stack[self.top]
        else:
            print("Underflow")

    def display(self):
        if not self.top == -1:
            for x in self.stack:
                print(f"{x}, ")
        else:
            print("Underflow")


def main():
    n = int(input("Enter the stack size:"))
    myStack = Stack(5)

    while True:
        print("1. push()\n 2. pop()\n 3.peek()\n 4.display\n" )
        choice = int(input("Enter your preferred choice:"))
        match choice:
            case 1:
                x = int(input("Enter a value:"))
                myStack.push(x)
                # break
            case 2:
                myStack.pop()
                # break
            case 3:
                print(myStack.peek())
                # break
            case 4:
                myStack.display()
                # break

            case _:
                print("Invalid operation choice")
                # break
                

if __name__ == "main":
    main()
