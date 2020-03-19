class Ball{
  
  int radius = 10;
  color colour;
  int mass = 1;
  
  PVector pos;
  PVector vel;
  PVector acc;
  
  float bounceCoefficient = 0.95;
  float airResistance = 0.99;
  
  ArrayList<Ball> alreadyCollidedWith = new ArrayList();
  
  Ball(float x, float y, PVector _vel){
    colour = color(random(255), 150, 255);
    pos = new PVector(x, y);
    vel = _vel;
    acc = new PVector(0, 0);
  }
  
  void addForce(PVector f){
    acc.add(f);
  }
  
  void update(float secondsPassed){
    alreadyCollidedWith.clear();
    vel.add(acc.mult(secondsPassed));
    vel.mult(airResistance);
    pos.x += vel.x * secondsPassed;
    pos.y += vel.y * secondsPassed;
    acc.x = 0;
    acc.y = 0;
  }
  
  void render(){
    fill(colour);
    noStroke();
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void offScreen(){
    if(pos.x - radius < 0 || pos.x + radius > width){
      pos.x = pos.x - radius < 0 ? radius : width - radius;
      vel.x = - vel.x * bounceCoefficient;
    }
    if(pos.y - radius < 0 || pos.y + radius > height){
      pos.y = pos.y < 0 ? radius : height - radius;
      vel.y = - vel.y * bounceCoefficient;
    } 
  }
  
  void collide(Ball b){
    if(alreadyCollidedWith.size() == 0 || !alreadyCollidedWith.contains(b)){
      if(dist(pos.x, pos.y, b.pos.x, b.pos.y) < radius + b.radius){
        removeCollision(b);
        float velX = vel.x;
        float velY = vel.y;
        vel.x = (2 * b.mass * b.vel.x) / (mass + b.mass);
        vel.y = (2 * b.mass * b.vel.y) / (mass + b.mass);
        b.vel.x = (2 * mass * velX) / (mass + b.mass);
        b.vel.y = (2 * mass * velY) / (mass + b.mass);
        b.collidedWith(this);
      }
    }
  }
  
  void removeCollision(Ball b){
    float overlap = radius + b.radius - dist(pos.x, pos.y, b.pos.x, b.pos.y);
    backtrack(overlap / 2);
    b.backtrack(overlap / 2);
  }
  
  void backtrack(float dist){
    PVector v2 = new PVector(vel.x, vel.y);
    v2.normalize();
    v2.mult(-dist);
    pos.add(v2);
  }
  
  void collidedWith(Ball b){
    alreadyCollidedWith.add(b);
  }
  
}