void keep_on_screen(Ball off, Ball on){
  if(off.loc.x - off.r < 0 || off.loc.x + off.r > width || off.loc.y + off.r > height){
            PVector trans = new PVector(off.loc.x, off.loc.y);
            if (off.loc.x - off.r < 0){
              off.loc.x = off.r;}
            else if (off.loc.x + off.r > width){
              off.loc.x = width - off.r;}
            else {
              off.loc.y = height - off.r;}
            
            trans.set(PVector.sub(off.loc, trans));
            on.loc.add(trans);
  }
}

// a lot of physics
void collide(ArrayList<Ball> _B){
  PVector d = new PVector();
  Ball b_i;
  Ball b_j;
  for(int i = 0; i < _B.size(); i++){
    for(int j = 0; j < _B.size(); j++){
      if(i != j){
        b_j = _B.get(j);
        b_i = _B.get(i);
        d.set(PVector.sub(b_i.loc, b_j.loc));
        if(d.mag() < 2 * b_i.r){
          d.setMag((float(2 * b_i.r) - d.mag()) / 2);
          b_i.loc.add(d);
          b_j.loc.add(d.mult(-1));
          
          //catch anything off the screen
          //ball j
          keep_on_screen(b_j, b_i);
          //ball i
          keep_on_screen(b_i, b_j);
          
          PVector i_vel = new PVector(b_i.vel.x, b_i.vel.y);
          b_i.vel.set(PVector.add(b_j.vel.mult(0.9), b_i.vel.mult(0.05)));
          b_j.vel.set(PVector.add(i_vel.mult(0.9), b_j.vel.mult(0.05)));
          b_i.loc.add(b_i.vel);
          b_j.loc.add(b_j.vel);
        }
      }
    }
  }
}

public class Ball{
  int max_hist = 25;
  int r = 10;
  PVector vel = new PVector();
  PVector acc = new PVector(0, 0);
  PVector loc = new PVector(0, 0);
  color col = color(floor(random(100, 256)), floor(random(100, 256)), floor(random(100, 256)));
  ArrayList<PVector> history = new ArrayList<PVector>();
  
  public Ball(float _x,float _y, PVector v){
    loc.set(_x, _y);
    vel.set(v.x, v.y);
  }
  
  void show(){
    noStroke();
    fill(col);
    ellipse(loc.x, loc.y, r, r);
  }
  
  void update(){
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);
  }
  
  void bounce(){
    if (loc.y + r >= height){
      if(vel.y > 0){
        vel.y = vel.y * (-0.8);
        if (vel.y > -2.5){
          vel.y = 0;
        }
      }
      vel.x = vel.x * 0.99;
    }
    if (loc.x + r > width && this.vel.x > 0 ||
        loc.x - r < 0 && this.vel.x < 0){
      vel.x = vel.x * -1;
    }
  }
  
  void apply_force(PVector f){
    acc.add(f);
  }
  
  void apply_gravity(PVector g){
    if (loc.y + r < height){
      acc.add(g);
    }
  } 
  void on_screen(){
    if (loc.y + r > height){
      loc.y = height - r;
    }
    if (loc.x + r > width){
      loc.x = width - r;
    }
    else if (loc.x - r < 0){
      loc.x = r;
    }
  }
  void process(){
    show();
    apply_gravity(gravity);
    update();
    bounce();
    on_screen();
  }
}