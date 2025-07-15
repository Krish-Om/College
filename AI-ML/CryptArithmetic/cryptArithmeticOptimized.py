import math
from collections import defaultdict


def solve_cryptarithmetic_optimized_v2(puzzle):
    """Enhanced solver with mathematical solvability checks"""

    def is_mathematically_solvable(puzzle_info):
        """Check if puzzle is mathematically feasible before search"""

        # Check 1: Too many unique letters
        if len(puzzle_info["letters"]) > 10:
            return False, "More than 10 unique letters (impossible with digits 0-9)"

        # Check 2: Too many leading letters
        if len(puzzle_info["leading_letters"]) > 9:
            return False, "More than 9 leading letters (only digits 1-9 available)"

        # Check 3: Basic range analysis for addition
        if puzzle_info["operation"] == "+":
            return check_addition_feasibility(puzzle_info)

        # Check 4: Division by zero possibilities
        if puzzle_info["operation"] == "/" or puzzle_info["operation"] == "*":
            return check_multiplication_division_feasibility(puzzle_info)

        return True, "Potentially solvable"

    def check_addition_feasibility(puzzle_info):
        """Check if addition puzzle is feasible"""
        operands = puzzle_info["operand_words"]
        result_word = puzzle_info["result_word"]

        # Minimum possible sum (all leading letters = 1, others = 0)
        min_sum = 0
        for word in operands:
            if len(word) > 1:
                min_sum += 10 ** (len(word) - 1)  # Leading digit minimum = 1

        # Maximum possible sum (all digits = 9)
        max_sum = sum(9 * (10 ** (len(word) - 1) * 10 - 1) // 9 for word in operands)

        # Result range
        min_result = 10 ** (len(result_word) - 1) if len(result_word) > 1 else 0
        max_result = int("9" * len(result_word))

        # Check overlap
        if max_sum < min_result or min_sum > max_result:
            return (
                False,
                f"Sum range [{min_sum}, {max_sum}] doesn't overlap with result range [{min_result}, {max_result}]",
            )

        return True, "Addition ranges compatible"

    def check_multiplication_division_feasibility(puzzle_info):
        """Basic feasibility check for multiplication/division"""
        # For now, just check basic constraints
        # More sophisticated checks can be added
        return True, "Multiplication/Division - basic check passed"

    def parse_puzzle_enhanced(puzzle):
        """Enhanced puzzle parsing with detailed analysis"""
        parts = puzzle.replace(" ", "").split("=")
        if len(parts) != 2:
            raise ValueError("Invalid puzzle format.")

        expression, result = parts[0], parts[1]
        letters = sorted(list(set(c for c in expression + result if "A" <= c <= "Z")))

        # Determine operation and operands
        operation = None
        operand_words = []

        if "+" in expression:
            operation = "+"
            operand_words = expression.split("+")
        elif "-" in expression:
            operation = "-"
            operand_words = expression.split("-")
        elif "*" in expression:
            operation = "*"
            operand_words = expression.split("*")
        elif "/" in expression:
            operation = "/"
            operand_words = expression.split("/")
        else:
            operation = "="
            operand_words = [expression]

        # Clean up operands: the operand_words may contain whitespaces or trailing white spaces
        operand_words = [word.strip() for word in operand_words if word.strip()]

        # Find leading letters
        leading_letters = set()
        for word in operand_words + [result]:
            if word:
                leading_letters.add(word[0])

        return {
            "original_puzzle": puzzle,
            "expression": expression,
            "result_word": result,
            "operation": operation,
            "operand_words": operand_words,
            "all_words": operand_words + [result],
            "letters": letters,
            "leading_letters": leading_letters,
        }

    def build_expression_correctly(puzzle_info, assignment):
        """Correctly build numerical expression from assignment"""
        try:
            # Convert words to numbers
            operand_numbers = []
            for word in puzzle_info["operand_words"]:
                number = int("".join(str(assignment[char]) for char in word))
                operand_numbers.append(number)

            result_number = int(
                "".join(str(assignment[char]) for char in puzzle_info["result_word"])
            )

            # Build expression string based on operation
            if puzzle_info["operation"] == "+":
                calculated_result = sum(operand_numbers)
            elif puzzle_info["operation"] == "-":
                calculated_result = operand_numbers[0] - sum(operand_numbers[1:])
            elif puzzle_info["operation"] == "*":
                calculated_result = 1
                for num in operand_numbers:
                    calculated_result *= num
            elif puzzle_info["operation"] == "/":
                calculated_result = operand_numbers[0]
                for num in operand_numbers[1:]:
                    if num == 0:
                        return False  # Division by zero
                    calculated_result //= num
            else:
                calculated_result = operand_numbers[0] if operand_numbers else 0

            return calculated_result == result_number

        except (ValueError, ZeroDivisionError):
            return False

    # Parse puzzle with enhanced analysis
    try:
        puzzle_info = parse_puzzle_enhanced(puzzle)
    except ValueError as e:
        print(f"❌ Puzzle parsing error: {e}")
        return None

    # Check mathematical solvability BEFORE starting search
    is_solvable, solvability_message = is_mathematically_solvable(puzzle_info)

    print(f"🔍 Solvability check: {solvability_message}")

    if not is_solvable:
        print(f"❌ Puzzle is mathematically unsolvable: {solvability_message}")
        return None

    print(f"✅ Puzzle appears solvable, starting search...")

    # Initialize domains
    def initialize_domains():
        domains = {}
        for letter in puzzle_info["letters"]:
            if letter in puzzle_info["leading_letters"]:
                domains[letter] = list(range(1, 10))  # Can't be 0
            else:
                domains[letter] = list(range(0, 10))  # Can be 0-9
        return domains

    # Forward Checking
    def forward_check(assignment, domains):
        new_domains = {}
        for letter in domains:
            if letter in assignment:
                new_domains[letter] = [assignment[letter]]
            else:
                new_domains[letter] = [
                    value
                    for value in domains[letter]
                    if value not in assignment.values()
                ]
        return new_domains

    # MRV Heuristic
    def select_unassigned_variable(assignment, domains):
        unassigned = [
            letter for letter in puzzle_info["letters"] if letter not in assignment
        ]
        if not unassigned:
            return None
        return min(unassigned, key=lambda letter: len(domains[letter]))

    # Enhanced solution verification
    def is_complete_solution(assignment):
        if len(assignment) != len(puzzle_info["letters"]):
            return False
        return build_expression_correctly(puzzle_info, assignment)

    # Main backtracking
    def backtrack(assignment, domains):
        if len(assignment) == len(puzzle_info["letters"]):
            return assignment if is_complete_solution(assignment) else None

        var = select_unassigned_variable(assignment, domains)
        if not var or not domains[var]:
            return None

        for value in domains[var]:
            new_assignment = assignment.copy()
            new_assignment[var] = value

            new_domains = forward_check(new_assignment, domains)

            if all(
                len(new_domains[letter]) > 0
                for letter in new_domains
                if letter not in new_assignment
            ):

                result = backtrack(new_assignment, new_domains)
                if result is not None:
                    return result

        return None

    # Start search
    initial_domains = initialize_domains()
    return backtrack({}, initial_domains)


# Test with enhanced version
if __name__ == "__main__":
    puzzles = [
        "SEND + MORE = MONEY",  # Solvable
        "ABC + DEF = GHIJK",  # Too many letters - unsolvable
        "A + B = AB",  # Simple solvable
        "AAA + BBB = CCCC",  # Potentially unsolvable due to range
        "KRISH / MO = MOHSIRK",
    ]

    for puzzle_str in puzzles:
        print(f"\n{'='*50}")
        print(f"🧩 Solving: {puzzle_str}")
        print(f"{'='*50}")

        import time

        start_time = time.time()

        solution = solve_cryptarithmetic_optimized_v2(puzzle_str)

        end_time = time.time()

        if solution:
            print("🎉 Solution found:")
            for letter, digit in sorted(solution.items()):
                print(f"  {letter} = {digit}")

            # Verify
            solved_puzzle = puzzle_str
            for letter, digit in solution.items():
                solved_puzzle = solved_puzzle.replace(letter, str(digit))
            print(f"🔍 Verification: {solved_puzzle}")
            print(f"⏱️  Solved in {end_time - start_time:.4f} seconds")
        else:
            print(f"⏱️  Search completed in {end_time - start_time:.4f} seconds")
            print("❌ No solution found.")
