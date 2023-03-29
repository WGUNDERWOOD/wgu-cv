DOC = "WGUnderwood"

all: indent latex todo compress thumbnail warn spell

.PHONY: indent latex compress thumbnail warn clean spell

format:
	@echo -e "\e[0;35m\033[1mFormatting...\e[0;30m\033[0m"
	@latexindent --overwrite --silent --modifylinebreaks $(DOC).tex
	@latexindent --overwrite --silent --modifylinebreaks $(DOC).bib
	@latexindent --overwrite --silent --modifylinebreaks wgu-cv.cls

latex:
	@echo -e "\e[0;35m\033[1mBuilding with lualatex...\e[0;30m\033[0m"
	@latexmk -rc-report- -pdflua -quiet $(DOC).tex | \
		grep -v "Latexmk: Nothing to do for" || true

compress:
	@echo -e "\e[0;35m\033[1mCompressing PDF...\e[0;30m\033[0m"
	@optpdf $(DOC).pdf | grep -v "didn't make smaller" || true
	@optpdf $(DOC).pdf | grep -v "didn't make smaller" || true

thumbnail:
	@echo -e "\e[0;35m\033[1mBuilding thumbnail...\e[0;30m\033[0m"
	@pdftoppm -png -hide-annotations -scale-to 800 $(DOC).pdf temp
	@convert -bordercolor gray20 -border 3x3 -append temp-*.png temp.png
	@convert temp.png -bordercolor gray20 -border 3x3 temp.png
	@pngquant temp.png -Q 0-10 -f -o thumbnail.png
	@rm -f temp*.png

warn: latex
	@echo -e "\e[0;35m\033[1mChecking for warnings...\e[0;30m\033[0m"
	@tex_log_parse $(DOC).log
	@tex_log_parse $(DOC).blg

spell:
	@echo -e "\e[0;35m\033[1mChecking spelling...\e[0;30m\033[0m"
	@spell_check $(DOC).tex
	@spell_check $(DOC).bib

todo:
	@echo -e "\e[0;35m\033[1mChecking for todos...\e[0;30m\033[0m"
	@todo_finder $(DOC).tex
	@todo_finder $(DOC).bib
	@todo_finder README.md
	@todo_finder wgu-cv.cls

clean:
	@texclean
	@rm -f *.html
	@rm -f *.bak[0-9]*
