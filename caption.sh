#!/bin/sh
if [ -z "$1" ]
  then
    echo "No source supplied"
    exit 1
fi

if [ -z "$2" ]
  then
    echo "No destination supplied"
    exit 1
fi
DEST="$2"
COLOR="rgba(0,0,0,0.5)"
FONT="/System/Library/Fonts/HelveticaNeue.dfont"
STYLENAME="$(basename "$1")"

[ -d "$DEST" ] || mkdir "$DEST"

find "$1" -iname "*jpg" -name "*_*" | \
	while read FILE; do
		BASEFILENAME=$(basename "$FILE")
		echo $FILE 
		echo "$DEST"/$BASEFILENAME
		CLOTHINGSIZE=$(echo $BASEFILENAME | awk -F'[_.]' '{print $(NF-1)}');
		echo $CLOTHINGSIZE;
		SECONDLABEL=$STYLENAME;
		[[ !  -z  $CLOTHINGSIZE  ]] && SECONDLABEL+=" - $CLOTHINGSIZE"
		echo $SECONDLABEL
		width=`identify -format %w "$FILE"`; \
		convert "$FILE" \
		-fill $COLOR -font $FONT  -pointsize 50 \
		-gravity northwest -annotate +50+30 'LuLaRoe Lauren Nicolaides' \
		-fill $COLOR -font $FONT  -pointsize 80 \
		-gravity northwest -annotate +50+90 "$SECONDLABEL" \
		"$DEST"/"$BASEFILENAME"
  done