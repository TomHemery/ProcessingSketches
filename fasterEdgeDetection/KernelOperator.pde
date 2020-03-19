class KernelOperator{

  float[][] kernelMatrix;
  int halfKernelMatrixWidth;
  float normalization = 1;
  
  KernelOperator(int w){
    halfKernelMatrixWidth = w / 2;
  }
  
  PImage applyToImage(PImage img){
    PImage result = new PImage(img.width, img.height);
    img.loadPixels();
    for(int x = halfKernelMatrixWidth; x < img.width - halfKernelMatrixWidth; x++){
      for(int y = halfKernelMatrixWidth; y < img.height - halfKernelMatrixWidth; y++){
        float sum = 0;
        for(int kernelX = -halfKernelMatrixWidth; kernelX <= halfKernelMatrixWidth; kernelX++){
          for(int kernelY = -halfKernelMatrixWidth; kernelY <= halfKernelMatrixWidth; kernelY++){
            sum += extractVal(img, x + kernelX, y + kernelY) * kernelMatrix[kernelX + 1][kernelY + 1];
          }
        }
        sum = sum / normalization;
        result.pixels[x + y * img.width] = color(sum);
      }
    }  
    result.updatePixels();
    return result;
  }
  
  float calculatePoint(PImage img, int x, int y){
    float sum = 0;
    for(int kernelX = -halfKernelMatrixWidth; kernelX <= halfKernelMatrixWidth; kernelX++){
      for(int kernelY = -halfKernelMatrixWidth; kernelY <= halfKernelMatrixWidth; kernelY++){
        sum += extractVal(img, x + kernelX, y + kernelY) * kernelMatrix[kernelX + 1][kernelY + 1];
      }
    }
    sum = sum / normalization;
    return sum;
  }
  
  int extractVal(PImage img, int x, int y){
    return img.pixels[x + y * img.width] & 0xFF;
  }
  
}
