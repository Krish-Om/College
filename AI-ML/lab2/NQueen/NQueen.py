# Python Program to solve the n-queens problem


def placeQueens(i, cols, leftDiagonal, rightDiagonal, cur, solutions):
    n = len(cols)

    # base case: If all queens are placed
    # add the solution and continue searching
    if i == n:
        solutions.append(cur[:])
        return

    # Consider the row and try placing
    # queen in all columns one by one
    for j in range(n):

        # Check if the queen can be placed
        if cols[j] or rightDiagonal[i + j] or leftDiagonal[i - j + n - 1]:
            continue

        # mark the cell occupied
        cols[j] = 1
        rightDiagonal[i + j] = 1
        leftDiagonal[i - j + n - 1] = 1
        cur.append(j + 1)

        # Continue searching for more solutions
        placeQueens(i + 1, cols, leftDiagonal, rightDiagonal, cur, solutions)

        # remove the queen from current cell
        cur.pop()
        cols[j] = 0
        rightDiagonal[i + j] = 0
        leftDiagonal[i - j + n - 1] = 0


# Function to find all solutions
# to the N-Queens problem
def nQueen(n):

    # array to mark the occupied cells
    cols = [0] * n
    leftDiagonal = [0] * (n * 2)
    rightDiagonal = [0] * (n * 2)
    cur = []
    solutions = []

    # Find all solutions
    placeQueens(0, cols, leftDiagonal, rightDiagonal, cur, solutions)
    return solutions if solutions else [[-1]]


if __name__ == "__main__":
    n = 8
    solutions = nQueen(n)
    if solutions == [[-1]]:
        print("No solution exists")
    else:
        print(f"Found {len(solutions)} solutions:")
        for idx, solution in enumerate(solutions, 1):
            print(f"\nSolution {idx}:")
            for row in solution:
                line = ["."] * n
                line[row - 1] = "Q"
                print(" ".join(line))
            print()
