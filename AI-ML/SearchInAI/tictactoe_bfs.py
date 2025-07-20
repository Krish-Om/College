from collections import deque


class TicTacToeState:
    """Represents a state of the tic-tac-toe game."""

    def __init__(self, o_positions=None, x_positions=None, current_player="O"):
        """
        Initialize a tic-tac-toe state.

        Args:
            o_positions: Set of tuples representing O's positions
            x_positions: Set of tuples representing X's positions
            current_player: 'O' or 'X' indicating whose turn it is
        """
        self.o_positions = o_positions if o_positions else set()
        self.x_positions = x_positions if x_positions else set()
        self.current_player = current_player

    def __str__(self):
        """String representation of the board."""
        board = [["." for _ in range(3)] for _ in range(3)]

        for pos in self.o_positions:
            if 0 <= pos[0] < 3 and 0 <= pos[1] < 3:
                board[pos[0]][pos[1]] = "O"

        for pos in self.x_positions:
            if 0 <= pos[0] < 3 and 0 <= pos[1] < 3:
                board[pos[0]][pos[1]] = "X"

        result = f"Player {self.current_player}'s turn:\n"
        for row in board:
            result += " ".join(row) + "\n"
        return result

    def __hash__(self):
        """Make the state hashable for use in sets and dictionaries."""
        return hash(
            (
                frozenset(self.o_positions),
                frozenset(self.x_positions),
                self.current_player,
            )
        )

    def __eq__(self, other):
        """Check equality of two states."""
        return (
            self.o_positions == other.o_positions
            and self.x_positions == other.x_positions
            and self.current_player == other.current_player
        )

    def get_empty_positions(self):
        """Get all empty positions on the board."""
        all_positions = {(i, j) for i in range(3) for j in range(3)}
        occupied = self.o_positions | self.x_positions
        return all_positions - occupied

    def is_winner(self, player_positions):
        """Check if the given positions form a winning combination."""
        # All possible winning combinations
        winning_combos = [
            # Rows
            {(0, 0), (0, 1), (0, 2)},
            {(1, 0), (1, 1), (1, 2)},
            {(2, 0), (2, 1), (2, 2)},
            # Columns
            {(0, 0), (1, 0), (2, 0)},
            {(0, 1), (1, 1), (2, 1)},
            {(0, 2), (1, 2), (2, 2)},
            # Diagonals
            {(0, 0), (1, 1), (2, 2)},
            {(0, 2), (1, 1), (2, 0)},
        ]

        for combo in winning_combos:
            if combo.issubset(player_positions):
                return True
        return False

    def is_game_over(self):
        """Check if the game is over (win or draw)."""
        return (
            self.is_winner(self.o_positions)
            or self.is_winner(self.x_positions)
            or len(self.o_positions) + len(self.x_positions) == 9
        )

    def get_next_states(self):
        """Generate all possible next states from current state."""
        if self.is_game_over():
            return []

        next_states = []
        empty_positions = self.get_empty_positions()

        for pos in empty_positions:
            if self.current_player == "O":
                new_o_positions = self.o_positions | {pos}
                new_x_positions = self.x_positions
                next_player = "X"
            else:
                new_o_positions = self.o_positions
                new_x_positions = self.x_positions | {pos}
                next_player = "O"

            new_state = TicTacToeState(new_o_positions, new_x_positions, next_player)
            next_states.append(new_state)

        return next_states


def bfs_tictactoe(start_state, target_condition):
    """
    Performs BFS to find a path to a target condition in tic-tac-toe.

    Args:
        start_state: Initial TicTacToeState
        target_condition: Function that returns True if target is reached

    Returns:
        tuple: (path_to_target, all_visited_states)
    """
    if target_condition(start_state):
        return [start_state], [start_state]

    visited = set()
    queue = deque([(start_state, [start_state])])  # (state, path_to_state)
    all_visited = []

    visited.add(start_state)

    while queue:
        current_state, path = queue.popleft()
        all_visited.append(current_state)

        # Generate next possible states
        next_states = current_state.get_next_states()

        for next_state in next_states:
            if next_state not in visited:
                visited.add(next_state)
                new_path = path + [next_state]

                if target_condition(next_state):
                    return new_path, all_visited + [next_state]

                queue.append((next_state, new_path))

    return None, all_visited  # No path found


def build_game_graph(start_state, max_depth=5):
    """
    Build a graph representation of the tic-tac-toe game states.

    Args:
        start_state: Initial state
        max_depth: Maximum depth to explore

    Returns:
        dict: Graph where keys are states and values are lists of next states
    """
    graph = {}
    visited = set()
    queue = deque([(start_state, 0)])  # (state, depth)

    while queue:
        current_state, depth = queue.popleft()

        if current_state in visited or depth > max_depth:
            continue

        visited.add(current_state)
        next_states = current_state.get_next_states()
        graph[current_state] = next_states

        for next_state in next_states:
            if next_state not in visited:
                queue.append((next_state, depth + 1))

    return graph


def bfs_original(graph, start_node):
    """Original BFS function adapted for tic-tac-toe states."""
    if start_node not in graph:
        raise ValueError(f"Start node not found in the graph.")

    visited = set()
    queue = deque()

    visited.add(start_node)
    queue.append(start_node)

    traversal_order = []

    while queue:
        current_node = queue.popleft()
        traversal_order.append(current_node)

        for neighbor in graph.get(current_node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)

    return traversal_order


if __name__ == "__main__":
    # Create the starting state as specified
    # O positions: [0,0], [0,1], [3,0] - Note: [3,0] is invalid (out of bounds), using [2,0]
    # X positions: [0,3], [2,2] - Note: [0,3] is invalid (out of bounds), using [0,2]

    print("=== TIC-TAC-TOE BFS SOLVER ===\n")

    # Corrected starting state (fixing invalid positions)
    start_state = TicTacToeState(
        o_positions={(0, 0), (0, 1), (2, 0)},  # Fixed [3,0] to [2,0]
        x_positions={(0, 2), (2, 2)},  # Fixed [0,3] to [0,2]
        current_player="O",
    )

    print("Starting State:")
    print(start_state)

    # Build the game graph
    print("Building game graph...")
    game_graph = build_game_graph(start_state, max_depth=4)
    print(f"Graph built with {len(game_graph)} states\n")

    # Use original BFS to traverse the game states
    print("BFS Traversal of Game States:")
    traversal = bfs_original(game_graph, start_state)

    print(f"Total states explored: {len(traversal)}\n")

    # Show first few states in traversal
    print("First 5 states in BFS traversal:")
    for i, state in enumerate(traversal[:5]):
        print(f"State {i + 1}:")
        print(state)

    # Find a winning path for O
    def o_wins(state):
        return state.is_winner(state.o_positions)

    print("\n=== SEARCHING FOR O WINNING PATH ===")
    winning_path, all_visited = bfs_tictactoe(start_state, o_wins)

    if winning_path:
        print(f"Found winning path for O in {len(winning_path)} moves!")
        print("\nWinning sequence:")
        for i, state in enumerate(winning_path):
            print(f"Move {i}:")
            print(state)
    else:
        print("No winning path found for O from this position.")
        print(f"Explored {len(all_visited)} states.")

    # Find a winning path for X
    def x_wins(state):
        return state.is_winner(state.x_positions)

    print("\n=== SEARCHING FOR X WINNING PATH ===")
    winning_path_x, all_visited_x = bfs_tictactoe(start_state, x_wins)

    if winning_path_x:
        print(f"Found winning path for X in {len(winning_path_x)} moves!")
        print("\nWinning sequence:")
        for i, state in enumerate(winning_path_x):
            print(f"Move {i}:")
            print(state)
    else:
        print("No winning path found for X from this position.")
        print(f"Explored {len(all_visited_x)} states.")
