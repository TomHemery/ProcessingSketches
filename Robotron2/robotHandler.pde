class RobotHandler{
  
  ArrayList<Robot> robots = new ArrayList<Robot>();
  
  int levels[] = {10, 20};
  int currentLevel = 0;
  float minDistFromPlayer = height/4;
  
  public RobotHandler(){
    genRobots();
  }
  
  void genRobots(){
    int amount = levels[levels.length-1];
    Robot temp;
    PVector distance;
    if(currentLevel < levels.length){
       amount = levels[currentLevel];
    }
    for(int i = 0; i < amount; i++){
      temp = new Robot(random(width - Robot.baseSize), random(height - Robot.baseSize));
      distance = PVector.sub(player.pos, temp.pos);
      if(distance.mag()<minDistFromPlayer){
        distance.setMag(random(minDistFromPlayer, height));
        temp.pos.add(distance);
      }
      robots.add(temp);
    }
  }
  
  void show(){
    if(robots.size() > 0){
      Robot t;
      for(int i = robots.size()-1; i >= 0; i--){
        t = robots.get(i);
        t.show();
        if(t.collideWithPlayer()){
          reset();
        }
        if(bulletHandler.bullets.size() > 0){
          if(t.collideWithBullet()){
            robots.remove(i);
          }
        }   
      }
    }
    else{
      currentLevel++;
      genRobots();
    }
    fill(255);
    text("Level: " + (currentLevel + 1), 10, 80);
  }
}