class ParticleEmitter{

  int x, y, particleSize;
  ArrayList<Particle> particles = new ArrayList();
  int numPerFrame = 10;
  int maxNumPerFrame = 10;
  int r = 255;
  int g = 0;
  int b = 255;
  PVector wind = new PVector(0.05, 0);
  
  ParticleEmitter(int x, int y, int particleSize){
    this.x = x;
    this.y = y;
    this.particleSize = particleSize;
  }
  
  void show(){
    Particle p;
    noStroke();
    for(int i = particles.size()-1; i >= 0; i--){
      p = particles.get(i);
      p.show(wind);
      if(p.finished()){
        particles.remove(i);
      }
    }
    addParticles();
    update();
  }
  
  void addParticles(){
    for(int i = 0; i < numPerFrame; i++){
      particles.add(new Particle(x, y, particleSize, r, g, b));
    }
  }
  
  void update(){
    numPerFrame = round(map(mouseY, 0, height, 1, maxNumPerFrame));
    r = round(map(mouseY, 0, height, 150, 255));
    b = round(map(mouseY, 0, height, 150, 80));
    wind.x = map(mouseX, 0, width, -0.05, 0.05);
  }

}