class Particle{

  PVector pos;
  PVector vel;
  PVector acc;
  Boolean finished = false;
  int maxAlpha = 200;
  float maxDuration = 240;
  float remainingDuration = maxDuration;
  float maxDecay = 1;
  int size;
  float minVel = 1;
  float maxVel = 3;
  float maxVelDampening = 0.99;
  int r, g, b;
  
  Particle(int x, int y, int size, int r, int g, int b){
    pos = new PVector(x, y);  
    this.size = size;
    this.vel = PVector.random2D();
    this.vel.mult(random(minVel, maxVel));
    this.acc = PVector.random2D();
    this.acc.mult(0.1);
    this.r = r;
    this.g = g;
    this.b = b;
  }
  
  void show(PVector wind){
    fill(r, g, b, map(remainingDuration, 0, maxDuration, 0, maxAlpha));
    ellipse(pos.x, pos.y, size, size);
    update(wind);
  }
  
  void update(PVector wind){
    remainingDuration -= random(maxDecay);
    calculateForces(wind);
    vel.mult(random(maxVelDampening, 1));
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
  }
  
  void calculateForces(PVector wind){
    acc = PVector.random2D();
    acc.mult(0.1);
    acc.add(wind);
  }
 
  boolean finished(){
    return remainingDuration <= 0;
  }
  
}