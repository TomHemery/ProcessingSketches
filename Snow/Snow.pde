FlakeHandler flakeHandler; 
PVector gravity = new PVector(0, 0.05);
PVector wind = new PVector(0.01, 0);

PImage snowSpriteSheet;
ArrayList<PImage> snowSprites;
int spriteSize = 32;

void setup(){
  genSprites();
  fullScreen(P2D);
  flakeHandler = new FlakeHandler();
}

void genSprites(){
  snowSpriteSheet = loadImage("SnowSprites.png");  
  snowSprites = new ArrayList<PImage>();
  for(int x = 0; x < snowSpriteSheet.width; x += spriteSize){
    for(int y = 0; y < snowSpriteSheet.height; y += spriteSize){
      snowSprites.add(snowSpriteSheet.get(x, y, spriteSize, spriteSize));
    }
  }
}

void draw(){
  background(0);
  //setWind();
  flakeHandler.show();
}

void setWind(){
  wind.x = map(mouseX, 0, width, -1, 1);
}