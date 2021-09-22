# Image To Dice
_Convert any image to dice, grayscale, or a simplified grayscale_


### Command Line Arguments:
#### _Must specifiy all args with a value or -1 (Default)_
#### _Otherwise all default settings will be used_
```Bash
    1) path/file_name (Default: my_picture.png)
    2) path/output_folder (Default: ./out)
    3) Type of change (G: Grayscale, S: Simple Grayscale, D: Dice - Default)
    4) Size (Default 1000x1000)
    5) Invert (-1: Black on White, 1: White on Black, Default: -1)
```

### Example Use Cases
```Bash
# Edit cat picture, save to dir ./cat_pics, set it to grayscale, 100x100px image, not inverted
processing-java --sketch=`pwd` --run ./cat.png ./cat_pics G 100 -1
```
```Bash
# All default settings
processing-java --sketch=`pwd` --run
```