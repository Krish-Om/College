from collections import deque
import random

# jug1_cap = int(input("Enter the capacity of Jug 1:"))
# jug2_cap = int(input("Enter th capacity of Jug 2:"))
# target = int(input("Enter the targeted liters of water:"))


def water_jug_bfs(jug1_capacity=4, jug2_capacity=3, target=2):
    visited = set()
    queue = deque()
    parent = {}  # Track parent state for path reconstruction
    action_taken = {}  # Track what action led to each state

    queue.append((0, 0))  # Start with empty jugs
    parent[(0, 0)] = None
    action_taken[(0, 0)] = "0: Initial state (both jugs empty)"

    while queue:
        jug1, jug2 = queue.popleft()  # j1=0,j2=0

        # If target amount is found in either jug or their sum
        if jug1 == target or jug2 == target or jug1 + jug2 == target:
            # Reconstruct path
            path = []
            actions = []
            current = (jug1, jug2)
            while current is not None:
                path.append(current)
                actions.append(action_taken[current])
                current = parent[current]
            path.reverse()
            actions.reverse()

            print(
                f"✅ Target {
                  target} can be reached with state ({jug1}, {jug2})"
            )
            print("=" * 60)
            print("🎯 SOLUTION PATH:")
            print("=" * 60)
            for step, (state, action) in enumerate(zip(path, actions)):
                print(f"Step {step}: {action} → {state}")
                if step < len(path) - 1:
                    print("    ↓")
            print(
                f"\n🏆 Success! Reached target {
                  target} in {len(path) - 1} steps!"
            )
            return True

        # If already visited this state, skip
        if (jug1, jug2) in visited:
            continue
        visited.add((jug1, jug2))

        # Possible operations with action descriptions
        possible_states = [
            ((jug1_capacity, jug2), f"1: Fill jug1 (capacity {jug1_capacity})"),
            ((jug1, jug2_capacity), f"2: Fill jug2 (capacity {jug2_capacity})"),
            ((0, jug2), "3: Empty jug1"),
            ((jug1, 0), "4: Empty jug2"),
            # Pour jug1 → jug2
            (
                (
                    jug1 - min(jug1, jug2_capacity - jug2),
                    jug2 + min(jug1, jug2_capacity - jug2),
                ),
                f"5: Pour jug1 → jug2 (transfer {
                    min(jug1, jug2_capacity - jug2)
                } units)",
            ),
            # Pour jug2 → jug1
            (
                (
                    jug1 + min(jug2, jug1_capacity - jug1),
                    jug2 - min(jug2, jug1_capacity - jug1),
                ),
                f"6: Pour jug2 → jug1 (transfer {
                    min(jug2, jug1_capacity - jug1)
                } units)",
            ),
        ]

        for state, action_description in possible_states:
            if state not in visited and state not in parent:
                queue.append(state)
                parent[state] = (jug1, jug2)
                action_taken[state] = action_description

    print(f"Target {target} cannot be reached.")
    return False


water_jug_bfs()
