#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys, os, getopt, logging, datetime
from shutil import copyfile
from PIL import Image, ImageDraw, ImageFont

logFileName = os.path.normpath("imageCaption") + datetime.datetime.now().strftime("%y%m%d%H%M%S") + ".LOG"
logging.basicConfig(format='%(levelname)s: %(message)s', filename=logFileName,level=logging.INFO)

# ------------- Start block of text/img variables ------------- #
logging.info("-------------- Start block of text/img variables --------------")
#Windows font location (Can't seem to add a font with a space in the name)
fontLoc = os.path.normpath("C:\Windows\Fonts\Arial.ttf")
#or
#fontLoc = "arial.ttf"

#Linux font location (Debian)
#fontLoc = os.path.normpath('usr/share/fonts/truetype/FreeSans.ttf')

#Mac font location
#fontLoc = os.path.normpath('/System/Library/Fonts/HelveticaNeue.dfont')

logging.info("Font Location: " + str(fontLoc))

#Primary Font Size
primaryFontSz = 50
logging.info("PLabel font Size: " + str(primaryFontSz))

#Secondary Font Size
secondFontSz = 120
logging.info("SLabel font Size: " + str(secondFontSz))

#White background with no opacity
BGColor = (255,255,255,0)
logging.info("BGColor: " + str(BGColor))

#Black overlay with half opacity
OverlayFillColor = (0,0,0,128)
logging.info("OverlayFillColor: " + str(OverlayFillColor))

#White text with full opacity
TextColor = (255,255,255,255)
logging.info("TextColor: " + str(TextColor))

PrimaryLabel = "LuLaRoe Lauren Nicolaides"
logging.info("PrimaryLabel: " + str(PrimaryLabel))

logging.info("-------------- Finish block of text/img variables --------------")
logging.info("")
# ------------- Finish block of text/img variables ------------- #

def errPrint():
  """
  Print error that explains usage.
  """
  logging.warning("Help message requested. Printing help message and closing.")
  print '-h, --help'
  print ' prints this help command'
  print '-p, --path'
  print ' required file path to find images'
  print ''

def theMainShow(pathToImages):
  """
  Grab forwarded file path from main function
  Get list of (jpg) files in folder
  Go through every file
    Determine Secondary label
    Modify file to include overlay and labels
    Save file to export directory
  """
  
  fileList = {}
  exportDir = pathToImages + "_export"
  
  for files in os.listdir(pathToImages):
    if os.path.isfile(os.path.join(pathToImages,files)) and ".jpg" in files:
      fileList[files] = os.sep.join([pathToImages, files])

  if fileList.__len__() > 0:
    if(os.path.isdir(exportDir) == False):
      os.makedirs(exportDir)

    for entry in fileList:
      if entry.find("_") != -1:
        modFile = pathToImages + os.path.normpath("/") + entry
        SecondaryLabel = entry[:entry.find("-")-1]
        
        #If location of underscore is not directly to the left of the '.' for the file ending, add secondary label
        if entry.find("_") != (entry.rfind(".") - 1):
          SecondaryLabel = SecondaryLabel + " - " + entry[entry.find("_")+1:entry.rfind(".")]
        
        logging.info("File entry name: " + entry)
        logging.info("Secondary Label: " + SecondaryLabel)
        logging.info("Changing file: " + modFile)

        base = Image.open(modFile).convert('RGBA')
        wid,hei=base.size

        overlayPos = hei - 250

        # make a blank image for the text, initialized to transparent text color
        txt = Image.new('RGBA', base.size, BGColor)

        # Store font information
        pfnt = ImageFont.truetype(fontLoc, primaryFontSz)
        sfnt = ImageFont.truetype(fontLoc, secondFontSz)

        d = ImageDraw.Draw(txt)

        # draw semi-opaque rectangle over bottom section of image
        d.rectangle((0,overlayPos,wid,hei),fill=OverlayFillColor)
        
        # draw text over image
        d.text((50,overlayPos+20), SecondaryLabel, font=sfnt, fill=TextColor)
        d.text((50,overlayPos+150), PrimaryLabel, font=pfnt, fill=TextColor)

        out = Image.alpha_composite(base, txt)
        #out.show()

        logging.info("Placing  file: " + exportDir + os.path.normpath("/") + entry)
        logging.info("")
        out.save(exportDir + os.path.normpath("/") + entry)
      else:
        logging.info("Copying, no underscore: " + pathToImages + os.path.normpath("/") + entry)
        copyfile(pathToImages + os.path.normpath("/") + entry, exportDir + os.path.normpath("/") + entry)
        logging.info("")
    logging.info("Reached last file. Exiting")

def main(argv):
  logging.info("Starting to parse arguments")
  try:
    opts, args = getopt.getopt(argv,"hp:", ["help", "path="])
    if not opts:
      # Return proper usage of script
      logging.warning("No arguments provided.")
      errPrint()
      sys.exit(1)
  except getopt.GetoptError,e:
    # Return proper usage of script if in error
    logging.warning("Error with arguments")
    logging.warning(e)
    errPrint()
    sys.exit(2)
  for opt, arg in opts:
    if opt in ("-h", "--help"):
      # Return proper usage of script
      errPrint()
      sys.exit(3)
    elif opt in ("-p", "--path"):
      if(os.path.isdir(arg) == False):
        # Return proper usage of script if in error
        logging.warning("Argument supplied was not a folder or directory.")
        errPrint()
        print("Not a folder/directory. Please try again")
        sys.exit(4)
      else:
        #Log the file location and head over to the main show
        logging.info("File location: " + os.path.abspath(arg).encode('utf-8'))
        logging.info("")
        theMainShow(os.path.abspath(arg))

if __name__ == '__main__':
  main(sys.argv[1:])