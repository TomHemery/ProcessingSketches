PVector [] seeds;
int numberOfSeeds = 5;
PVector pos;
int radius = 5000;
int numPointsPerFrame = 50000;
int prev = -1;
color pointColour = color(240, 30, 20, 50);

void setup(){
  size(3840, 1080);
  background(0);
  stroke(255, 100);
  strokeWeight(1);
  seeds = new PVector[numberOfSeeds];
  
  for(int i = 0; i < seeds.length; i++){
    seeds[i] = new PVector(radius, 0);
    seeds[i].rotate(i * PI * 2 / seeds.length - PI / 2);
    seeds[i].x += width/2;
    seeds[i].y += height/2;
  }
  
  pos = new PVector(random(width), random(height));
  //for(PVector seed: seeds) point(seed.x, seed.y);
}

void draw(){
  fill(0);
  noStroke();
  rect(0, 0, 50, 50);
  fill(255);
  //text(frameRate, 5, 10);
  stroke(pointColour);
  for(int i = 0; i < numPointsPerFrame; i++){
    int index = floor(random(seeds.length));
    while(index == prev){
      index = floor(random(seeds.length));
    }
    index = index + 1 >= seeds.length ? 0 : index + 1;
    prev = index;
    pos.x = (pos.x + seeds[index].x) / 2;
    pos.y = (pos.y + seeds[index].y) / 2;
    point(pos.x, pos.y);
  }
}

void keyPressed(){
  if(key == 'r'){
    background(0);
  }
}
