class Meteor{
  
  PVector pos;
  PVector vel = new PVector();
  PVector acc;
  int radius = 20;
  boolean destroyed = false;
  int maxVel = 12;
  Ship s;
  
  public Meteor(float x, float y, Ship _s){
    pos = new PVector(x, y);
    s = _s;
    acc = PVector.sub(s.pos, pos).setMag(0.4);
  }
  
  void update(){
    vel.add(acc);
    if(vel.mag() > maxVel){
      vel.setMag(maxVel);
    }
    pos.add(vel);
  }
  
  void show(){
    update();
    stroke(255);
    noFill();
    strokeWeight(2);
    ellipse(pos.x, pos.y, radius*2, radius*2);
    offScreen();
  }
  
  void offScreen(){
    if(PVector.dist(s.pos, pos) > (width+height) * 3/2){
      destroy();
    }
  }
  
  void destroy(){
    if(!destroyed){
      destroyed = true;
    }
  }
    
}