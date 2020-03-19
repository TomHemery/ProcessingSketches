class BoidManager{
  ArrayList<Boid> flock;
  int numBoids = 100;
  
  BoidManager(){
    flock = new ArrayList();
    for(int i = 0; i < numBoids; i++){
      flock.add(new Boid(random(width), random(height)));
    }
  }
  
  void update(){
    for(Boid b: flock){
      b.performFlocking(flock);
      b.update();
    }
  }
  
  void render(){
    for(Boid b: flock){
      b.render();
    }
  }
}
