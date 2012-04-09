all: Rxsalba00.tex Rxsalba00.pdf

Rxsalba00.tex: Rxsalba00.Rnw ../logs/bier127/noopt/bier127-noopt.csv ../logs/berlin52/noopt/berlin52-noopt.csv ../logs/berlin52/twoopt/berlin52-twoopt.csv ../analysis/*
	R CMD Sweave Rxsalba00.Rnw

Rxsalba00.pdf: Rxsalba00.tex
	pdflatex Rxsalba00.tex

preview: Rxsalba00.pdf
	evince Rxsalba00.pdf -w

