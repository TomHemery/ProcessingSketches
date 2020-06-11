float gravity = 800;
ArrayList<Ball> balls = new ArrayList<Ball>();
float drawStartMillis = 0.0f;
float drawEndMillis = 0.0f;

void setup(){
  fullScreen();
  ellipseMode(CENTER);
  background(0);
}

void draw(){
  drawStartMillis = millis();
  float deltaTime = (drawStartMillis - drawEndMillis) / 1000.0f;
  fill(0);
  rect(0, 0, 100, 50); 
  for(Ball b : balls){
    b.erase(0);
  }
  
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
  for(Ball b : balls){
    b.render();
  }
  
  
  text(frameRate, 10, 10);
  drawEndMillis = millis();
}

void mousePressed(){
  balls.add(new Ball(mouseX, mouseY, random(10, 40)));
}
