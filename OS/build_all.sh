#!/bin/bash

# Operating System Lab Work Build Script
# This script compiles all the lab programs and organizes them in bin directories

echo "Building Operating System Lab Programs..."
echo "========================================"

# Create bin directories if they don't exist
mkdir -p Lab1/bin
mkdir -p Lab2/bin
mkdir -p lab3/bin
mkdir -p lab4/bin

# Lab 1 - CPU Scheduling Algorithms
echo "Building Lab 1 - CPU Scheduling Algorithms..."
cd Lab1
gcc -g -Wall -Wextra lab1.1.c -o bin/fcfs
gcc -g -Wall -Wextra lab1.2.c -o bin/sjf
gcc -g -Wall -Wextra Lab1.3.c -o bin/round_robin
gcc -g -Wall -Wextra Lab1.4.c -o bin/priority
echo "✓ Lab 1 completed"
cd ..

# Lab 2 - Banker's Algorithm
echo "Building Lab 2 - Banker's Algorithm..."
cd Lab2
gcc -g -Wall -Wextra banker.c -o bin/banker
gcc -g -Wall -Wextra tiny_banker.c -o bin/tiny_banker
gcc -g -Wall -Wextra main.c -o bin/main
echo "✓ Lab 2 completed"
cd ..

# Lab 3 - Page Replacement Algorithms
echo "Building Lab 3 - Page Replacement Algorithms..."
cd lab3
gcc -g -Wall -Wextra lab3_4.c -o bin/fifo
gcc -g -Wall -Wextra lru_page_replacement.c -o bin/lru
gcc -g -Wall -Wextra optimal_page_replacement.c -o bin/optimal
echo "✓ Lab 3 completed"
cd ..

# Lab 4 - Memory Allocation Algorithms
echo "Building Lab 4 - Memory Allocation Algorithms..."
cd lab4
gcc -g -Wall -Wextra first_fit.c -o bin/first_fit
gcc -g -Wall -Wextra best_fit.c -o bin/best_fit
gcc -g -Wall -Wextra worst_fit.c -o bin/worst_fit
echo "✓ Lab 4 completed"
cd ..

echo ""
echo "All lab programs compiled successfully!"
echo "========================================"
echo ""
echo "To run the programs:"
echo "Lab 1: ./Lab1/bin/[fcfs|sjf|round_robin|priority]"
echo "Lab 2: ./Lab2/bin/[banker|tiny_banker|main]"
echo "Lab 3: ./lab3/bin/[fifo|lru|optimal]"
echo "Lab 4: ./lab4/bin/[first_fit|best_fit|worst_fit]"
echo ""
echo "For detailed information, see LAB_REPORT.md"
