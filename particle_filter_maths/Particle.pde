class Particle{

  PVector pos;
  float weight;
  float normalizedWeight;
  
  float speed = 2;
  
  Particle(){
    pos = new PVector();
  }
  
  PVector getWeightedPosition(){
    return PVector.mult(pos, weight);
  }
  
  PVector getNormalizedWeightedPosition(){
    return PVector.mult(pos, normalizedWeight);
  }
  
  String toString(){
    return "Position: " + pos + ", weight: " + weight + ", weighted pos: " + getWeightedPosition();
  }
  
  void update(){
    pos.x += random(-speed, speed);
    pos.y += random(-speed, speed);
  }
  
}
