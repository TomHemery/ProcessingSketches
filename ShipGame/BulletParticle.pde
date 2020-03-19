class BulletParticle{

  PVector pos = new PVector();
  PVector vel; 
  color colour = 255;
  
  public BulletParticle(float x, float y, float angle, float shipVel){
    pos.set(x, y);
    vel = PVector.fromAngle(angle);
    vel.mult(35);
    vel.add(PVector.fromAngle(angle).mult(shipVel));
  }
  
  void update(){
    pos.add(vel);
    vel.mult(0.97);
  }
  
  boolean finished(){
    return(vel.mag() < 0.2);
  }
  
  void collide(Meteor t){
    float distance = PVector.sub(t.pos, this.pos).mag();
    if(distance < t.radius + 2){
      t.destroy();
    }
  }
  
  void show(){
    update();
    strokeWeight(4);
    stroke(colour);
    point(pos.x, pos.y);
  }

}