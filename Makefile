DOC = "WGUnderwood"

all: format latex todo compress thumbnail warn spell

.PHONY: format latex compress thumbnail warn clean spell

format:
	@echo -e "\e[0;35m\033[1mFormatting...\e[0;30m\033[0m"
	@latexindent-fast $(DOC).tex
	@latexindent-fast $(DOC).bib
	@latexindent-fast wgu-cv.cls

latex:
	@echo -e "\e[0;35m\033[1mBuilding with lualatex...\e[0;30m\033[0m"
	@latexmk -rc-report- -pdflua -quiet $(DOC).tex | \
		grep -v 'Latexmk: Nothing to do for' | grep '^.' || true

compress:
	@echo -e "\e[0;35m\033[1mCompressing PDF...\e[0;30m\033[0m"
	@compress-pdf $(DOC).pdf
	@compress-pdf $(DOC).pdf

thumbnail:
	@echo -e "\e[0;35m\033[1mBuilding thumbnail...\e[0;30m\033[0m"
	@pdftoppm -png -hide-annotations -scale-to 800 $(DOC).pdf temp
	@convert -bordercolor gray20 -border 3x3 -append temp-*.png temp.png
	@convert temp.png -bordercolor gray20 -border 3x3 temp.png
	@pngquant temp.png -Q 0-10 -f -o thumbnail.png
	@rm -f temp*.png

warn: latex
	@echo -e "\e[0;35m\033[1mChecking for warnings...\e[0;30m\033[0m"
	@tex-check $(DOC).log

spell:
	@echo -e "\e[0;35m\033[1mChecking spelling...\e[0;30m\033[0m"
	@spell-check $(DOC).tex
	@spell-check $(DOC).bib

todo:
	@echo -e "\e[0;35m\033[1mChecking for todos...\e[0;30m\033[0m"
	@todo-finder $(DOC).tex
	@todo-finder $(DOC).bib
	@todo-finder README.md
	@todo-finder wgu-cv.cls

clean:
	@tex-clean
	@rm -f *.html
	@rm -f *.bak[0-9]*
