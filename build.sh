#!/bin/sh

inputfile=$1

if [ ! -f "$inputfile" ]; then
	echo "$inputfile not found"
	exit 1;
fi

fbname=$(basename "$inputfile" | cut -d. -f1)
rm -rf "build/$fbname.*"

if [ ! -d build ]; then
    mkdir build
fi;

PANDOC_OPTS="-s --toc --toc-depth=2 "

echo TXT
pandoc $PANDOC_OPTS -f markdown -t asciidoc \
	--ascii -o "build/$fbname.txt" "$inputfile"

echo ORG
pandoc $PANDOC_OPTS -f markdown -t org \
	--ascii -o "build/$fbname.org" "$inputfile"

PANDOC_OPTS="-S -s --toc --email-obfuscation=references --toc-depth=2 "

echo DOCX
pandoc $PANDOC_OPTS -f markdown -t docx \
	-o "build/$fbname.docx" "$inputfile"


echo HTML
pandoc $PANDOC_OPTS -f markdown --ascii          \
    --template=templates/template.html           \
    --self-contained -V css=templates/custom.css \
    -V css=templates/style.css                   \
    -t html5 -o "build/$fbname.html" "$inputfile"


PANDOC_OPTS="-S -s --toc --toc-depth=3 "

echo PDF
pandoc $PANDOC_OPTS -f markdown                  \
	--template=templates/template.latex      \
	-t latex -o "build/$fbname.pdf" "$inputfile"

echo LATEX
pandoc $PANDOC_OPTS -f markdown                  \
	--template=templates/template.latex      \
	--ascii -t latex -o "build/$fbname.tex" "$inputfile"

echo OPEN
xdg-open "build/$fbname.html"

