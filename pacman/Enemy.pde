class Enemy extends Entity{
  
  private color fillColour;
  private color outlineColour;
  private Cell prev = null;
  
  PVector [] possibleVelocities = new PVector [] {new PVector(speed, 0), new PVector(-speed, 0), new PVector(0, speed), new PVector(0, -speed)};
  
  Enemy(int x, int y){
    super(x, y);
    collidableValues = new Character [] {Cell.WALL_VALUE};
    fillColour = color(255, 0, 0);
    outlineColour = color(0);
  }
  
  void render(){
    fill(fillColour);
    stroke(outlineColour);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  @Override
  void update(){
    Cell curr = grid.getCellAt(pos.x, pos.y);
    
    if(vel.magSq() == 0 || curr != prev){
      if(curr.isDeadEnd){
          velDesired = PVector.mult(vel, -1);
      } 
      else{
        for(PVector v : possibleVelocities){
          if(!(v.x == vel.x && v.y == vel.y)){
            if(collide(v) == NO_COLLISION){
              velDesired = new PVector(v.x, v.y);
              break;
            }
          }
        }
      }
  
      
      if(curr.isIntersection){
        do{
          PVector v = possibleVelocities[floor(random(possibleVelocities.length))];
          velDesired = new PVector(v.x, v.y);
        } while (collide(velDesired) != NO_COLLISION);
      }
    }
    
    super.update();
    prev = curr;
  }
  
}
