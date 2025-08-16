# LaTeX Report Structure

This folder contains the LaTeX version of your Operating System Laboratory Report.

## Files Structure:
```
LaTeX_Report/
├── main.tex                 # Main LaTeX document
├── images/                  # Folder for any additional images
├── code_outputs/           # Folder for program output screenshots
│   ├── fcfs_output.png
│   ├── sjf_output.png
│   ├── rr_output.png
│   ├── priority_output.png
│   ├── banker_output.png
│   ├── tiny_banker_output.png
│   ├── fifo_page_output.png
│   ├── lru_page_output.png
│   ├── optimal_page_output.png
│   ├── first_fit_output.png
│   ├── best_fit_output.png
│   └── worst_fit_output.png
└── README.md               # This file
```

## How to Generate Output Screenshots:

1. **Compile all programs:**
   ```bash
   cd /home/krishom/College/OS
   ./build_all.sh
   ```

2. **Run each program and take screenshots:**

   ### Lab 1 - CPU Scheduling:
   ```bash
   ./Lab1/bin/fcfs > fcfs_output.txt
   ./Lab1/bin/sjf > sjf_output.txt
   ./Lab1/bin/round_robin > rr_output.txt
   ./Lab1/bin/priority > priority_output.txt
   ```

   ### Lab 2 - Banker's Algorithm:
   ```bash
   ./Lab2/bin/tiny_banker > tiny_banker_output.txt
   # For banker.c and main.c, you'll need to provide input
   ```

   ### Lab 3 - Page Replacement:
   ```bash
   # These require user input, run interactively:
   ./lab3/bin/fifo
   ./lab3/bin/lru
   ./lab3/bin/optimal
   ```

   ### Lab 4 - Memory Allocation:
   ```bash
   ./lab4/bin/first_fit > first_fit_output.txt
   ./lab4/bin/best_fit > best_fit_output.txt
   ./lab4/bin/worst_fit > worst_fit_output.txt
   ```

3. **Convert text outputs to images:**
   - Use a terminal screenshot tool
   - Or convert text files to images using tools like `convert` (ImageMagick)
   - Save as PNG files in the `code_outputs/` folder

## Compiling the LaTeX Document:

1. **Install required packages:**
   ```bash
   sudo apt-get install texlive-full  # Ubuntu/Debian
   # or
   sudo dnf install texlive-scheme-full  # Fedora
   ```

2. **Compile the document:**
   ```bash
   cd LaTeX_Report
   pdflatex main.tex
   pdflatex main.tex  # Run twice for proper cross-references
   ```

3. **Alternative using latexmk:**
   ```bash
   latexmk -pdf main.tex
   ```

## What to Fill In:

The LaTeX document has several placeholders where you need to add:

1. **Your personal information** in the title section
2. **Performance metrics** in the comparison tables
3. **Output screenshots** (already linked but need to be created)
4. **Manual analysis** in the provided spaces

## Key Features of the LaTeX Report:

- Professional formatting with proper sections
- Code listing support with syntax highlighting
- Figure placeholders for all program outputs
- Tables for performance comparisons
- Comprehensive structure covering all labs
- References section
- Abstract and conclusion
- Table of contents

## Tips:

1. Take clear screenshots of terminal outputs
2. Ensure all images are in PNG format
3. Fill in the performance comparison tables with actual data
4. Update the author information before compilation
5. Run each program multiple times to get consistent results
6. Add any additional analysis or observations in the provided spaces
