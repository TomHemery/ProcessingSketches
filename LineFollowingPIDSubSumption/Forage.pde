class Forage extends Behaviour{
  
  ForageState state = ForageState.LookingForLine;
  
  float lightLevel;
  float prevLightLevel = 0;
  float gradient = 0;
  float prevGradient = 0;
  float secondDeriv = 0;
  float prevSecondDeriv = 0;
  float lineThreshold = 5;
  
  int warmUpCounter = 0;
  int warmUp = 4;
  
  float speed = 2;
  float turnSpeed = 0.05f;
  
  long numWhiteReads = 0;
  long numBlackReads = 0;
  
  Forage(LineFollower f){
    super(f);
    output.subsume = true;
  }
  
  void Update(){
    lightLevel = follower.testLightLevel();
    gradient = lightLevel - prevLightLevel;
    secondDeriv = gradient - prevGradient;
    
    if(warmUpCounter < warmUp) warmUpCounter++;
    else{        
      switch(state){ 
        case LookingForLine:
          output.speed = speed;
          output.headingChange = 0;
          if((secondDeriv > 0 && prevSecondDeriv < 0 || secondDeriv < 0 && prevSecondDeriv > 0) && abs(secondDeriv - prevSecondDeriv) > lineThreshold){
            state = ForageState.AligningToLine;
            numWhiteReads = 0;
          } else{
            numWhiteReads ++;
            follower.followBehaviour.whiteAverage = (lightLevel + (follower.followBehaviour.whiteAverage * (numWhiteReads - 1))) / numWhiteReads;
          }
          break;
        case AligningToLine:
          output.speed = 0;
          output.headingChange = turnSpeed;
          if((secondDeriv > 0 && prevSecondDeriv < 0 || secondDeriv < 0 && prevSecondDeriv > 0) && abs(secondDeriv - prevSecondDeriv) > lineThreshold){
            follower.lost = false;
            numBlackReads = 0;
            state = ForageState.WaitingForLost;
          }
          else{
            numBlackReads ++;
            follower.followBehaviour.blackAverage = (lightLevel + (follower.followBehaviour.blackAverage * (numBlackReads - 1))) / numBlackReads;
          }
          break;
        case WaitingForLost:
          if(follower.lost) state = ForageState.LookingForLine;
      }
    }
    prevLightLevel = lightLevel;
    prevGradient = gradient;
    prevSecondDeriv = secondDeriv;
  }
  
}

enum ForageState {
  LookingForLine,
  AligningToLine,
  WaitingForLost;
}
