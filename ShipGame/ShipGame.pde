  Ship s;
MeteorHandler meteors;

void setup(){
  fullScreen();
  s = new Ship();
  meteors = new MeteorHandler(s);
  s.setUpParticles();
  textSize(32);
  ellipseMode(CENTER);
}

void draw(){
  background(0);
  text(frameRate, 100, height - 100);
  s.update();
  translate(-s.pos.x + (width / 2), -s.pos.y + (height / 2));
  s.show();
  meteors.show();
}