# Code Output Placeholders

This folder should contain the following screenshot files:

## Lab 1 - CPU Scheduling:
- fcfs_output.png
- sjf_output.png  
- rr_output.png
- priority_output.png

## Lab 2 - Banker's Algorithm:
- banker_output.png
- tiny_banker_output.png

## Lab 3 - Page Replacement:
- fifo_page_output.png
- lru_page_output.png
- optimal_page_output.png

## Lab 4 - Memory Allocation:
- first_fit_output.png
- best_fit_output.png
- worst_fit_output.png

## How to Generate Screenshots:

1. **For automatic programs (no user input):**
   ```bash
   # Run the program and redirect output to a file
   ./program > output.txt
   
   # Then take a screenshot of the terminal or convert text to image
   ```

2. **For interactive programs:**
   ```bash
   # Run the program and manually provide input
   ./program
   # Take screenshot during execution
   ```

3. **Using ImageMagick to convert text to image:**
   ```bash
   convert -font DejaVu-Sans-Mono -pointsize 12 -density 100 \
           -background white -fill black \
           label:@output.txt output.png
   ```

4. **Using terminal screenshot tools:**
   - gnome-screenshot (GNOME)
   - scrot (lightweight)
   - flameshot (advanced)

## Required Image Format:
- Format: PNG
- Resolution: At least 800x600
- Clear, readable text
- Include the complete output

Place all generated images in this folder for the LaTeX document to compile properly.
