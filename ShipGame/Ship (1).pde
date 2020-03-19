class Ship{
  
  //position and velocity
  PVector pos;
  PVector vel;
  PVector acc;
  float baseSpeed = 10;
  PVector baseAcceleration = new PVector(0, 1);
  float dampening = 0.99;
  
  //rotation
  float heading;
  float rotationSpeed = 0.1;
  float rotation = 0;
  boolean rotating = false;
  
  //dimensions 
  float size = 10;
  
  //fancy shit
  ArrayList<PVector> tail;
  int maxTailLength = 50;
  
  //colours
  color tailColour;
  color shipColour;

  public Ship(){
    this.pos = new PVector(width/2, height/2);
    this.vel = new PVector();
    this.acc = new PVector();
    this.heading = 0;
    tail = new ArrayList();
    tailColour = color(210, 0, 255);
    shipColour = color(255, 255, 255);
  }
  
  void turn(){this.heading += rotation;}
  
  void setRotation(float a){
    if(a != 0){this.rotating = true;}
    else{this.rotating = false;}
    this.rotation = a;
  }  
  
  void updateTail(){
    this.tail.add(new PVector(this.pos.x, this.pos.y));
    if(this.tail.size() < this.maxTailLength){
      this.tail.remove(0);
    }
  }
  
  void update(){
    this.updateTail();
    this.turn();
    this.applyForce();
  }
  
  void applyForce(){
    this.vel.mult(dampening);
    this.acc.set(PVector.fromAngle(heading).mult(0.5));
    this.vel.add(acc);
    if(vel.mag() > baseSpeed){
      vel.setMag(baseSpeed);
    }
    this.pos.add(vel);
    this.acc.mult(0);
  }
  
  void show(){
    this.update();
    
    noStroke();
    fill(255);
    translate(this.pos.x, this.pos.y);
    rotate(this.heading);
    beginShape();
      vertex(size, 0);
      vertex(-size, size);
      vertex(-size/2, 0);
      vertex(-size, -size);      
    endShape(CLOSE);
    translate(0, 0);
    
    PVector prev = pos;
    for(PVector p: tail){
      stroke(tailColour);
      line(prev.x, prev.y, p.x, p.y);
    }
  }
  
  
}