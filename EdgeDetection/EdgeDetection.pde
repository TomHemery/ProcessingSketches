Kernel basicGaussian = new BasicGaussian();
SobelEdgeDetect edgeDetector  = new SobelEdgeDetect();
CannyOperator cannyOperator = new CannyOperator();
PImage img;
int[][] greyscaleImg;
int step = 0;

void settings(){
  img = loadImage("edge1.jpg");
  size(img.width, img.height);
}

void setup(){
  background(0);
  
  greyscaleImg = null;

}

void draw(){
  if(greyscaleImg != null)imageToPImage(img, greyscaleImg);
  image(img, 0, 0);
}

void keyPressed(){
  switch(step){
    case 0:
      greyscaleImg = imageToGrayScale(img);
      step++;
      break;
    case 1:
      for(int i = 0; i < 3; i++)greyscaleImg = basicGaussian.applyToImage(greyscaleImg);
      step++;
      break;
    case 2:
      greyscaleImg = edgeDetector.applyToImage(greyscaleImg);
      step++;
      break;
    case 3:
      greyscaleImg = cannyOperator.applyToImage(greyscaleImg, edgeDetector.angles);
      break;
  }
}

int[][] imageToGrayScale(PImage img){
  int[][] result = new int[img.width][img.height];
  int val;
  img.loadPixels();
  for(int x = 0; x < result.length; x++){
    for(int y = 0; y < result[0].length; y++){
      val = img.pixels[x + y * img.width];
      val = floor((red(val) + green(val) + blue(val)) / 3);
      result[x][y] = val;
    }
  }
  return result;
}

void imageToPImage(PImage target, int[][] image){
  target.loadPixels();
  for(int x = 0; x < image.length; x++){
    for(int y = 0; y < image[0].length; y++){
      target.pixels[x + y * target.width] = color(image[x][y]);
    }
  }
  target.updatePixels();
}