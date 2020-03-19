color rand_col(){
  int b = floor(random(200, 256));
  int g = floor(random(0, 150));
  int r = floor(random(120, 200));
  return color(r, g, b);
}

public class Particle{
  PVector loc = new PVector();
  PVector vel;
  PVector acc = new PVector();
  float min_dist = 50;
  boolean destroyed = false;
  float G = 1500;
  color col = rand_col();
  
  public Particle(int _x, int _y){
    loc.x = _x;
    loc.y = _y;
    vel = PVector.random2D();
  }
  
  void show(){
    stroke(col);
    strokeWeight(2);
    point(loc.x, loc.y);
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
  
  
  void attract(PVector target){
    PVector f = PVector.sub(target, this.loc);
    float d_2 = f.magSq();
    if (f.mag() < min_dist){
      f.mult(-1);
    }
    f.setMag(G / d_2);
    this.acc.add(f);
  }
  
}