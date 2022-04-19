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
    -bordercolor gray20 \
    -border 3x3 \
    -append temp-*.png \
    temp.png

convert \
    temp.png \
    -bordercolor gray20 \
    -border 3x3 \
    temp.png

pngquant temp.png -Q 0-10 -f -o thumbnail.png
rm -f temp*.png
