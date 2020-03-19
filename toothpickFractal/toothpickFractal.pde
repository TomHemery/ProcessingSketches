ToothpickManager manager;
color bgCol = color(0);

void setup(){
  frameRate(60);
  fullScreen();
  manager = new ToothpickManager();
  background(bgCol);
}

void draw(){
  fill(0);
  rect(10, 20, 50, 11);
  fill(255);
  text(frameRate, 10, 30);
  manager.update();
}

void keyReleased(){
  if(key == ' '){
    manager.update();
  }
}
