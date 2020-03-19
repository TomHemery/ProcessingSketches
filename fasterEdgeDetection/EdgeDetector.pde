class EdgeDetector extends KernelOperator{
  
  SobelX sobelX = new SobelX();
  SobelY sobelY = new SobelY();
  
  EdgeDetector(){
    super(0);
  }
  
  PImage applyToImage(PImage img){
    img = cleanBorders(img);
    PImage sobelResult = new PImage(img.width, img.height);
    float gX;
    float gY;
    float [][] angles = new float[img.width][img.height];
    int val;
    img.loadPixels();
    for(int x = 1; x < img.width - 1; x++){
      for(int y = 1; y < img.height - 1; y++){
        gX = sobelX.calculatePoint(img, x, y);
        gY = sobelY.calculatePoint(img, x, y);
        val = int(sqrt(gX * gX + gY * gY));
        sobelResult.pixels[x + y * img.width] = color(val, val, val);
        angles[x][y] = gX > 0 ? atan(gY / gX) : 0;
      }
    }  
    sobelResult.updatePixels();
    return cannyOperator(cleanBorders(sobelResult), angles);
  }
  
  PImage cannyOperator(PImage img, float[][] angles){
    PImage cannyResult = new PImage(img.width, img.height);
    int max = 0;
    int checkWidth = 5;
    int val;
    for(int x = 1; x < img.width-1; x++){
      for(int y = 1; y < img.height-1; y++){
        if(angles[x][y] >= 1.25 * PI && angles[x][y] <= 1.75 * PI ||
           angles[x][y] >= 0.25 * PI && angles[x][y] <= 0.75 * PI){ //vertically dominated
           for(int z = -checkWidth; z <= checkWidth; z++){
             if(x + z > 0 && x + z < img.width - 1){
               val = extractVal(img, x + z, y);
               max = max > val ? max : val;
             }
           }
        } else { //horizontally dominated
          for(int z = -checkWidth; z <= checkWidth; z++){
             if(y + z > 0 && y + z < img.height - 1){
               val = extractVal(img, x, y + z);
               max = max > val ? max : val;
             }
           }
        }
        cannyResult.pixels[x + y * img.width] = color(extractVal(img, x, y) == max ? max : 0);
        max = 0;
      }
    }
    return hysteresisThresholding(cleanBorders(cannyResult));
  }
  
  PImage hysteresisThresholding(PImage image){
    int topThreshold = 35;
    int lowThreshold = 8;
    boolean change = true;
    image.loadPixels();
    while(change){
      change = false;
      for(int x = 1; x < image.width-1; x ++){
        for(int y = 1; y < image.height-1; y++){
          if(extractVal(image, x, y) > topThreshold){
            image.pixels[x + y * image.width] = #FFFFFF;
            for(int x2 = -1; x2 <= 1; x2++){
              for(int y2 = -1; y2 <= 1; y2++){
                if(x2 != 0 && y2 != 0 && extractVal(image, x + x2, y + y2) > lowThreshold && extractVal(image, x + x2, y + y2) < 255){
                  change = true;
                  image.pixels[x + x2 + (y + y2) * image.width] = #FFFFFF;
                }
              }
            }
          }
        }
      }
      
      if(change){
        for(int x = image.width - 2; x > 0; x --){
          for(int y = image.height - 2; y > 0; y--){
            if(extractVal(image, x, y) > topThreshold){
              image.pixels[x + y * image.width] = #FFFFFF;
              for(int x2 = -1; x2 <= 1; x2++){
                for(int y2 = -1; y2 <= 1; y2++){
                  if(x2 != 0 && y2 != 0 && extractVal(image, x + x2, y + y2) > lowThreshold && extractVal(image, x + x2, y + y2) < 255){
                    change = true;
                    image.pixels[x + x2 + (y + y2) * image.width] = #FFFFFF;
                  }
                }
              }
            }
          }
        }
      }
    }
    
    for(int x = 0; x < image.width; x++){
      for(int y = 0; y < image.height; y++){
        image.pixels[x + y * image.width] = extractVal(image, x, y) == 255 ? #FFFFFF : #000000;
      }
    }
    image.updatePixels();
    return cleanBorders(image);
  }
  
  PImage cleanBorders(PImage img){
    img.loadPixels();
    for(int x = 0; x < img.width; x++){
      img.pixels[x] = #000000;
      img.pixels[x + (img.height - 1) * img.width] = #000000;
    }
    
    for(int y = 0; y < img.height; y++){
      img.pixels[y * img.width] = #000000;
      img.pixels[img.width - 1 + y * img.width] = #000000;
    }
    return img;
  }
  
  private class SobelX extends KernelOperator{
    SobelX(){
      super(3);
      kernelMatrix = new float[][]{
        {-1, 0, 1},
        {-2, 0, 2},
        {-1, 0, 1}
      };
      normalization = 2;
    }
  }

  private class SobelY extends KernelOperator{
    SobelY(){
      super(3);
      kernelMatrix = new float[][]{
        {1, 2, 1},
        {0, 0, 0},
        {-1, -2, -1}
      };
      normalization = 2;
    }
  }
}
