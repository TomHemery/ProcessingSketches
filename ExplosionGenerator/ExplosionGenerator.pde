Explosion e;

void setup(){
  background(0);
  e = new Explosion();
  ellipseMode(CENTER);
  size(32, 32);
}

void draw(){
  background(0, 0, 0, 0);
  e.Update();
  e.Render();
  //saveFrame("Explosion-######.png");
}
