class ParticleHandler{
  ArrayList<EngineParticle>engineParticles = new ArrayList<EngineParticle>();
  ArrayList<BulletParticle>bulletParticles = new ArrayList<BulletParticle>();
  MeteorHandler meteors;
  
  public ParticleHandler(MeteorHandler _m){meteors = _m; println(_m);}

  void addEngineParticle(float x, float y, float velX, float velY){
    engineParticles.add(new EngineParticle(x, y, velX, velY));
  }
  
  void addBulletParticle(float x, float y, float angle, float shipVel){
    bulletParticles.add(new BulletParticle(x, y, angle, shipVel));
  }
  
  void show(){
    stroke(255);
    EngineParticle p;
    for(int i = engineParticles.size() -1; i >= 0; i--){
      p = engineParticles.get(i);
      p.show();
      if(p.finished()){
        engineParticles.remove(i);
      }
    }
    
    BulletParticle b;
    for(int i = bulletParticles.size() -1; i >= 0; i--){
      b = bulletParticles.get(i);
      b.show();
      for(Meteor m: meteors.meteors)
      {
        b.collide(m);
      }
      if(b.finished()){
        bulletParticles.remove(i);
      }
    }
  }
  
}