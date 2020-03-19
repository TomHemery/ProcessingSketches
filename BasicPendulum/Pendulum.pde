class Pendulum{

  float len;
  PVector anchor;
  PVector pos;
  
  float angle = PI*1.2;
  float angularVel = 0;
  float angularAcc;
  float dampening = 0.995;
  
  Pendulum child = null;
  Pendulum parent = null;
  
  Pendulum(float _x, float _y, float _len, float _angle, int chain, Pendulum _parent){
    anchor = new PVector(_x, _y);
    len = _len;
    parent = _parent;
    angle = _angle;
    pos = new PVector(len * sin(_angle), len * cos(_angle));
    if(chain > 0){
      child = new Pendulum(pos.x, pos.y, _len, _angle + 0.4, chain - 1, this);
    }
  }
  
  void Display(){
    strokeWeight(6);
    stroke(0);
    pushMatrix();
    if(parent == null)
      translate(anchor.x, anchor.y);
    else
      translate(parent.pos.x, parent.pos.y);
    point(0, 0);
    strokeWeight(2);
    line(0, 0, pos.x, pos.y);
    stroke(255, 0, 0);
    strokeWeight(10);
    point(pos.x, pos.y);
    if(child != null) child.Display();
    popMatrix();
  }
  
  void Update(){
    angle = PVector.angleBetween(vertical, pos);
    if(pos.x < 0) angle = -angle;
    angularAcc = (-gravity / len) * sin(angle);
    
    angularVel += angularAcc;
    angularVel *= dampening;
    angle += angularVel;
    
    pos.set(len * sin(angle), len * cos(angle));
    
    if(child != null)child.Update();
    
  }
}
