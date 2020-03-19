PVector dragStart = null;
boolean dragging = false;

void mousePressed(){
  dragStart = new PVector(mouseX, mouseY);
  dragging = true;
}

void mouseReleased(){
  PVector force = new PVector(dragStart.x - mouseX, dragStart.y - mouseY);
  force.mult(2);
  ballHandler.addBall(mouseX, mouseY, force);
  dragging = false;
}

void renderDrag(){
  if(dragging){
    strokeWeight(10);
    stroke(150);
    line(dragStart.x, dragStart.y, mouseX, mouseY);
  }
}