#!/bin/sh

# Specify directory where images to be watermarked are
if [ -z "$1" ]
  then
    echo "No source directory supplied"
    exit 1
fi

# text color
COLOR="rgba(255,255,255,1)"
# overlay background color
BACKGROUNDCOLOR="rgba(0,0,0,0.6)"
# text font family
FONT="/System/Library/Fonts/HelveticaNeue.dfont"
# primary label
PRIMARYLABEL="LuLaRoe Lauren Nicolaides"

# watermark only JPGs with an underscore in the name
find "$1" -iname "*jpg" -name "*_*" | \
	while read FILE; do

		# read the file name of each JPG. The portion before the hyphen is the name of the clothing style
		BASEFILENAME=$(basename "$FILE")
		STYLENAME=$(echo $BASEFILENAME | awk -F'[-]' '{print $(1)}' | xargs);

		# the destination directory for the watermarked images is the name of the source directory with _export appended
		DEST=$(dirname "$FILE")"_export"
		[ -d "$DEST" ] || mkdir "$DEST"

		echo $FILE 
		echo "$DEST"/$BASEFILENAME

		CLOTHINGSIZE=$(echo $BASEFILENAME | awk -F'[_.]' '{print $(NF-1)}');
		SECONDARYLABEL=$STYLENAME;

		# if there are characters after the underscore in the filename, add it to the secondary label
		[[ !  -z  $CLOTHINGSIZE  ]] && SECONDARYLABEL+=" - $CLOTHINGSIZE"

		width=`identify -format %w "$FILE"`; \
		height=`identify -format %h "$FILE"`; \
		overlayPosition="$((height - 250))";

		# use Imagemagick to draw a semi-transparent overlay with the primary and secondary labels
		convert "$FILE" \
		-fill $BACKGROUNDCOLOR -draw 'rectangle 0,'$overlayPosition','$width','$height \
		-fill $COLOR -font $FONT  -pointsize 50 \
		-gravity southwest -annotate +50+40 "$PRIMARYLABEL" \
		-fill $COLOR -font $FONT  -pointsize 120 \
		-gravity southwest -annotate +50+100 "$SECONDARYLABEL" \
		"$DEST"/"$BASEFILENAME"
  done

# for JPGs without underscores, copy them over to the destination directory without modifying
find "$1" -iname "*jpg" -not -name "*_*" | \
	while read FILE; do
		echo $FILE;
		BASEFILENAME=$(basename "$FILE")
		DEST=$(dirname "$FILE")"_export"
		[ -d "$DEST" ] || mkdir "$DEST"
		cp -rv "$FILE" "$DEST"/"$BASEFILENAME"
	done