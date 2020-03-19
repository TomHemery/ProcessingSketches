Player player;
BulletHandler bulletHandler;
RobotHandler robotHandler;

void settings(){
  fullScreen();
}

void reset(){
  player = new Player(width/2, height/2);
  bulletHandler = new BulletHandler();
  robotHandler = new RobotHandler();
}

void setup(){
  textSize(32);
  reset();
}

void draw(){
  background(0);
  player.show();
  bulletHandler.show();
  robotHandler.show();
  player.showScore();
}

void constrainToScreen(PVector pos, int size){
  if(pos.x < 0){pos.x = 0;}
  else if(pos.x > width - size){pos.x = width-size;}
  if(pos.y < 0){pos.y = 0;}
  else if(pos.y > height - size){pos.y = height-size;}
}