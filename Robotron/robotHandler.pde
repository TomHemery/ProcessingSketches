class RobotHandler{
  
  ArrayList<Robot> robots = new ArrayList<Robot>();
  
  public RobotHandler(){
    for(int i = 0; i < 10; i++){
      robots.add(new Robot(random(width), random(height)));
    }
  }
  
  void show(){
    for(Robot t: robots){
      t.show();
      if(bulletHandler.bullets.size() > 0){
        if(t.collide()){
          t.update();
        }
      }   
    }
  }
}