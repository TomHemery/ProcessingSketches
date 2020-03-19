abstract class Entity{

  public float speed = 2.0;
  
  protected Character [] collidableValues = new Character [] {Cell.WALL_VALUE, Cell.ENEMY_SPAWN_VALUE, Cell.CLEAR_VALUE};

  protected PVector pos;
  protected PVector vel;
  protected int radius;
  protected PVector velDesired = null;
  
  protected final int NO_COLLISION = -1;
  protected final int COLLIDE_UP = 0;
  protected final int COLLIDE_DOWN = 1;
  protected final int COLLIDE_LEFT = 2;
  protected final int COLLIDE_RIGHT = 3;
  
  Entity(int x, int y){
    pos = new PVector(x, y);
    vel = new PVector();
    radius = Cell.ABS_DIMS / 2;
  }
  
  abstract void render();
  
  void update(){ 
    if(velDesired != null){
      if(collide(velDesired) == -1){
        vel.set(velDesired);
        velDesired = null;
      }
    }
    
    if(vel.magSq() != 0){
      int collision = collide(vel);
      if(collision == -1){
        pos.add(vel);
      } else {
        correctCollision(collision);
        vel.mult(0);
      }
    }
  }
  
  protected void correctCollision(int direction){
    switch(direction){
      case COLLIDE_UP:
        pos.y = ((((int)(pos.y + vel.y)) / Cell.ABS_DIMS) + 1) * Cell.ABS_DIMS - radius;
        break;
      case COLLIDE_DOWN:
        pos.y = ((((int)(pos.y + vel.y)) / Cell.ABS_DIMS)) * Cell.ABS_DIMS + radius;
        break;
      case COLLIDE_RIGHT:
        pos.x = ((((int)(pos.x + vel.x)) / Cell.ABS_DIMS)) * Cell.ABS_DIMS + radius;
        break;
      case COLLIDE_LEFT:
        pos.x = ((((int)(pos.x + vel.x)) / Cell.ABS_DIMS) + 1) * Cell.ABS_DIMS - radius;
        break;
        
    }
  }
  
  protected int collide(PVector vel){
    PVector nextPosCenter = PVector.add(pos, vel);
    PVector [] toCheck = new PVector[3];
    
    if(vel.x != 0){
      nextPosCenter.x = vel.x > 0 ? nextPosCenter.x + radius : nextPosCenter.x - radius;
      toCheck[1] = nextPosCenter;
      toCheck[0] = new PVector(nextPosCenter.x, nextPosCenter.y - radius + 1);
      toCheck[2] = new PVector(nextPosCenter.x, nextPosCenter.y + radius - 1);
    }
    else if (vel.y != 0){
      nextPosCenter.y = vel.y > 0 ? nextPosCenter.y + radius : nextPosCenter.y - radius;
      toCheck[1] = nextPosCenter;
      toCheck[0] = new PVector(nextPosCenter.x - radius + 1, nextPosCenter.y);
      toCheck[2] = new PVector(nextPosCenter.x + radius - 1, nextPosCenter.y);
    }
    println(this);
    println(nextPosCenter);
    println(toCheck);
    for(PVector nextPos : toCheck){
      char c = grid.getCellValue(nextPos.x, nextPos.y);
      for(char collidable : collidableValues){
        if(c == collidable){
          if(vel.x != 0){
            return vel.x > 0 ? COLLIDE_RIGHT : COLLIDE_LEFT;
          } else{
            return vel.y > 0 ? COLLIDE_DOWN : COLLIDE_UP;
          }
        }
      }
    }
    return -1;
  }
    
  
}
