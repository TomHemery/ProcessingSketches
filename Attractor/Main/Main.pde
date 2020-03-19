ArrayList<PVector> attractors = new ArrayList<PVector>();
ArrayList<Particle> particles = new ArrayList<Particle>();
int[] spawn = {0, 0};
int target_fr = 60;
boolean show_info = true;
boolean show_bg = true;

void setup(){
  fullScreen(P2D);
  spawn[0] = width / 2;
  spawn[1] = height / 2;
  textSize(32);
  attractors.add(new PVector(width / 4    , height     / 4));
  attractors.add(new PVector(width / 4    , 3 * height / 4));
  attractors.add(new PVector(3 * width / 4, height     / 4));
  attractors.add(new PVector(3 * width / 4, 3 * height / 4));
}

void draw(){
  if(show_bg){background(0);}
  for(PVector a: attractors){
    if (show_info){
      stroke(0, 255, 0);
      strokeWeight(5);
      point(a.x, a.y);
    }
    for(int j = 0; j < particles.size(); j++){
      particles.get(j).attract(a);
    } 
  }
  
  if(show_info){
    fill(255);
    text("" + particles.size(), 10, 30); 
    text("" + frameRate, 10, 60);
    stroke(255, 0, 0);
    strokeWeight(4);
    point(spawn[0], spawn[1]);
  }
  if (frameRate >= target_fr && attractors.size() > 0){
    for(int i = 0; i < 40; i++){
      particles.add(new Particle(spawn[0], spawn[1]));
    }
  }
  
  for(int i = particles.size() - 1; i >= 0; i--){
    Particle p = particles.get(i);
    p.update();
    p.show();
    if(p.destroyed){
      particles.remove(i);
    }
  }
}

void mousePressed(){
  attractors.add(new PVector(mouseX, mouseY));
}

void keyPressed(){
  if(key == DELETE){
    attractors = new ArrayList<PVector>();
    particles = new ArrayList<Particle>();
    background(0);
  }
  else if(key == 'x'){
    if (show_info){show_info = false;}
    else{show_info = true;}
  }
  else if(key == 'b'){
    if (show_bg){show_bg = false;}
    else{show_bg = true;}
  }
}