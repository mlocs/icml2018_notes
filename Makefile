BUILD_NUMBER_FILE=revisions/.lastrev
OBJECTS=main.tex author.tex chapters/introduction.tex chapters/abstract.tex chapters/background.tex chapters/conclusion.tex chapters/results.tex

all: main.tex
	pdflatex main
	mkindex main
	bibtex main
	pdflatex main
	pdflatex main



pdf: all

flatex: flatex.c
	gcc -o flatex flatex.c

revision: main.tex $(BUILD_NUMBER_FILE) flatex
	./flatex main.tex
	mv main.flt revisions/main.REV$(shell cat $(BUILD_NUMBER_FILE)).tex

$(BUILD_NUMBER_FILE): $(OBJECTS)
	@if ! test -f $(BUILD_NUMBER_FILE); then echo 0 > $(BUILD_NUMBER_FILE); fi
	@echo $$(($$(cat $(BUILD_NUMBER_FILE)) + 1)) > $(BUILD_NUMBER_FILE)

public: main.tex
	./flatex main.tex
	sed -e '/^%/d' main.flt > main.public.tex
	

clean:
	rm -f *.aux
	rm -f *.log
	rm -f *~
	rm -f *.blg
	rm -f *.bbl
	rm -f *.toc
	rm -f *.vrb
	rm -f *.nav
	rm -f *.out *.snm

.PHONY: public
