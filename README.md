#Open Graph image generator 

##Description

Generate Open Graph image (og:image) from text content. 
Image (og:image) is saving in working directory, named like source file or url's domain.

##Install

chmod +x ogg

##Needed:

- pandoc 
```shell
sudo apt install pandoc
```
- pdflatex 
```shell
sudo apt install texlive-latex-base
```
- Tex Live fonts and Text Live xetex
```shell
sudo apt texlive-fonts-recommended
sudo apt texlive-xetex
```
- imagemagick 
```shell
sudo apt install imagemagick
```
- xsltproc (if you wish to use -p option (parse main content from source URL)
```shell
sudo apt install xsltproc)
```
If you got an error like "! LaTeX Error: File `lmodern.sty' not found." just try this:
```shell
sudo apt-get install lmodern -y
```

##Usage:

```shell
ogg [options] [input-file or input-url]

```

Options are:

-w [number] - og:image width (968px by default);
-h [number] - og:image height (504px by default);
-b [string] - background color of the og:image ('white' by default);
-p [filename]- use xslt themplate (parser.xsl in working dir if filename not set) for parsing main content part from url;




