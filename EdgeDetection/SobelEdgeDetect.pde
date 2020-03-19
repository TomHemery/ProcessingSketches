class SobelEdgeDetect extends Kernel{
  
  SobelX sobelX = new SobelX();
  SobelY sobelY = new SobelY();
  
  float[][] angles;
  
  SobelEdgeDetect(){
    super(0);
  }
  
  int[][] applyToImage(int[][] image){
    int[][] sobelXResult = sobelX.applyToImage(image);
    int[][] sobelYResult = sobelY.applyToImage(image);
    int[][] result = new int[image.length][image[0].length];
    angles = new float[image.length][image[0].length];
    for(int x = 0; x < result.length; x++){
      for(int y = 0; y < result[0].length; y++){
        result[x][y] = floor(sqrt(sobelXResult[x][y] * sobelXResult[x][y] + sobelYResult[x][y] * sobelYResult[x][y]));
        angles[x][y] = sobelXResult[x][y] > 0 ? atan(sobelYResult[x][y] / sobelXResult[x][y]) : 0;
      }
    }
    return result;
  }
}

class SobelX extends Kernel{

  SobelX(){
    super(3);
    contents = new float[][] {
      {-1, 0, 1},
      {-2, 0, 2},
      {-1, 0, 1}
    };
  }
  
}

class SobelY extends Kernel{

  SobelY(){
    super(3);
    contents = new float[][] {
      {-1, -2, -1},
      {0, 0, 0},
      {1, 2, 1}
    };
  }
  
}