class MeteorHandler{

  ArrayList<Meteor> meteors = new ArrayList<Meteor>();
  int maxMeteors = 50;
  Ship s;
  int spawnTimer = 0;
  int spawnTime = 10;
  PVector spawnPoint;
  
  public MeteorHandler(Ship _s){
    this.s = _s;
  }
  
  void update(){
    if(meteors.size() < maxMeteors && spawnTimer >= spawnTime){
      spawnPoint = PVector.random2D();
      spawnPoint.mult(5 * width/4);
      spawnPoint.add(s.pos);
      meteors.add(new Meteor(spawnPoint.x, spawnPoint.y, s));
      spawnTimer = -1;
    }
    spawnTimer++;
  }
  
  void show(){
    Meteor m;
    update();
    for(int i = meteors.size() - 1; i >= 0; i--){
      m = meteors.get(i);
      m.show();
      if(m.destroyed){meteors.remove(i);}
    }    
  }

}