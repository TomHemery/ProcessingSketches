class CannyOperator extends Kernel{

  int checkWidth = 4;
  int topThreshold = 12;
  int lowThreshold = 3;
  
  CannyOperator(){
    super(0);
  }
  
  int[][] applyToImage(int[][] image, float[][] angles){
    int max = 0;
    int[][] result = new int[image.length][image[0].length];
    for(int x = 0; x < image.length; x++){
      for(int y = 0; y < image[x].length; y++){
        if(angles[x][y] >= 1.25 * PI && angles[x][y] <= 1.75 * PI ||
           angles[x][y] >= 0.25 * PI && angles[x][y] <= 0.75 * PI){ //vertically dominated
           for(int z = -checkWidth; z <= checkWidth; z++){
             if(x + z > 0 && x + z < image.length){
               max = max > image[x + z][y] ? max : image[x + z][y];
             }
           }
        } else { //horizontally dominated
          for(int z = -checkWidth; z <= checkWidth; z++){
             if(y + z > 0 && y + z < image[0].length){
               max = max > image[x][y + z] ? max : image[x][y + z];
             }
           }
        }
        result[x][y] = image[x][y] == max ? max : 0;
        max = 0;
      }
    }
    //result now has maxima considered;
    return hysteresisThresholding(result);
  }
  
  int[][] hysteresisThresholding(int[][] image){
    boolean change = true;
    while(change){
      change = false;
      for(int x = 0; x < image.length; x ++){
        for(int y = 0; y < image[x].length; y++){
          if(image[x][y] > topThreshold){
            image[x][y] = 255;
            for(int x2 = -1; x2 <= 1; x2++){
              for(int y2 = -2; y2 <= 1; y2++){
                if(x + x2 < image.length && x + x2 >= 0 && y + y2 < image[0].length && y + y2 >= 0){
                  if(x2 != 0 && y2 != 0 && image[x + x2][y + y2] > lowThreshold && image[x + x2][y + y2] < 255){
                    change = true;
                    image[x + x2][y + y2] = 255;
                  }
                }
              }
            }
          }
        }
      }
      
      if(change){
        for(int x = image.length-1; x >= 0; x --){
          for(int y = image[x].length-1; y >= 0; y--){
            if(image[x][y] > topThreshold){
              image[x][y] = 255;
              for(int x2 = -1; x2 <= 1; x2++){
                for(int y2 = -2; y2 <= 1; y2++){
                  if(x + x2 < image.length && x + x2 >= 0 && y + y2 < image[0].length && y + y2 >= 0){
                    if(x2 != 0 && y2 != 0 && image[x + x2][y + y2] > lowThreshold && image[x + x2][y + y2] < 255){
                      change = true;
                      image[x + x2][y + y2] = 255;
                    }
                  }
                }
              }
            }
          }
        }
      }
    }
    
    for(int x = 0; x < image.length; x++){
      for(int y = 0; y < image[0].length; y++){
        image[x][y] = image[x][y] == 255 ? 255 : 0;
      }
    }
    
    return image;
  }

}