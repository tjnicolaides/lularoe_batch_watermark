<img src="images/logo.jpg" height="100" alt="LuLaRoe Logo">
# LuLaRoe Image Watermarking Script
A shell script for OS X or Linux users to easily apply watermarks to LuLaRoe promotional images in large batches. Apply nice-looking labels for your many LuLaRoe promotional images in just minutes. 

If this little script saves you lots of time, please consider swinging by [Lauren's LuLaRoe Facebook group](https://www.facebook.com/groups/LuLaRoeLaurenNicolaides/) and saying hi!

## Usage
Run the script from your terminal (on Mac or Linux), like this:

``` python
./caption.py -p ~/path/to/your/image/directory
```

or

``` python
./caption.py --path=~/path/to/your/image/directory
```

Run the script from the Command Prompt (on Windows), like this:

``` python
/path/to/caption.py -p /path/to/your/image/directory
```

or

``` python
/path/to/caption.py --path=/path/to/your/image/directory
```

<img src="images/Amelia - 27_3XL.jpg" height="500" alt="Exported Amelia JPG image">

The script expects specifically formatted filenames, and at this time processes images with the `.jpg` file extension only. Consider the following directories and filenames (which we got by exporting albums from iPhoto): 

* /path/to/your/image/directory/Cassie/
    * Cassie - 01.jpg
    * Cassie - 02.jpg
    * Cassie - 03_.jpg
    * Cassie - 04_XS.jpg
* /path/to/your/image/directory/Irma/
    * Irma - 01.jpg
    * Irma - 02.jpg
    * Irma - 03_.jpg
    * Irma - 04_M.jpg

<img src="images/directory_src.png" height="500" alt="Directory screenshot - source files">

After the script runs, it will create directories with `_export` appended to the names. Source images with `_` underscores in the filenames will have watermarks applied. Source images without underscores will be copied over to the new destination directory without being modified.

<img src="images/directory_export.png" height="500" alt="Directory screenshot - exported files">

## Install
This script requires [Pillow](https://pillow.readthedocs.io/en/latest/installation.html) to convert images.

Pip was used to install this module "pip install Pillow" or "pip install --upgrade Pillow" to upgrade. Note: You may need administrative rights (sudo) to install or upgrade.
Having 'Pillow' installed alongside the default Python Image Library (PIL) is not suggested or supported. PIL has also not been updated recently as far as I am aware.
'Pillow' is a fork of 'PIL' that has been brought forward.

At this time, the script has only been tested on Windows and Linux (Debian). Your mileage may vary. [Contributions are welcome](contributing.md) if you modify the script to work in other environments.

## Customize
### Primary Label
First, you will want to change the primary label, which currently reads "[LuLaRoe Lauren Nicolaides](https://www.facebook.com/groups/LuLaRoeLaurenNicolaides/)." Search for the line in `caption.py` called `PrimaryLabel = "LuLaRoe Lauren Nicolaides"` and enter your own.

### Color and Background Color
Change the text color and the semi-transparent background overlay color by changing these `rgba` values in `caption.py`:
```python
# text color
TextColor = (255,255,255,255)
# overlay background color
OverlayFillColor = (0,0,0,128)
```

### Font 
Change the font by updating the following line in `caption.sh` to point at a font file installed on your computer, like:
```python
fontLoc = os.path.normpath('C:\Windows\Fonts\Arial.ttf')  #Windows font location
#fontLoc = 'usr/share/fonts/truetype/FreeSans.ttf'        #Linux font location (Debian)
#fontLoc = '/System/Library/Fonts/HelveticaNeue.dfont'    #Mac font location
```

### Secondary Label
The filename of your JPG images matters here. Given a filename like `Tall and Curvy - 14_.jpg`, the script will take the characters before the hyphen `-` and use them as the secondary label:
<img src="images/Tall and Curvy - 14_.jpg" height="500" alt="Exported Tall and Curvy JPG image">

If you want to designate the size of the clothing in the secondary label, you can add characters after the underscore `_` in the filename (example: `Cassie - 04_XS.jpg` and they will be appended in the image like so:
<img src="images/Cassie - 04_XS.jpg" height="500" alt="Exported Cassie JPG image">

## Bugs, feature requests, and support
Please raise bugs, ask for help, and make feature requests in the 'Issues' tab of our Github repository [here](https://github.com/tjnicolaides/lularoe_batch_watermark/issues). 

## Resources
* [Pillow](https://pillow.readthedocs.io/en/latest/installation.html)

## License
This project, while authored for LuLaRoe consultants, is not affiliated with LuLaRoe in any way.
MIT © [TJ Nicolaides](https://tjnicolaides.com)