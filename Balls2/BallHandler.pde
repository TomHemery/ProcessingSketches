class BallHandler{
  ArrayList<Ball> balls;
  int prevUpdateTime = 0;
  
  BallHandler(){
    balls = new ArrayList();
  }
  
  void update(){
    float secondsPassed = (float)(millis() - prevUpdateTime) / 1000;
    for(Ball b : balls){ 
      b.addForce(GRAVITY);
      b.update(secondsPassed);
      b.offScreen();
    }
    for(Ball b: balls){
      for(Ball _b: balls){
        if(b != _b){
          b.collide(_b);
        }
      }
    }
    
    prevUpdateTime = millis();
  }
  
  void render(){
    for(Ball b : balls) b.render();
  }
  
  void addBall(float x, float y, PVector vel){
    balls.add(new Ball(x, y, vel));
  }
}