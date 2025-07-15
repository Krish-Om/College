from collections import deque


class WaterJugSolver:
    def __init__(self, jug1_capacity=5, jug2_capacity=3, target=4):
        self.jug1_capacity = jug1_capacity  # 4-gallon jug
        self.jug2_capacity = jug2_capacity  # 3-gallon jug
        self.target = target  # Target amount (2 gallons)

    def get_possible_actions(self, state):
        """
        Get all possible actions from current state.
        Returns list of (new_state, action_description) tuples.
        """
        x, y = state  # x = jug1 amount, y = jug2 amount
        actions = []

        # Action 1: Fill jug1 from pump
        if x < self.jug1_capacity:
            actions.append(
                (
                    (self.jug1_capacity, y),
                    f"Fill {self.jug1_capacity}-gallon jug from pump",
                )
            )

        # Action 2: Fill jug2 from pump
        if y < self.jug2_capacity:
            actions.append(
                (
                    (x, self.jug2_capacity),
                    f"Fill {self.jug2_capacity}-gallon jug from pump",
                )
            )

        # Action 3: Empty jug1
        if x > 0:
            actions.append(((0, y), f"Empty {self.jug1_capacity}-gallon jug"))

        # Action 4: Empty jug2
        if y > 0:
            actions.append(((x, 0), f"Empty {self.jug2_capacity}-gallon jug"))

        # Action 5: Pour from jug2 to jug1
        if y > 0 and x < self.jug1_capacity:
            pour_amount = min(y, self.jug1_capacity - x)
            new_x = x + pour_amount
            new_y = y - pour_amount
            actions.append(
                (
                    (new_x, new_y),
                    f"Pour from {self.jug2_capacity}-gallon to {self.jug1_capacity}-gallon jug",
                )
            )

        # Action 6: Pour from jug1 to jug2
        if x > 0 and y < self.jug2_capacity:
            pour_amount = min(x, self.jug2_capacity - y)
            new_x = x - pour_amount
            new_y = y + pour_amount
            actions.append(
                (
                    (new_x, new_y),
                    f"Pour from {self.jug1_capacity}-gallon to {self.jug2_capacity}-gallon jug",
                )
            )

        return actions

    def is_goal_state(self, state):
        """Check if current state contains the target amount in either jug."""
        return (state[0] == self.target or state[1] == self.target or state[0]+ state[1] == self.target)

    def solve(self):
        """
        Solve the water jug problem using BFS.
        Returns the solution path or None if no solution exists.
        """
        initial_state = (0, 0)

        if self.is_goal_state(initial_state):
            return [initial_state]

        # BFS setup
        queue = deque([(initial_state, [])])  # (state, path_to_reach_state)
        visited = {initial_state}

        while queue:
            current_state, path = queue.popleft()

            # Try all possible actions from current state
            for new_state, action in self.get_possible_actions(current_state):
                if new_state not in visited:
                    visited.add(new_state)
                    new_path = path + [(current_state, action, new_state)]

                    # Check if we reached the goal
                    if self.is_goal_state(new_state):
                        return new_path

                    queue.append((new_state, new_path))

        return None  # No solution found

    def print_solution(self, solution_path):
        """Print the solution in a readable format."""
        if not solution_path:
            print("No solution found!")
            return

        print("=== WATER JUG PROBLEM SOLUTION ===")
        print(f"Goal: Get {self.target} gallons in either jug")
        print(
            f"Jug capacities: {self.jug1_capacity} gallons and {self.jug2_capacity} gallons"
        )
        print("\nSolution path:")
        print("Step 0: Initial state (0, 0)")

        for i, (from_state, action, to_state) in enumerate(solution_path, 1):
            print(f"Step {i}: {action}")
            print(f"         {from_state} → {to_state}")

        final_state = solution_path[-1][2] if solution_path else (0, 0)
        print(f"\n🎉 Goal achieved! Final state: {final_state}")
        print(f"Total steps: {len(solution_path)}")


def main():
    """Main function to run the water jug solver."""
    # Create solver instance
    solver = WaterJugSolver(jug1_capacity=5, jug2_capacity=3, target=4)

    print("Solving Water Jug Problem...")
    print("Finding the shortest path to get 2 gallons...")

    # Solve the problem
    solution = solver.solve()

    # Print the solution
    solver.print_solution(solution)


if __name__ == "__main__":
    main()
