# Makefile for Operating System Lab Report

MAIN = main
LATEX = pdflatex
BIBTEX = bibtex

# Default target
all: $(MAIN).pdf

# Compile PDF
$(MAIN).pdf: $(MAIN).tex
	$(LATEX) $(MAIN).tex
	$(LATEX) $(MAIN).tex  # Run twice for cross-references
	@echo "PDF generated successfully: $(MAIN).pdf"

# Clean auxiliary files
clean:
	rm -f *.aux *.log *.toc *.out *.fls *.fdb_latexmk *.synctex.gz

# Clean everything including PDF
cleanall: clean
	rm -f $(MAIN).pdf

# Quick compile (single pass)
quick:
	$(LATEX) $(MAIN).tex

# View PDF (if evince is available)
view: $(MAIN).pdf
	@if command -v evince >/dev/null 2>&1; then \
		evince $(MAIN).pdf & \
	elif command -v okular >/dev/null 2>&1; then \
		okular $(MAIN).pdf & \
	elif command -v xdg-open >/dev/null 2>&1; then \
		xdg-open $(MAIN).pdf & \
	else \
		echo "No PDF viewer found. Please open $(MAIN).pdf manually."; \
	fi

# Help
help:
	@echo "Available targets:"
	@echo "  all      - Compile the PDF (default)"
	@echo "  quick    - Quick compile (single pass)"
	@echo "  clean    - Remove auxiliary files"
	@echo "  cleanall - Remove all generated files including PDF"
	@echo "  view     - Open the PDF in default viewer"
	@echo "  help     - Show this help message"

.PHONY: all clean cleanall quick view help
