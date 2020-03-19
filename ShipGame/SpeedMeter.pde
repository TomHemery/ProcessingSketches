class SpeedMeter{

  Ship ship;
  float maxSpeed; 
  int radius = 60;
  int padding = 10;
  float angle;
  float startAngle = PI/2 + PI/5;
  float endAngle = 2*PI + PI/2 - PI/5;
  PVector needle;
  
  public SpeedMeter(float _maxSpeed, Ship _ship){
    this.maxSpeed = _maxSpeed;
    this.ship = _ship;
  }
  
  void show(){
    angle = map(ship.vel.mag(), 0, ship.boostSpeed, startAngle, endAngle);
    needle = PVector.fromAngle(angle).mult(20);
    noFill();
    stroke(255, 0, 0);
    strokeWeight(6);
    pushMatrix();
    translate(s.pos.x - width / 2, s.pos.y - height / 2);
    arc(radius + padding, radius + padding, 
            radius*2, radius*2, startAngle, angle);
    line(radius + padding, radius + padding, radius + padding + needle.x, radius + padding + needle.y);
    text("-", radius - 2 * padding, radius + 2 * padding + radius);
    text("+", radius + 2 * padding, radius + 2 * padding + radius);
    popMatrix();
  }

}