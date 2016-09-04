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

[ -d "$DEST" ] || mkdir "$DEST"


 find "$1" -iname "*jpg" | \
  while read FILE; do
  	BASEFILENAME=$(basename "$FILE")
  	echo $FILE;
  	echo "$DEST"/$BASEFILENAME
   #cp -v --parent "$I" /backup/dir/
   width=`identify -format %w "$FILE"`; \
convert "$FILE" \
-fill "rgba(0,0,0,0.35)" -stroke "rgba(0,0,0,0.35)" -font "/System/Library/Fonts/HelveticaNeue.dfont"  -pointsize 50 \
-gravity northwest -annotate +50+25 'LuLaRoe Lauren Nicolaides' \
-fill "rgba(0,0,0,0.35)" -stroke "rgba(0,0,0,0.35)" -font "/System/Library/Fonts/HelveticaNeue.dfont"  -pointsize 80 \
-gravity northwest -annotate +50+90 'Second Line' \
 "$DEST"/"$BASEFILENAME"
  done

# do
# -size 1580x1080 \
# xc:black \
# \( "$I" -resize 1580x1080 \) \
# -gravity center \
# -composite \
# -size 40x \
# xc:black \
# -background black \
# -font /Library/Fonts/Georgia.ttf \
# -fill '#cccccc' \
# -pointsize 32 \
# -gravity west \
# -size 300x \
# label: "bar" \
# $DEST/` "$I"`
# append \
# echo $file
# done