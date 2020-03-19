PImage track;
LineFollower follower;
ArrayList<Behaviour> allBehaviours = new ArrayList();

void setup(){
  size(1024, 1024);
  
  track = loadImage("CircuitVeryHard.png");
  follower = new LineFollower();
  
  rectMode(CENTER);
  textAlign(LEFT, TOP);
  textSize(20);
}

void draw(){
  image(track, 0, 0);
  Update(); 
  follower.Display();
}

void Update(){
  for(Behaviour b : allBehaviours)
    b.Update();
  follower.Update();
}
