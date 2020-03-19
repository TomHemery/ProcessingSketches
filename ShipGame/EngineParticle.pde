class EngineParticle{

  PVector pos = new PVector();
  PVector vel = new PVector(); 
  float r = 5;
  int[] colour = {200, 0, 255, 255};
  
  public EngineParticle(float x, float y, float velX, float velY){
    this.pos.set(x, y);
    this.vel.set(velX, velY);
    vel.mult(0.2);
  }
  
  void update(){
    this.pos.add(this.vel);
    this.vel.mult(0.99);
  }
  
  boolean finished(){
    return(colour[3] <= 0);
  }
  
  void show(){
    update();
    noFill();
    stroke(colour[0], colour[1], colour[2], colour[3]);
    strokeWeight(2);
    ellipse(pos.x, pos.y, r, r);
    r+=0.4;
    colour[3]-=2;
  }

}