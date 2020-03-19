class BasicGaussian extends Kernel{

  BasicGaussian(){
    super(5);
    contents = new float[][] {
      {1, 4, 7, 4, 1},
      {4, 16, 26, 16},
      {7, 26, 41, 26, 7},
      {4, 16, 26, 16},
      {1, 4, 7, 4, 1}
    };
  }
  
}