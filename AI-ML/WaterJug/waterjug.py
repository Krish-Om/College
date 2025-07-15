from collections import deque
jug1_cap = int(input("Enter the jug1 capacity:"))
jug2_cap = int(input("Enter the jug2 capacity:"))
target = int(input("Enter the targeted gallons:"))



queue = deque()
visited_states = set()


def water_jug_solver(j1_cap,j2_cap,t):
    d = input("Would you like to give the intial state? (y/n)")
    if d =='y':
        j1_cap =0
        j2_cap =0

    while queue:
        queue.append((j1_cap,j2_cap)) #initial state
