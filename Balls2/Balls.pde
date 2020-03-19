PVector GRAVITY = new PVector(0f, 2000f);
BallHandler ballHandler;


void setup(){
  colorMode(HSB);
  fullScreen();
  ellipseMode(RADIUS);
  ballHandler = new BallHandler();
}

void draw(){
  background(0);
  fill(255);
  text(frameRate, 10, 30);
  renderDrag();
  
  ballHandler.update(); 
  ballHandler.render();
}