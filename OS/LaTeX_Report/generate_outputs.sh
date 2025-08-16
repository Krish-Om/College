#!/bin/bash

# Script to generate outputs for LaTeX report
# This script runs the programs and captures their outputs

echo "Generating outputs for Operating System Lab Report..."
echo "===================================================="

# Create output directory
mkdir -p /home/krishom/College/OS/LaTeX_Report/code_outputs/text_outputs

# Change to OS directory
cd /home/krishom/College/OS

# Ensure all programs are compiled
echo "Building all programs..."
./build_all.sh

echo ""
echo "Generating text outputs..."
echo "=========================="

# Lab 1 outputs (these run automatically)
echo "Lab 1 - CPU Scheduling:"
echo "  Generating FCFS output..."
./Lab1/bin/fcfs > LaTeX_Report/code_outputs/text_outputs/fcfs_output.txt 2>&1

echo "  Generating SJF output..."
./Lab1/bin/sjf > LaTeX_Report/code_outputs/text_outputs/sjf_output.txt 2>&1

echo "  Generating Round Robin output..."
./Lab1/bin/round_robin > LaTeX_Report/code_outputs/text_outputs/rr_output.txt 2>&1

echo "  Generating Priority output..."
./Lab1/bin/priority > LaTeX_Report/code_outputs/text_outputs/priority_output.txt 2>&1

# Lab 2 outputs (tiny_banker runs automatically)
echo ""
echo "Lab 2 - Banker's Algorithm:"
echo "  Generating Tiny Banker output..."
./Lab2/bin/tiny_banker > LaTeX_Report/code_outputs/text_outputs/tiny_banker_output.txt 2>&1

# Lab 4 outputs (these run automatically)
echo ""
echo "Lab 4 - Memory Allocation:"
echo "  Generating First Fit output..."
./lab4/bin/first_fit > LaTeX_Report/code_outputs/text_outputs/first_fit_output.txt 2>&1

echo "  Generating Best Fit output..."
./lab4/bin/best_fit > LaTeX_Report/code_outputs/text_outputs/best_fit_output.txt 2>&1

echo "  Generating Worst Fit output..."
./lab4/bin/worst_fit > LaTeX_Report/code_outputs/text_outputs/worst_fit_output.txt 2>&1

echo ""
echo "========================================="
echo "Text outputs generated successfully!"
echo "========================================="
echo ""
echo "Generated files:"
ls -la LaTeX_Report/code_outputs/text_outputs/
echo ""
echo "Next steps:"
echo "1. For Lab 2 (banker.c, main.c) and Lab 3 programs:"
echo "   - Run them manually as they require user input"
echo "   - Take screenshots during execution"
echo ""
echo "2. Convert text outputs to images using:"
echo "   - Terminal screenshots, or"
echo "   - ImageMagick: convert -font DejaVu-Sans-Mono -pointsize 12 \\"
echo "                           -density 100 -background white -fill black \\"
echo "                           label:@textfile.txt outputfile.png"
echo ""
echo "3. Place all PNG files in LaTeX_Report/code_outputs/"
echo ""
echo "4. Compile LaTeX document:"
echo "   cd LaTeX_Report && make"

# Create a sample input file for interactive programs
echo ""
echo "Creating sample input files for interactive programs..."

# Sample input for page replacement (15 pages, 3 frames)
cat > LaTeX_Report/code_outputs/sample_page_input.txt << 'EOF'
7 0 1 2 0 3 0 4 2 3 0 3 2 1 2
3
EOF

echo "  Created sample_page_input.txt for page replacement programs"
echo "  Usage: ./lab3/bin/fifo < LaTeX_Report/code_outputs/sample_page_input.txt"

echo ""
echo "Manual runs needed for screenshots:"
echo "=================================="
echo "# Lab 2 - Interactive Banker's Algorithm:"
echo "./Lab2/bin/main"
echo ""
echo "# Lab 3 - Page Replacement (use sample input):"
echo "./lab3/bin/fifo < LaTeX_Report/code_outputs/sample_page_input.txt"
echo "./lab3/bin/lru < LaTeX_Report/code_outputs/sample_page_input.txt"
echo "./lab3/bin/optimal < LaTeX_Report/code_outputs/sample_page_input.txt"
