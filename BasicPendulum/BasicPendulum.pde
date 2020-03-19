Pendulum p;

float gravity = 0.4;
PVector vertical = new PVector(0, 1);

void setup(){
  fullScreen();
  p = new Pendulum(width/2, height/2, 100, 9*PI/10, 5, null);
}

void draw(){
  background(255);
  p.Display();
  p.Update();
  
  if(mousePressed){
    p.anchor = new PVector(mouseX, mouseY);
  }
  
}
