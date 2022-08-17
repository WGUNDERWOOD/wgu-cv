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
	@tex_log_parse $(DOCUMENT).log
	@tex_log_parse $(DOCUMENT).blg

todo:
	@echo -e "\e[0;35m\033[1mChecking for todos...\e[0;30m\033[0m"
	@todo_finder $(DOCUMENT).tex
	@todo_finder $(DOCUMENT).bib
	@todo_finder README.md
	@todo_finder wgu-cv.cls

clean:
	@texclean
