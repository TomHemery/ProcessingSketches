int diameter = 200;
int numCircles = 0;
float hue = 0;
int offset = 100;

void setup(){
  size(1000, 1000);
  background(0);
  colorMode(HSB);
  textSize(32);
}

void draw(){
  if(mousePressed){numCircles++; updateCircles();}
}

void updateCircles(){
  background(0);
  //text(numCircles, 10, 40);
  //translate(width/2, height/2);
  noStroke();
  for(int i = 0; i < numCircles; i++){
    rotate((2*PI) / numCircles);
    stroke(hue, 255, 255);
    strokeWeight(2);
    //fill(hue, 255, 255, 100);
    noFill();
    translate(width/2 + offset, height / 2);
    ellipse(offset, 0, diameter, diameter);
    translate(width/2 - offset, height / 2);
    ellipse(offset, 0, diameter, diameter);
    hue+= 255 / (float)numCircles;
    if(hue>255){hue = 0;}
  }
}

void keyPressed(){
  if(key == 's'){
    save("" + frameCount + ".png");
  }
}