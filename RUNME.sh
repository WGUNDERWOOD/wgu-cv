#!/usr/bin/env sh

latexmk -pdflua WGUnderwood.tex

optpdf WGUnderwood.pdf

pdftoppm \
    -png \
    -hide-annotations \
    -singlefile \
    -scale-to 800 \
    WGUnderwood.pdf \
    temp

rm -f thumbnail.png
pngquant temp.png -Q 0-10 -o thumbnail.png
rm -f temp.png
