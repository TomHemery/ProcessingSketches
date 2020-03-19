class Coin{

  int radius = 5;
  int fillColour = color(212,175,55);
  int strokeColour = color(232, 205, 85);
  int x, y;
  
  Coin(int centerX, int centerY){
    x = centerX;
    y = centerY;
  }
  
  void render(){
    stroke(strokeColour);
    strokeWeight(1);
    fill(fillColour);
    ellipse(x, y, radius, radius);
  }
  
}
