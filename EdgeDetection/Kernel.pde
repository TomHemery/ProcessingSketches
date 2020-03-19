class Kernel{

  float[][] contents;
  
  Kernel(int w){
    contents = new float[w][w];
  }
  
  int[][] applyToImage(int[][] image){
    int[][] newImage = new int[image.length][image[0].length];
    int halfKernelWidth = contents.length / 2;
    for(int x = 0; x < image.length; x++){
      for(int y = 0; y < image[x].length; y++){
        float val = 0;
        int count = 0;
        for(int kernelX = 0; kernelX < contents.length; kernelX++){
          for(int kernelY = 0; kernelY < contents[kernelX].length; kernelY++){
            if(x + kernelX - halfKernelWidth >= 0 && x + kernelX - halfKernelWidth < image.length &&
               y + kernelY - halfKernelWidth >= 0 && y + kernelY - halfKernelWidth < image[0].length){
               val += contents[kernelX][kernelY] * 
                 image[x + kernelX - halfKernelWidth][y + kernelY - halfKernelWidth];
               count += abs(contents[kernelX][kernelY]);
            }
          }
        }
        val = val / count;
        newImage[x][y] = floor(val);
      }
    }
    return newImage;
  }

}