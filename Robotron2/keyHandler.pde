final char NOTHING_PRESSED = ' ';

void keyPressed(){
  if(key == 'w' || key == 'a' || key == 's' || key == 'd'){
    player.setDirection(key);
  }
  else if(key == CODED){
    if(keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT){
      player.setShoot(keyCode);
    }
  }
}

void keyReleased(){
  if(key == 'w' || key == 'a' || key == 's' || key == 'd'){
    player.unSetDirection(key);
  }
  else if(key == CODED){
    if(keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT){
      player.unSetShoot(keyCode);
    }
  }
}