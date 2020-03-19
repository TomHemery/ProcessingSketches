class SnowFlake{
  
  PVector pos;
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  float angle = 0;
  float angleOffset = random(0.005, 0.02);
  
  float terminalVelocity = 3;
  PImage sprite; 
  
  float scale = 1;
  float maxScale = 18;
  
  int r = 4;
  
  SnowFlake(){
    reset();
    angleOffset = (random(1) > 0.5)? angleOffset *= -1: angleOffset;
    sprite = snowSprites.get(floor(random(snowSprites.size())));
    pos = new PVector(random(width), random(-height/4, height));
  }

  void reset(){
    pos = new PVector(random(width), random(-height/4, -10));
    vel.mult(0);
    acc.mult(0);
    float r1 = random(1);
    float r2 = random(1);
    scale = ((r1<r2) ? r1 : r2) * maxScale; //always prefer smaller scales, more particles in the background
    scale = constrain(scale, 1, maxScale);
  }
  
  void update(){
    if(belowScreen()){reset();}
    wrapAround();
    acc.add(PVector.random2D().mult(0.025));
    vel.add(acc);
    vel.limit(terminalVelocity);
    vel.mult(log(scale) + 1); // parallax, smaller particles move slower
    pos.add(vel);
    acc.mult(0);
    angle += angleOffset;
  }
  
  boolean belowScreen(){
    return pos.y - r > height; 
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void wrapAround(){
    if(pos.x - 2 * r > width){pos.x = -r;}
    else if(pos.x +  2 * r < 0){pos.x = width + r;}
  }
  
  void show(){
    //stroke(255);
    //strokeWeight(r * scale); // parallax, smaller particles in the background
    //point(pos.x, pos.y);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(angle);
    image(sprite, 0, 0, r * scale, r * scale);
    popMatrix();
  }

}