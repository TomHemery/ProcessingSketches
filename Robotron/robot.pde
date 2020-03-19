class Robot{
  
  int size = 50;
  color colour = color(240, 180, 180);
  PVector pos;

  public Robot(float x, float y){
    pos = new PVector(x, y);
  }
  
  void update(){
    pos = new PVector(random(width), random(height));
  }
  
  boolean collide(){
    for(Bullet b: bulletHandler.bullets){
      if(b.pos.x < pos.x + size && b.pos.x > pos.x){
        if(b.pos.y < pos.y + size && b.pos.y > pos.y){
          return true;          
        }
      }
    }
    return false;
  }

  void show(){
    noStroke();
    fill(colour);
    rect(pos.x, pos.y, size, size);
  }
  
}