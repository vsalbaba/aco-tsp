all: Rxsalba00.tex Rxsalba00.pdf preview

Rxsalba00.tex: Rxsalba00.Rnw
	R CMD Sweave Rxsalba00.Rnw

Rxsalba00.pdf: Rxsalba00.tex
	pdflatex Rxsalba00.tex

preview: Rxsalba00.pdf
	evince Rxsalba00.pdf -w

