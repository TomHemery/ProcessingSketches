PImage track;
LineFollower follower;

void setup(){
  size(1024, 1024);
  
  track = loadImage("CircuitVeryHard.png");
  follower = new LineFollower();
  
  rectMode(CENTER);
  textAlign(LEFT, TOP);
  textSize(20);
}

void draw(){
  Update();  
  image(track, 0, 0);
  follower.Display();
}

void Update(){
  follower.Update();
}
