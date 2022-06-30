all: latex compress thumbnail

latex:
	@echo "Building with lualatex..."
	@latexmk -pdflua -quiet WGUnderwood.tex

compress:
	@echo "Compressing pdf..."
	@optpdf WGUnderwood.pdf
	@optpdf WGUnderwood.pdf

thumbnail:
	@echo "Building thumbnail..."
	@pdftoppm -png -hide-annotations -scale-to 800 WGUnderwood.pdf temp
	@convert -bordercolor gray20 -border 3x3 -append temp-*.png temp.png
	@convert temp.png -bordercolor gray20 -border 3x3 temp.png
	@pngquant temp.png -Q 0-10 -f -o thumbnail.png
	@rm -f temp*.png
