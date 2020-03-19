class Robot{
  
  final static int baseSize = 50;
  int size = baseSize;
  color colour = color(240, 180, 180);
  PVector pos;
  PVector vel = new PVector();
  PVector acc;
  float maxSpeed = 2;
  int maxDist = height / 3;
  int scoreValue = 100;
  

  public Robot(float x, float y){
    pos = new PVector(x, y);
  }
  
  void seek(){
    if(PVector.dist(player.pos, pos) < maxDist){
      acc = PVector.sub(player.pos, pos).mult(1);
      vel.add(acc);
      if(vel.mag()>maxSpeed){vel.setMag(maxSpeed);}
    }
    else{vel.mult(0.95);}
    pos.add(vel);
  }
  
  void update(){
    seek();
    constrainToScreen(pos, size);
  }
  
  boolean collideWithPlayer(){
    if(!(pos.x + size < player.pos.x ||
       pos.x > player.pos.x + player.size ||
       pos.y + size < player.pos.y ||
       pos.y > player.pos.y + player.size))
     {
       return true;  
     }
     return false;
  }
  
  boolean collideWithBullet(){
    for(Bullet b: bulletHandler.bullets){
      if(b.pos.x < pos.x + size && b.pos.x > pos.x){
        if(b.pos.y < pos.y + size && b.pos.y > pos.y){
          player.addScore(scoreValue);
          return true;          
        }
      }
    }
    return false;
  }

  void show(){
    update();
    noStroke();
    fill(colour);
    rect(pos.x, pos.y, size, size);
  }
  
}