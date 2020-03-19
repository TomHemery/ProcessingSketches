public static final char keyMoveUp = 'w';
public static final char keyMoveDown = 's';
public static final char keyMoveLeft = 'a';
public static final char keyMoveRight = 'd';

void keyPressed(){
  
  switch(key){
    case keyMoveUp:
      player.setVelocity(0, -player.speed);
      break;
    case keyMoveDown:
      player.setVelocity(0, player.speed);
      break;
    case keyMoveLeft:
      player.setVelocity(-player.speed, 0);
      break;
    case keyMoveRight:
      player.setVelocity(player.speed, 0);
      break;
  }
  
}

void keyReleased(){

}
