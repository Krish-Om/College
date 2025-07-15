thislist = ["apple", "banana", "cherry"]
tropical = ["mango", "pineapple", "papaya"]

thislist.extend(tropical)
thislist.sort(reverse=True)
print(thislist)

thislist2 = thislist.copy()
thislist2.sort()
print(thislist2)


def myFunc(n):
    return abs(n - 50)


thislist3 = [100, 50, 65, 82, 23]
thislist3.sort(key=myFunc)
print(thislist3)
