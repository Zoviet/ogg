#!/bin/bash

#Generate Open Graph image (og:image) from text content. 

#Default dimension of the og:image.  

og_width=968; #default width of the og:image in px. Facebook recommended 1200px min.
og_height=504; #default height of the og:image in px. Facebook recommended 630px min.
parser=false; #don't use xslt themplate for html parsing from url 
themplate=$DIRSTACK/parser.xsl; #default xslt themplate
bg=white; #default background color of the og:image

content=${!#};
if [ -n	"$1" ]; then 
	while [ -n "$1" ]
		do
			case "$1" in
				-h) if [ -n "$2" ]; then 
						og_height="$2" 
					fi;;
				-w) if [ -n "$2" ]; then 
						og_width="$2"
					fi;
					shift;;
				-b) if [ -n "$2" ]; then 
						bg="$2"
					fi;
					shift;;
				-p) parser=true;
					if [ -n "$2" ]; then 
					themplate="$2";
					fi;
					shift 
					break;;
			esac
			shift
		done
	if [ -f "$DIRSTACK/$content" ]; then		
		name=`echo "$content" | sed 's/^\(.*\)\..*$/\1/'`;
		test=`echo "$content" | sed 's/^.*\.\(.*\)$/\1/'`;
		text=$(cat $DIRSTACK/$content);
		if [ "$test" = "temp" ]; then		
			echo 'URL convertation done!';
			rm $DIRSTACK/$content;
		fi
		echo "Convert text to og:image";
		left=$(( $og_width/10 ));
		top=$(( $og_height/15 ));
		fontsize=$(( 12+$og_width/72 ));
		linesize=$(( ($og_width -2*$left)*3/$fontsize ));		
		texter=$(echo "$text" | fold -s --width="$linesize"); 
		convert -size "$og_width"x"$og_height" canvas:"$bg" "$name".png;
		convert "$name".png -gravity NorthWest -pointsize "$fontsize" -annotate +"$left"+"$top" "$texter" "$name".png;
		if [[ $? == 0 ]]; then 
			echo 'Success! Your og:image is: '$name'.png';
		else 
			echo 'Error image convert';
		fi
	else
		urlstatus=$(curl -o /dev/null --silent --head --write-out '%{http_code}' "$content" )		
		if [ $urlstatus -eq 200 ]; then	
			echo "Starting URL convertation";
			name=`echo "$content" | sed 's/^.\{6,8\}\/\(.*\)\.\(.*\)$/\1-\2/' | sed 's/[\/\.]/-/g'`;						
			wget --header="Accept: text/html" --user-agent="Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:21.0) Gecko/20100101 Firefox/21.0" -q --force-html -O temp $content;
			if $parser; then
				echo 'Starting XSLT transform';
				pandoc --from html -o temp --to html --verbose --ascii --normalize temp;
				xsltproc -o htmltemp --novalid --html 'parser.xsl' temp;
				cp -v htmltemp temp;
				rm htmltemp;  # use htmltemp for testing xslt transform
				echo 'XSLT transform done!';
			fi					
			pandoc -f html --verbose --ascii --normalize -t plain -o $DIRSTACK/$name.temp temp; 
			rm temp;								
			./ogg -w $og_width -h $og_height $name.temp;
		else 
			echo "Error: No valid URL. Http status is: "$urlstatus;
		fi
	fi
else
	echo "Error: File or URL needed";
fi
