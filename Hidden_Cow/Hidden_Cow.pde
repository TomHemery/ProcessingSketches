import processing.sound.*;

Cow c;
int def_r = 60;
int num_found = 0;
PImage c_img;
int c_timer = 40;
int c_t = 0;
PVector c_loc;
SoundFile moo;

void setup(){
  c_img = loadImage("cow.jpg");
  fullScreen();
  textSize(32);
  moo = new SoundFile(this, "moo.mp3");
  c = new Cow(floor(random(width)), floor(random(height)), new SoundFile(this, "cow.mp3"), def_r);
}

void draw(){
  background(150);
  text("Cows found: " + num_found, 10, 30);
  if (!c.found){
    c.update(new PVector(mouseX, mouseY));
    c.show();
  }
  else{
    num_found++;
    moo.play();
    c = new Cow(floor(random(width)), floor(random(height)), new SoundFile(this, "cow.mp3"), def_r);
    c_t = c_timer;
    c_loc = new PVector(mouseX, mouseY);
  }
  
  if(c_t > 0){
    c_t--;
    image(c_img, mouseX - c_img.width / 2, mouseY - c_img.height / 2);
  }
  
}

void mousePressed(){
  c.click(new PVector(mouseX, mouseY));
}