class Boid{
  PVector pos, vel, acc;
  int radius = 8;
  int localityRadius = 50;
  float maxSteeringForce = 0.2;
  float maxSpeed = 4;
  
  Boid(float x, float y){
    pos = new PVector(x, y);
    vel = new PVector();
    acc = PVector.random2D();
    acc.mult(random(0.5, 1.5));
  }
  
  void performFlocking(ArrayList<Boid> all){
    acc.add(getAlignmentForce(all));
    acc.add(getCohesionForce(all));
    acc.add(getSeparationForce(all));
  }
  
  void update(){
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc.mult(0);
    wrapToScreen();
  }
  
  void wrapToScreen(){
    if(pos.x + radius < 0) pos.x = width + radius;
    else if(pos.x - radius > width) pos.x = 0 - radius;
    if(pos.y + radius < 0) pos.y = height + radius;
    else if(pos.y - radius > height) pos.y = 0 - radius;
  }
  
  void render(){
    noStroke();
    fill(255);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  PVector getAlignmentForce(ArrayList<Boid> others){
    PVector avgVel = new PVector(0, 0);
    int count = 0;
    for(Boid other: others){
      if(other != this){
        if(dist(other.pos.x, other.pos.y, pos.x, pos.y) < localityRadius){
          avgVel.add(other.vel);
          count ++;
        }
      }
    }
    if(count > 0){
      avgVel.div(count);
      avgVel.setMag(maxSpeed);
      avgVel.sub(vel);
      avgVel.limit(maxSteeringForce);
    }
    return avgVel;
  }
  
  PVector getCohesionForce(ArrayList<Boid> others){
    PVector avgPos = new PVector(0, 0);
    int count = 0;
    for(Boid other: others){
      if(other != this){
        if(dist(other.pos.x, other.pos.y, pos.x, pos.y) < localityRadius){
          avgPos.add(other.pos);
          count ++;
        }
      }
    }
    if(count > 0){
      avgPos.div(count);
      avgPos.sub(pos);
      avgPos.setMag(maxSpeed);
      avgPos.sub(vel);
      avgPos.limit(maxSteeringForce);
    }
    return avgPos;
  }
  
  PVector getSeparationForce(ArrayList<Boid> others){
    PVector separation = new PVector(0, 0);
    int count = 0;
    for(Boid other: others){
      if(other != this){
        float distance = dist(other.pos.x, other.pos.y, pos.x, pos.y);
        if(dist(other.pos.x, other.pos.y, pos.x, pos.y) < localityRadius){
          PVector diff = PVector.sub(pos, other.pos);
          diff.mult(1 / distance);
          separation.add(diff);
          count ++;
        }
      }
    }
    if(count > 0){
      separation.div(count);
      separation.setMag(maxSpeed);
      separation.sub(vel);
      separation.limit(maxSteeringForce);
    }
    return separation;
  }
}
