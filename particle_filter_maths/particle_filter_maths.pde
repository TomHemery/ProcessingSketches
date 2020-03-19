ParticleFilter filter;

void setup(){
  size(800, 800);
  filter = new ParticleFilter(10);
}

void draw(){
  background(0);
  filter.render();
  filter.update();
}

void keyPressed(){
  filter.randomize();
}
