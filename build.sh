#!/bin/sh


rm -rf build/$1.*

if [ ! -d build ]; then
    mkdir build
fi;

PANDOC_OPTS="-s --toc --toc-depth=2 "

pandoc $PANDOC_OPTS -f markdown -t asciidoc \
	--ascii -o build/$1.txt $2

pandoc $PANDOC_OPTS -f markdown -t org \
	--ascii -o build/$1.org $2

PANDOC_OPTS="-S -s --toc --email-obfuscation=references --toc-depth=2 "

pandoc $PANDOC_OPTS -f markdown -t docx -o build/$1.docx $2


pandoc $PANDOC_OPTS -f markdown --ascii          \
    --template=templates/template.html           \
    --self-contained -V css=templates/custom.css \
    -V css=templates/style.css                   \
    -t html5 -o build/$1.html $2


PANDOC_OPTS="-S -s --toc --toc-depth=3 "

pandoc $PANDOC_OPTS -f markdown                  \
	--template=templates/template.latex      \
	-t latex -o build/$1.pdf $2

pandoc $PANDOC_OPTS -f markdown                  \
	--template=templates/template.latex      \
	--ascii -t latex -o build/$1.tex $2

xdg-open build/$1.html

