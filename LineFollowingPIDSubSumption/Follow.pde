class Follow extends Behaviour{
  
  float lightLevel;
  
  float error;
  float prevError;
  
  float threshold;
  
  float i;
  float d;
  
  float kp = 0.0005;
  float kd = 0.0001;
  float ki = 0.0002;
  
  boolean firstUpdate = true;
  
  float speed = 1.5;
  
  float whiteAverage;
  float blackAverage;
  float changeFactor = 8;
  
  Follow(LineFollower f){
    super(f);
    output.speed = speed;
  }
  
  void Update(){
    output.subsume = !follower.lost;
    lightLevel = follower.testLightLevel();
    threshold = (whiteAverage + blackAverage) / 2;
    
    //heading change and dynamic thresholding;
    if(!follower.lost){
      output.headingChange = PID();
      
      if(lightLevel > threshold){
        whiteAverage = (whiteAverage * (changeFactor - 1) + lightLevel) / changeFactor;
      } 
      else{
        blackAverage = (blackAverage * (changeFactor - 1) + lightLevel) / changeFactor;
      }
    }
  }
  
  float PID(){
    error = threshold - lightLevel;
    if(firstUpdate){
      prevError = error;
      firstUpdate = false;
    } 
    i += error;
    d = error - prevError;
    prevError = error;
    return kp * error + ki * i + kd * d;
  }
  
}
