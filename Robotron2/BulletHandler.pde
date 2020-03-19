class BulletHandler{

  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  
  void addBullet(float x, float y, PVector pos){
    bullets.add(new Bullet(x, y, new PVector(pos.x, pos.y)));
  }
  
  void show(){
    Bullet b;
    for(int i = bullets.size()-1; i >= 0; i--){
      b = bullets.get(i);
      b.show();
      if(b.finished){
        bullets.remove(i);
      }
    }
  }

}