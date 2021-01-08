# Open Graph image generator 

## Description

Generate Open Graph image (og:image) from text content. 
Image (og:image) is saving in working directory, named like source file or url's domain.

## Install

Clone or download and

```shell
chmod +x ogg
```

## Needed:

- imagemagick 
```shell
sudo apt install imagemagick
```

- pandoc (if you wish to generate og:image from url)
```shell
sudo apt install pandoc
```
- xsltproc (if you wish to use -p option (parse main content from source URL)
```shell
sudo apt install xsltproc)
```

## Usage:

```shell
ogg [options] [input-file or input-url]

```

Options are:

- -w [number] - og:image width (968px by default);
- -h [number] - og:image height (504px by default);
- -b [string] - background color of the og:image ('white' by default);
- -p [filename]- use xslt themplate (parser.xsl in working dir if filename not set) for parsing main content part from url;




