class Ball{

  float radius;
  float diameter;
  float mass;
  
  float elasticity = 0.9;
  float resolutionTimeStep = 0.001f;
  
  PVector pos;
  PVector prevPos;
  PVector vel = new PVector();
  PVector acc = new PVector();
  
  color c = color(255);
  
  Ball(float x, float y, float radius){
    this.radius = radius;
    this.diameter = 2 * radius;
    this.mass = radius;
    pos = new PVector(x, y);
  }
  
  void update(float deltaTime){
    acc.set(0, gravity);
    vel.add(PVector.mult(acc, deltaTime));
    pos.add(PVector.mult(vel, deltaTime));
  }
  
  void bounce(){
    if(pos.x - radius < 0) {
      pos.x = radius;
      vel.x *= -elasticity;
    }
    else if(pos.x + radius > width){
      pos.x = width - radius;
      vel.x *= -elasticity;
    }
    
    if(pos.y + radius > height){
      pos.y = height - radius;
      vel.y *= -elasticity;
    }
  }
  
  void resolveCollision(Ball other){
    if(collide(other)){
      //separate colliding balls
      PVector delta = PVector.sub(pos, other.pos);
      float d = delta.mag();
      PVector mtd = delta.mult(((radius + other.radius)-d)/d);
      
      //inverse masses
      float im = 1 / mass;
      float imOther = 1 / other.mass;
      
      pos = pos.add(mtd.mult(im / (im + imOther)));
      other.pos = other.pos.sub(mtd.mult(im / (im + imOther)));
      
      //work out collision velocity
      PVector v = PVector.sub(vel, other.vel);
      float vn = v.dot(mtd.normalize());
      if(vn > 0.0f) return;
      
      //collision impulse
      float i = (-(1.0f + elasticity) * vn) / (im + imOther);
      PVector impulse = mtd.normalize().mult(i);
  
      //change in momentum
      vel.add(PVector.mult(impulse, im));
      other.vel.sub(PVector.mult(impulse, imOther));
    }
  }
  
  boolean collide(Ball other){
    float distSqr = PVector.sub(pos, other.pos).magSq();
    return distSqr < (radius + other.radius) * (radius + other.radius);
  }
  
  void render(){
    fill(c);
    circle(pos.x, pos.y, diameter);
  }
  
  void erase(color bg){
    fill(bg);
    circle(pos.x, pos.y, diameter + 1);
  }
  
}
