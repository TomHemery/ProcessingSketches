float gravity = 400;
ArrayList<Ball> balls = new ArrayList<Ball>();
float drawStartMillis = 0.0f;
float drawEndMillis = 0.0f;

void setup(){
  fullScreen();
  ellipseMode(CENTER);
}

void draw(){
  drawStartMillis = millis();
  float deltaTime = (drawStartMillis - drawEndMillis) / 1000.0f;
  
  //physics
  for(Ball b : balls){
    b.update(deltaTime);
  }
  for(int i = 0; i < balls.size(); i++){
    for(int j = i + 1; j < balls.size(); j++){
      balls.get(i).resolveCollision(balls.get(j));
    }
  }
  for(Ball b: balls){
    b.bounce();
  }
  
  //rendering
  background(0);
  for(Ball b : balls){
    b.render();
  }
  drawEndMillis = millis();
}

void mousePressed(){
  balls.add(new Ball(mouseX, mouseY, 10));
}
