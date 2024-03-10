doc := "WGUnderwood"

all: format todo warn spell longlines build thumbnail compress

alias c := clean
alias f := format
alias t := todo
alias w := warn
alias s := spell
alias l := longlines
alias b := build

format:
    @echo -e "\e[0;35m\033[1mFormatting...\e[0;30m\033[0m"
    @tex-fmt {{doc}}.tex # TODO {{doc}}.bib wgu-cv.cls

build:
    @echo -e "\e[0;35m\033[1mBuilding...\e[0;30m\033[0m"
    @latexmk -rc-report- -pdflua -quiet {{doc}}.tex | \
        grep -v 'Latexmk: Nothing to do for' | grep '^.' || true

compress:
    @echo -e "\e[0;35m\033[1mCompressing...\e[0;30m\033[0m"
    @compress-pdf {{doc}}.pdf

thumbnail:
    @echo -e "\e[0;35m\033[1mThumbnail...\e[0;30m\033[0m"
    @pdftoppm -png -hide-annotations -scale-to 800 {{doc}}.pdf temp
    @convert -bordercolor gray20 -border 3x3 -append temp-*.png temp.png
    @convert temp.png -bordercolor gray20 -border 3x3 temp.png
    @pngquant temp.png -Q 0-10 -f -o thumbnail.png
    @rm -f temp*.png

warn:
    @echo -e "\e[0;35m\033[1mWarnings...\e[0;30m\033[0m"
    @tex-check {{doc}}.log

longlines:
    @echo -e "\e[0;35m\033[1mLong lines...\e[0;30m\033[0m"
    @long-lines {{doc}}.tex {{doc}}.bib justfile

spell:
    @echo -e "\e[0;35m\033[1mSpelling...\e[0;30m\033[0m"
    @spell-check {{doc}}.tex {{doc}}.bib

todo:
    @echo -e "\e[0;35m\033[1mTodos...\e[0;30m\033[0m"
    @todo-finder {{doc}}.tex {{doc}}.bib README.md wgu-cv.cls justfile

clean:
    @tex-clean
    @rm -f *.html
    @rm -f *.bak[0-9]*
