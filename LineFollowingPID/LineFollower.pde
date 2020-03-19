class LineFollower{

  PVector pos;
  float speed = 0;
  float heading = 0;
  
  float w = 30;
  float h = 50;
  
  float maxForageSpeed = 4;
  float maxFollowSpeed = 3;
  float turnSpeed = 0.1f;
  float turnFactor;
  
  float black = 90;
  float white = 120;
  float threshold; 
  float lightLevel;
  float prevLightLevel;
  float lightGrad;
  float prevLightGrad;
  float maxGrad = 0;
  
  boolean lost = true;
  boolean aligning = false;
  boolean firstUpdate = true;
  
  float error;
  float prevError;
  
  float i;
  float d;
  
  float kp = 0.0005;
  float kd = 0.0001;
  float ki = 0.0002;
  
  LineFollower(){
    pos = new PVector(width / 2, height / 2);
  }
  
  void Update(){    
    threshold = (black + white) / 2;
    lightLevel = testLightLevel();
     
    if(firstUpdate){
      prevLightLevel = testLightLevel();
      firstUpdate = false;  
    }
    else{    
      lightGrad = lightLevel - prevLightLevel;   
      if(abs(lightGrad) > abs(maxGrad))maxGrad = lightGrad;
      prevLightGrad = lightGrad;
      prevLightLevel = lightLevel;
    }
    
    if(lost){
      if(!aligning){
        if(abs(lightGrad) > 10){
          black = lightLevel;
          aligning = true;
          speed = 0;
        }
        else 
          speed = maxForageSpeed;
      }
      else{
        heading += turnSpeed;
        if(abs(lightGrad) > 2){
          lost = false;
          white = lightLevel;
          speed = 0;
        }
      } 
    }
    else{
      if(lightLevel > threshold) white = lightLevel;
      else if(lightLevel < threshold) black = lightLevel;
      speed = maxFollowSpeed / 2;   
      heading += PID(); 
    }
    
    pos.add(PVector.fromAngle(heading).mult(speed));
  }
  
  float PID(){
    error = threshold - lightLevel;
    if(firstUpdate){
      prevError = error;
      firstUpdate = false;
    } 
    i += error;
    d = error - prevError;
    
    return kp * error + ki * i + kd * d;
  }
  
  void Display(){
    fill(255);
    text("Black: " + black, 2, 2);
    text("White: " + white, 2, 22);
    text("Threshold: " + threshold, 2, 42);
    text("Light level: " + lightLevel, 2, 62);
    text("Turn factor: " + turnFactor, 2, 82);
    text("Light gradient: " + lightGrad, 2, 102);
    text("Max gradient: " + maxGrad, 2, 122);
    
    
    pushMatrix();
      translate(pos.x, pos.y);
      rotate(heading - PI/2);
      fill(0);
      noStroke();
      rect(0, 0, w, h);
      stroke(255, 0, 0);
      strokeWeight(2);
      line(0, 0, 0, h/2);
      noFill();
      circle(0, h/2, 10);
    popMatrix();
  }
  
  float testLightLevel(){
    PVector testPos = PVector.add(pos, PVector.fromAngle(heading).mult(h/2));
    track.loadPixels();
    color c = track.pixels[floor(testPos.x) + track.width * floor(testPos.y)];
    track.updatePixels();
    
    return ((float)red(c) + (float)green(c) +(float)blue(c)) / 3;
  }

}
