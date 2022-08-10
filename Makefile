DOCUMENT = "WGUnderwood"

all: latex todo compress thumbnail warn

.PHONY: latex compress thumbnail warn clean

latex:
	@echo -e "\e[0;35m\033[1mBuilding with lualatex...\e[0;30m\033[0m"
	@latexmk -rc-report- -pdflua -quiet $(DOCUMENT).tex

compress:
	@echo -e "\e[0;35m\033[1mCompressing PDF...\e[0;30m\033[0m"
	@optpdf $(DOCUMENT).pdf
	@optpdf $(DOCUMENT).pdf

thumbnail:
	@echo -e "\e[0;35m\033[1mBuilding thumbnail...\e[0;30m\033[0m"
	@pdftoppm -png -hide-annotations -scale-to 800 $(DOCUMENT).pdf temp
	@convert -bordercolor gray20 -border 3x3 -append temp-*.png temp.png
	@convert temp.png -bordercolor gray20 -border 3x3 temp.png
	@pngquant temp.png -Q 0-10 -f -o thumbnail.png
	@rm -f temp*.png

warn: latex
	@echo -e "\e[0;35m\033[1mChecking for warnings...\e[0;30m\033[0m"
	@tex-log-parse $(DOCUMENT).log
	@tex-log-parse $(DOCUMENT).blg

todo:
	@echo -e "\e[0;35m\033[1mChecking for TODOs...\e[0;30m\033[0m"
	@todo-finder $(DOCUMENT).tex
	@todo-finder $(DOCUMENT).bib
	@todo-finder README.md
	@todo-finder wgu-cv.cls

clean:
	@texclean
