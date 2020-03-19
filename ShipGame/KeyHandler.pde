void keyPressed(){
  if(key == 'd'){
    s.setRotation(s.rotationSpeed);
  }
  else if(key == 'a'){
    s.setRotation(-s.rotationSpeed);
  }
  else if(key == 's'){
    s.brake();
  }
  else if(key == ' '){
    s.shoot(true);
  }
  else if(key == 'w'){
    s.boost(true);
  }
}

void keyReleased(){
  if(s.rotating && (key == 'a' || key == 'd')){
    s.setRotation(0);
  }
  else if(s.breaking && key == 's'){
    s.unBrake();
  }
  else if(s.shooting && key == ' '){
    s.shoot(false);
  }
  else if(s.boosting && key == 'w'){
    s.boost(false);
  }
}