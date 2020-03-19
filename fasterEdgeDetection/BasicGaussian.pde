class BasicGaussian extends KernelOperator{
  
  int rounds = 3;
  
  PImage applyToImage(PImage img){
    PImage result = super.applyToImage(img);
    for(int i = 0; i < rounds - 1; i++)
      result = super.applyToImage(result);
    return result;
  }
  
  BasicGaussian(){
    super(3);
    kernelMatrix = new float[][]{
      {1, 2, 1},
      {2, 4, 2},
      {1, 2, 1},
    };
    normalization = 16;
  }
  
}
