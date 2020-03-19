class LineFollower{

  PVector pos;
  PVector startPos;
  float heading = 0;
  float speed = 0;
  
  float w = 30;
  float h = 50;
  
  boolean lost = true;
  
  Behaviour [] behaviours = new Behaviour[3];
  
  Follow followBehaviour;
  
  LineFollower(){
    pos = new PVector(width / 2, height / 2);
    startPos = new PVector(pos.x, pos.y);
    behaviours[0] = new Forage(this);
    followBehaviour = new Follow(this);
    behaviours[1] = followBehaviour;
    behaviours[2] = new Observe(this);
  }
  
  void Update(){    
    int index;
    for(index = behaviours.length - 1; index >= 0; index--){
      if(behaviours[index].output.subsume)
        break;
    }
     if(index >= 0){
      heading += behaviours[index].output.headingChange;
      heading = heading % (2 * PI);
      speed = behaviours[index].output.speed;
      pos.add(PVector.fromAngle(heading).mult(speed));
    }
  }
  
  void Display(){
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

  
