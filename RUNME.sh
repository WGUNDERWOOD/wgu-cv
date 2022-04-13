#!/usr/bin/env sh

latexmk -pdflua WGUnderwood.tex

optpdf WGUnderwood.pdf

pdftoppm \
    -png \
    -hide-annotations \
    -scale-to 800 \
    WGUnderwood.pdf \
    temp

convert \
    -bordercolor Black \
    -border 10x10 \
    -append temp-*.png \
    temp.png

pngquant temp.png -Q 0-10 -f -o thumbnail.png
rm -f temp*.png
