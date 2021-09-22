/*
  Image > Grayscale > 6 color Grayscale > Dice
  Zachary Elkins
  www.github.com/ZachElkins/ImageToDice
  
  Command Line Arguments:
  # Must specifiy all args with a value or -1 (Default)
    1) path/file_name (Default: my_picture.png)
    2) path/output_folder (Default: ./out)
    3) Type of change (G: Grayscale, S: Simple Grayscale, D: Dice - Default)
    4) Size (Default 1000x1000)
    5) Invert (-1: Black on White, 1: White on Black, Default: -1)
    
   # Edit cat picture, save to dir ./cat_pics, set it to grayscale, 100x100px image, not inverted
   processing-java --sketch=`pwd` --run ./cat.png ./cat_pics G 100 -1
   # All default settings
   processing-java --sketch=`pwd` --run
   
*/

int dieSize = 20;
String input_file_path = "my_picture.png";
String input_file = "";
String output_dir = "./out";
String type = "D";
int s = 500;
Boolean inverted = false;

void settings() {
  if (args != null && args.length <= 5) {
    input_file_path = parseInt(args[0]) != -1 ? args[0] : input_file_path;
    output_dir =  parseInt(args[1]) != -1 ? args[1] : output_dir;
    
    type = parseInt(args[2]) != -1 ? args[2] : type;
    s = parseInt(args[3]) != -1 ? parseInt(args[3]) : s;
    inverted = parseInt(args[4]) == 1;
  }

  String[] input_file_path_split = input_file_path.split("/");
  input_file = input_file_path_split[input_file_path_split.length-1].split("\\.")[0];
  size(s, s);
}

void setup() {
  print("Converting Image... \n");
  
  loadPixels();
  
  PImage img = loadImage(input_file_path);
 
  img.resize(width, height);
  img.loadPixels();
  
  int[] pixelBrightness = getPixelBrightness(img);
  switch(type) {
    case "G":
      grayscale( pixelBrightness );
      break;
    case "S":
    simpleGrayscale( pixelBrightness );
      break;
    case "D":
      dice( img );
      break;
  }
}

int[] getPixelBrightness( PImage img ) {
  int[] brightness = new int[img.width*img.height];
  for(int i = 0; i < img.pixels.length; i++) {
    float r = red(img.pixels[i]);
    float g = green(img.pixels[i]);
    float b = blue(img.pixels[i]);
    int brightnessValue = int((r+g+b)/3);
    brightness[i] = brightnessValue;
  }
  
  return brightness;
}

void grayscale(int[] brightness) {
  
  print("Converting image to grayscale ...");
  
  for (int i = 0; i < brightness.length; i++) {
    if (inverted) {
      pixels[i] = color(255-brightness[i], 255-brightness[i], 255-brightness[i]);
    } else {
      pixels[i] = color(brightness[i], brightness[i], brightness[i]);
    }
  }
  
  updatePixels();
  
  save(generateFileName("grayscale"));
}

void simpleGrayscale(int[] brightness) {
  print("Converting image to simple grayscale ...");
  
  for (int i = 0; i < brightness.length; i++) {
    float simpleValue = floor((float(brightness[i])/255)*6);
    float value = 0;
    if (inverted) {
      value = map(simpleValue, 1.0, 6.0, 255.0, 0.0);
    } else {
      value = map(simpleValue, 1.0, 6.0, 0.0, 255.0);
    }
    
    pixels[i] = color(value, value, value);
  }
  
  updatePixels();
  
  save(generateFileName("simple_grayscale"));
}

void dice(PImage img) {
  print("Converting image to dice ...");
  
  background(255);
  
  img.resize(width/dieSize, height/dieSize);
  
  int[] brightness = getPixelBrightness(img);
  
  strokeWeight(1);
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++ ) {
      int i = x + (y*img.width);
      float simpleValue = 0.0;
      if (inverted) {
        simpleValue = map(floor((float(brightness[i])/255)*6), 0, 6, 6, 1);
      } else {
        simpleValue = map(floor((float(brightness[i])/255)*6), 0, 6, 1, 6);
      }
      drawDie( int(simpleValue), x*dieSize, y*dieSize, dieSize );
    }
  }
 
  save(generateFileName("dice"));
}

void drawDie(int num, int x, int y, int s) {
  int or = int(dieSize/10);
  int dr = floor(dieSize/4);
  int o = ceil(dieSize/4);
 
  int bg = inverted ? 0 : 255;
  int fg = inverted ? 255: 0;
  stroke(fg);
  fill(bg);
  rect(x, y, s, s, or, or, or, or);
  fill(fg);
  noStroke();
  
  switch(num) {
    case 1:
      ellipse(x+dieSize/2, y+dieSize/2, dr, dr);
      break;
    case 2:
      ellipse(x+o, y+o, dr, dr);
      ellipse(x+s-o, y+s-o, dr, dr);
      break;
    case 3:
      ellipse(x+o, y+o, dr, dr);
      ellipse(x+dieSize/2, y+dieSize/2, dr, dr);
      ellipse(x+s-o, y+s-o, dr, dr);
      break;
    case 4:
      ellipse(x+o, y+o, dr, dr);
      ellipse(x+o, y+s-o, dr, dr);
      ellipse(x+s-o, y+s-o, dr, dr);
      ellipse(x+s-o, y+o, dr, dr);
      break;
    case 5:
      ellipse(x+o, y+o, dr, dr);
      ellipse(x+o, y+s-o, dr, dr);
      ellipse(x+dieSize/2, y+dieSize/2, dr, dr);
      ellipse(x+s-o, y+s-o, dr, dr);
      ellipse(x+s-o, y+o, dr, dr);
      break;
    case 6:
      ellipse(x+o, y+o, dr, dr);
      ellipse(x+o, y+dieSize/2, dr, dr);
      ellipse(x+o, y+s-o, dr, dr);
      ellipse(x+s-o, y+s-o, dr, dr);
      ellipse(x+s-o, y+dieSize/2, dr, dr);
      ellipse(x+s-o, y+o, dr, dr);
      break;
  }
}

String generateFileName(String type) {
  String inv = inverted ? "_inverted" : "";
  return output_dir+"/"+input_file+"_"+type+inv+"_"+s+"x"+s+".png";
}
