#!/usr/bin/env sh

latexmk -pdflua WGUnderwood.tex

optpdf WGUnderwood.pdf

pdftoppm \
    -png \
    -hide-annotations \
    -scale-to 800 \
    WGUnderwood.pdf \
    temp

rm -f thumbnail-*.png
pngquant temp-1.png -Q 0-10 -o thumbnail-1.png
pngquant temp-2.png -Q 0-10 -o thumbnail-2.png
rm -f temp-*.png
