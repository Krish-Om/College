# OS Lab Report

This folder contains a LaTeX report that embeds your C source files and output screenshots for Labs 1–4.

## Build prerequisites
- TeX Live or another LaTeX distribution with these packages: `geometry`, `hyperref`, `graphicx`, `float`, `caption`, `subcaption`, `xcolor`, `listings`.

## Compile
From this `report/` folder:

```fish
# one-pass compile (may need twice for ToC)
pdflatex main.tex
pdflatex main.tex
```

The resulting PDF will be `main.pdf`.

If images don’t appear, check that the lab folders exist at: `../Lab1`, `../Lab2`, `../lab3`, `../lab4` and contain an `images/` subfolder with the PNGs.
