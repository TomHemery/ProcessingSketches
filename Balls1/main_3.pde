ArrayList<Ball> balls = new ArrayList<Ball>();
PVector gravity = new PVector(0, 0.8);
PVector drag_start = new PVector();
boolean dragging = false;

void setup(){
  fullScreen();
  ellipseMode(RADIUS);
}

void draw(){
  background(51);
  for(int i=0; i<balls.size(); i++){
    balls.get(i).process();
  }
  if (dragging){
    stroke(100);
    strokeWeight(5);
    line(mouseX, mouseY, drag_start.x, drag_start.y);
  }
  collide(balls);
  //if(mousePressed){
  //  balls.add(new Ball(mouseX, mouseY, new PVector(0, 0)));
  //}
}

void keyPressed(){
  if (key == DELETE){
    balls = new ArrayList<Ball>();
  }
}

void mousePressed(){
  drag_start.set(mouseX, mouseY);
  dragging = true;
}

void mouseReleased(){
  dragging = false;
  PVector d = new PVector(mouseX, mouseY);
  d.sub(drag_start);
  d.mult(-0.2);
  balls.add(new Ball(mouseX, mouseY, d));
}