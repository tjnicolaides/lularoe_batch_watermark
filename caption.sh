#!/bin/sh
if [ -z "$1" ]
  then
    echo "No source supplied"
    exit 1
fi

COLOR="rgba(255,255,255,1)"
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
		height=`identify -format %h "$FILE"`; \
		overlayPosition="$((height - 250))";

		convert "$FILE" \
		-fill '#0006' -draw 'rectangle 0,'$overlayPosition','$width','$height \
		-fill $COLOR -font $FONT  -pointsize 50 \
		-gravity southwest -annotate +50+40 'LuLaRoe Lauren Nicolaides' \
		-fill $COLOR -font $FONT  -pointsize 120 \
		-gravity southwest -annotate +50+100 "$SECONDLABEL" \
		"$DEST"/"$BASEFILENAME"
  done
find "$1" -iname "*jpg" -not -name "*_*" | \
	while read FILE; do
		echo $FILE;
		BASEFILENAME=$(basename "$FILE")
		DEST=$(dirname "$FILE")"_export"
		[ -d "$DEST" ] || mkdir "$DEST"
		cp -rv "$FILE" "$DEST"/"$BASEFILENAME"
	done