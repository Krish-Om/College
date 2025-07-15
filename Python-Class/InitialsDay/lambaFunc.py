# expression = lambda x : "Even" if x%2==0 else "Odd"
# print(expression(int(input("Enter a number"))))

# express = lambda x: x ** 2 + 3*x

# print(express(3))

# check  = lambda x : "+ve" if x > 0 else ("-ve" if x <0 else "neutral")
# print(check(-1))
# print(check(1))
# print(check(0))

#
# def check(x):
#     return (
#         "1st"
#         if x >= 90
#         else (
#             "2nd"
#             if (x >= 80 and x < 90)
#             else (
#                 "3rd"
#                 if (x >= 70 and x < 80)
#                 else (
#                     "4th"
#                     if (x >= 60 and x < 70)
#                     else ("5th" if (x >= 50 and x < 60) else "fail")
#                 )
#             )
#         )
#     )
#
#
# print(check(90))
# print(check(80))
# print(check(70))
# print(check(60))
# print(check(50))
# print(check(40))

rmyList = [
    "apple",
    "banana",
    "cherry",
    "banana",
    "cherry",
    "banana",
    "apple",
]  # mutable, dupilcates, mulitple datatype, ordered, heterogenous, slower than array
mySet = ()  # immutable, non-duplicaable, fixed

names = ["Abish", "Nabin", "Krishom"]
# for x in myList:
#     print(x)
#

# for i in range(len(myList)):
#     print(f"{myList[i]}")
#     # print(f"{myList[i]} for {names[i]}")


myList.insert(0, "Watermelon")
myList.append("Arse")


print(myList)
