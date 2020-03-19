Grid g;

void setup(){
  size(600, 600);
  colorMode(HSB);
  g = new Grid(6, 6, 0, 60, 110);
  g.populate();
  g.randomize();
}

void draw(){
  background(0);
  g.show();
}

void mousePressed(){
  g.pick_card(mouseX, mouseY);
}

void mouseReleased(){
  g.up_pick_card(mouseX, mouseY);
}