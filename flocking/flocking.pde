BoidManager manager;
void setup(){
  fullScreen();
  ellipseMode(RADIUS);
  manager = new BoidManager();
}

void draw(){
  background(0);
  manager.update();
  manager.render();
}
