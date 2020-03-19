PVector [] seeds;
int numberOfSeeds = 5;
PVector pos;
int radius = 600;
long numPoints = 50000000;
int prev = -1;
color pointColour = color(148,0,211, 10);

PGraphics pg;
int imageWidth = 3840;
int imageHeight = 1080;

void setup(){
  seeds = new PVector[numberOfSeeds];
  
  for(int i = 0; i < seeds.length; i++){
    seeds[i] = new PVector(radius, 0);
    seeds[i].rotate(i * PI * 2 / seeds.length - PI / 2);
    seeds[i].x += imageWidth/3;
    seeds[i].y += imageHeight/2;
  }
  
  pos = new PVector(random(imageWidth), random(imageHeight));
  //for(PVector seed: seeds) point(seed.x, seed.y);
  
  pg = createGraphics(imageWidth, imageHeight); 
  populateGraphics();
  pg.save("GeneratedImage.png");
  noLoop();
  exit();
}

void populateGraphics(){
  println("populating graphics");
  pg.beginDraw();
    pg.stroke(pointColour);
    pg.strokeWeight(1);
    pg.background(0);
    for(long i = 0; i < numPoints; i++){
      int index = floor(random(seeds.length));
      while(index == prev){
        index = floor(random(seeds.length));
      }
      index = index + 1 >= seeds.length ? 0 : index + 1;
      prev = index;
      pos.x = (pos.x + seeds[index].x) / 2;
      pos.y = (pos.y + seeds[index].y) / 2;
      pg.point(pos.x, pos.y);
      if(i % 500000 == 0) println(((float)i / numPoints * 100) + "%");
    }
  pg.endDraw();
  println("populated graphics");
}

void keyPressed(){
  if(key == 'r'){
    background(0);
  }
}