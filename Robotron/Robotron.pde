Player player;
BulletHandler bulletHandler;
RobotHandler robotHandler;

void settings(){
  fullScreen();
}

void setup(){
  bulletHandler = new BulletHandler();
  robotHandler = new RobotHandler();
  player = new Player(width/2, height/2);
}

void draw(){
  background(0);
  player.show();
  bulletHandler.show();
  robotHandler.show();
}