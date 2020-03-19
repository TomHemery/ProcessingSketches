class ParticleFilter{
  Particle [] particles;
  
  float epsilon = 300.0f;
  
  PVector avgPos = new PVector();
  PVector bestPos = new PVector();
  PVector robustPos = new PVector();
  
  ParticleFilter(int initialPopulationSize){
    particles = new Particle[initialPopulationSize];
    for(int i = 0; i < particles.length; i++){
      Particle p = new Particle();
      p.pos.set(random(10, width-10), random(10, height-10));
      p.weight = random(0,1);
      particles[i] = p;
    }
    //println("Un normalized population: ");
    //printAllParticles();
    //println();
    
    //normalizeWeights();
    
    //println("Normalized population: ");
    //printAllParticles();
    //println();
    
    //println("Weighted average position: ");
    //println(getWeightedAvg());
    //println("Best particle: ");
    //println(getBest());
    //println("Robust mean positon given epsilon " + epsilon + ": ");
    //println(getRobustMean());
  }
  
  void render(){
    strokeWeight(15);
    stroke(255);
    for(Particle p : particles) point(p.pos.x, p.pos.y);
    strokeWeight(10);
    stroke(255, 0, 0);
    point(avgPos.x, avgPos.y);
    stroke(0, 255, 0);
    point(bestPos.x, bestPos.y);
    stroke(0, 0, 255);
    point(robustPos.x, robustPos.y);
  }
  
  void randomize(){
    for(int i = 0; i < particles.length; i++){
      Particle p = particles[i];
      p.pos.set(random(10, width-10), random(10, height-10));
      p.weight = random(0,1);
      particles[i] = p;
    }
  }
  
  void normalizeWeights(){
    float totalWeight = 0;
    for(Particle p : particles) totalWeight += p.weight;
    for(Particle p : particles) p.normalizedWeight = p.weight / totalWeight;
  }
  
  void normalizeWeights(Particle[] parts){
    float totalWeight = 0;
    for(Particle p : parts) totalWeight += p.weight;
    for(Particle p : parts) p.normalizedWeight = p.weight / totalWeight;
  }
  
  void normalizeWeights(ArrayList<Particle> parts){
    float totalWeight = 0;
    for(Particle p : parts) totalWeight += p.weight;
    for(Particle p : parts) p.normalizedWeight = p.weight / totalWeight;
  }
  
  void printAllParticles(){
    for(Particle p : particles) println(p);
  }
  
  PVector getWeightedAvg(){
    PVector result = new PVector();
    for(Particle p : particles) result.add(PVector.mult(p.pos, p.normalizedWeight));
    return result;
  }
  
  PVector getWeightedAvg(ArrayList<Particle> parts){
    PVector result = new PVector();
    for(Particle p : parts) result.add(PVector.mult(p.pos, p.normalizedWeight));
    return result;
  }
  
  PVector getBest(){
    PVector best = null;
    float maxWeight = -1;
    for(Particle p : particles) if(p.weight > maxWeight){maxWeight = p.weight; best = p.pos;}
    return best;
  }
  
  PVector getRobustMean(){
    PVector best = getBest();
    ArrayList<Particle>suitableParticles = new ArrayList();
    for(Particle p : particles) if(PVector.dist(p.pos, best) < epsilon) suitableParticles.add(p);
    normalizeWeights(suitableParticles);
    return getWeightedAvg(suitableParticles);
  }
  
  void update(){
    for(Particle p : particles) p.update();
    normalizeWeights(particles);
    avgPos = getWeightedAvg();
    bestPos = getBest();
    robustPos = getRobustMean();
  }
}
