class Bullet{
  
  PVector vel;
  PVector pos;
  int speed = 16;
  boolean finished = false;

  public Bullet(float x, float y, PVector direction){
    vel = direction; 
    vel.setMag(speed);
    pos = new PVector(x, y);
  }
  
  void update(){
    if(pos.x > width || pos.x < 0 || pos.y > height || pos.y < 0){
      finished = true;
    }
    pos.add(vel);
  }
  
  void show(){
    update();
    stroke(255);
    strokeWeight(4);
    point(pos.x, pos.y);
  }
}