class Player{
  PVector pos;
  PVector vel = new PVector();
  PVector acc = new PVector();
  int size;
  color colour = color(150, 255, 150);
  int score = 0;
  
  PVector direction = new PVector();
  int accRate = 2;
  int maxSpeed = 12;
  
  PVector shootDirection = new PVector();
  boolean shooting = false;
  int shootTimerStart = 10;
  int shootTimer = 0;
  
  //W A S D UP LEFT DOWN RIGHT
  boolean keysPressed[] = {false, false, false, false,
                           false, false, false, false};
  
  public Player(int x, int y){
    pos = new PVector(x, y);
    size = 30;
  }
  
  void setDirection(char _key){
    switch(_key){
      case('w'):keysPressed[0]=true;break;
      case('a'):keysPressed[1]=true;break;
      case('s'):keysPressed[2]=true;break;
      case('d'):keysPressed[3]=true;break;
    }
  }
  
  void unSetDirection(char _key){
    switch(_key){
      case('w'):keysPressed[0]=false;break;
      case('a'):keysPressed[1]=false;break;
      case('s'):keysPressed[2]=false;break;
      case('d'):keysPressed[3]=false;break;
    }  
  }
  
  void setShoot(int code){
    switch(code){
      case(UP):keysPressed[4]=true;break;
      case(LEFT):keysPressed[5]=true;break;
      case(DOWN):keysPressed[6]=true;break;
      case(RIGHT):keysPressed[7]=true;break;
    }
  }
  
  void unSetShoot(int code){
    switch(code){
      case(UP):keysPressed[4]=false;break;
      case(LEFT):keysPressed[5]=false;break;
      case(DOWN):keysPressed[6]=false;break;
      case(RIGHT):keysPressed[7]=false;break;
    }
  }
  
  void shoot(){
    shooting = false;
    shootDirection.mult(0);
    if(keysPressed[4]){shootDirection.y = -1; shooting = true;}
    if(keysPressed[5]){shootDirection.x = -1; shooting = true;}
    if(keysPressed[6]){shootDirection.y = 1; shooting = true;}
    if(keysPressed[7]){shootDirection.x = 1; shooting = true;}
    
    if(shooting){
      shootTimer--;
      if(shootTimer <= 0){
        bulletHandler.addBullet(pos.x + size/2, pos.y + size/2, shootDirection);
        shootTimer = shootTimerStart;
      }
    }  
  }
  
  void applyForce(){
    direction.mult(0);
    
    boolean moving = false;
    if(keysPressed[0]){direction.y = -accRate; moving = true;}
    if(keysPressed[1]){direction.x = -accRate; moving = true;}
    if(keysPressed[2]){direction.y = accRate; moving = true;}
    if(keysPressed[3]){direction.x = accRate; moving = true;}
    
    if(!moving){
      vel.mult(0.8);
    }
    
    shoot();
    
    acc.mult(0);
    acc.add(direction);
    vel.add(acc);
    if(vel.mag() > maxSpeed){
      vel.setMag(maxSpeed);
    }
    pos.add(vel);
  }
  
  void addScore(int val){
    score += val;
  }
  
  void update(){
    applyForce();
    constrainToScreen(pos, size);
  }
  
  void show(){
    update();
    noStroke();
    fill(colour);
    rect(pos.x, pos.y, size, size);
  }
  
  void showScore(){
    fill(255);
    text("Score: " + score, 10, 40);
  }
  
}