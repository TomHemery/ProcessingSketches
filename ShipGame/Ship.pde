class Ship{
  
  //position and velocity
  PVector pos;
  PVector vel;
  PVector acc;
  float baseSpeed = 8;
  PVector baseAcceleration = new PVector(0, 1);
  float dampening = 0.995;
  boolean breaking = false;
  float breakPower = 0.9;
  SpeedMeter speedMeter;
  
  //boosts
  boolean boosting = false;
  boolean endBoost = false;
  float boostSpeed = 16;
  
  //rotation
  float heading;
  float rotationSpeed = 0.1;
  float rotation = 0;
  boolean rotating = false;
  
  //dimensions 
  float size = 10;
  
  //tail
  ArrayList<PVector> tail;
  int maxTailLength = 25;
  float tailWidth;
  int tailStartWidth = 5;
  boolean addToTail = true;
  
  //particles
  ParticleHandler particles;
  boolean shooting = false;
  int shootTimer = 0;
  int shootTime = 5;
  
  //colours
  int[] tailColour = {200, 0, 255, 0};
  color shipColour;
  color shipShadowColour;
  int tailAlpha = 240;

  public Ship(){
    this.pos = new PVector(width/2, height/2);
    this.vel = new PVector();
    this.acc = new PVector();
    this.heading = 0;
    tail = new ArrayList();
    shipColour = color(255);
    shipShadowColour = color(150);
    speedMeter = new SpeedMeter(boostSpeed, this);
  }
  
  void setUpParticles(){
    particles = new ParticleHandler(meteors);
  }
  
  void shoot(boolean _shooting){
    if(!shooting){shootTimer = shootTime;}
    this.shooting = _shooting;
  }
  
  void boost(boolean _boost){
    if(!_boost){this.endBoost = true;}
    else{
      this.endBoost = false;
      if(!this.boosting){
        boostExplosion();
      }
    }
    this.boosting = _boost;
  }
  
  void boostExplosion(){
    int d = 25;
    particles.addEngineParticle(pos.x - d, pos.y, -vel.x, -vel.y);
    particles.addEngineParticle(pos.x + d, pos.y, -vel.x, -vel.y);
    particles.addEngineParticle(pos.x, pos.y + d, -vel.x, -vel.y);
    particles.addEngineParticle(pos.x, pos.y - d, -vel.x, -vel.y);
    particles.addEngineParticle(pos.x, pos.y, -vel.x, -vel.y);
  }
  
  void turn(){this.heading += rotation;}
  
  void setRotation(float a){
    if(a != 0){this.rotating = true;}
    else{this.rotating = false;}
    if(boosting){a = a/2;}
    this.rotation = a;
  }  
  
  void updateTail(){
    if(addToTail){
      this.tail.add(new PVector(this.pos.x, this.pos.y));
      if(this.tail.size() > this.maxTailLength){
        this.tail.remove(0);
      }
    }
    addToTail = !addToTail;
  }
  
  void update(){
    if(shooting){
      if(shootTimer >= shootTime){
        particles.addBulletParticle(pos.x, pos.y, heading, vel.mag());
        shootTimer = 0;
      }
      else{shootTimer++;}
    }
    this.updateTail();
    if(floor(random(15)) == 5){particles.addEngineParticle(pos.x, pos.y, vel.x, vel.y);}
    this.turn();
    this.applyForce();
  }
  
  void applyForce(){
    this.vel.mult(dampening);
    if(breaking){
      this.vel.mult(breakPower);
    }
    this.acc.set(PVector.fromAngle(heading).mult(0.5));
    this.vel.add(acc);
    if(vel.mag() > baseSpeed && !boosting && !endBoost){
      vel.setMag(baseSpeed);
    }
    else if(vel.mag() > boostSpeed && !endBoost){
      vel.setMag(boostSpeed);
    }
    else if(endBoost){
      vel.mult(0.95);
      if(vel.mag() < baseSpeed){
        vel.setMag(baseSpeed);
        endBoost = false;
      }
    }
    this.pos.add(vel);
    this.acc.mult(0);
  }
  
  void brake(){
    this.breaking = true;
  };
  
  void unBrake(){
    this.breaking = false;
  }
  
  void show(){   
    PVector prev = pos;
    PVector p;
    tailWidth = tailStartWidth;
    strokeWeight(tailWidth);
    tailColour[3] = tailAlpha;
    for(int i = tail.size() - 1; i >= 0; i --){
      stroke(tailColour[0], tailColour[1], tailColour[2], tailColour[3]);
      p = tail.get(i); 
      line(p.x, p.y, prev.x, prev.y);
      prev = p;
      tailWidth = tailWidth - tailWidth / maxTailLength;
      strokeWeight(tailWidth);  
      tailColour[3]-=tailAlpha/maxTailLength;
    }
    
    particles.show();
  
    noStroke();
    pushMatrix();
      translate(this.pos.x, this.pos.y);
      rotate(this.heading);
      fill(shipColour);
      beginShape();
        vertex(size, 0);
        vertex(-size/2, 0);
        vertex(-size, -size);      
      endShape(CLOSE);
      fill(shipShadowColour);
      beginShape();
        vertex(size, 0);
        vertex(-size/2, 0);
        vertex(-size, size);      
      endShape(CLOSE);
    popMatrix();
    
    speedMeter.show();
    
  }
  
}