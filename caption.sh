#!/bin/sh
if [ -z "$1" ]
  then
    echo "No source supplied"
    exit 1
fi

COLOR="rgba(0,0,0,0.5)"
FONT="/System/Library/Fonts/HelveticaNeue.dfont"


find "$1" -iname "*jpg" -name "*_*" | \
	while read FILE; do
		BASEFILENAME=$(basename "$FILE")
		STYLENAME=$(echo $BASEFILENAME | awk -F'[-]' '{print $(1)}' | xargs);

		DEST=$(dirname "$FILE")"_export"
		[ -d "$DEST" ] || mkdir "$DEST"


		echo $FILE 
		echo "$DEST"/$BASEFILENAME

		CLOTHINGSIZE=$(echo $BASEFILENAME | awk -F'[_.]' '{print $(NF-1)}');
		SECONDLABEL=$STYLENAME;
		[[ !  -z  $CLOTHINGSIZE  ]] && SECONDLABEL+=" - $CLOTHINGSIZE"

		
		width=`identify -format %w "$FILE"`; \
		convert "$FILE" \
		-fill $COLOR -font $FONT  -pointsize 50 \
		-gravity northwest -annotate +50+30 'LuLaRoe Lauren Nicolaides' \
		-fill $COLOR -font $FONT  -pointsize 80 \
		-gravity northwest -annotate +50+90 "$SECONDLABEL" \
		"$DEST"/"$BASEFILENAME"
  done