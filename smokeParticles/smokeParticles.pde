ParticleEmitter emitter; 
int particleSize = 5; 

void setup(){
  fullScreen(P2D);
  ellipseMode(CENTER);
  emitter = new ParticleEmitter(width/2, height/2, particleSize);
  textSize(32);
}

void draw(){
  background(0);
  fill(255);
  text(frameRate, 10, 40);
  emitter.show();
}