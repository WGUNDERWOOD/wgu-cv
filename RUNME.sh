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
    -bordercolor Gray \
    -border 5x5 \
    -append temp-*.png \
    temp.png

convert \
    temp.png \
    -bordercolor Gray \
    -border 5x5 \
    temp.png

pngquant temp.png -Q 0-10 -f -o thumbnail.png
rm -f temp*.png
