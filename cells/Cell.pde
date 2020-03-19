class Cell{
  
  int x, y, size;
  int r = 200;
  int g = 200;
  int b = 255;
  int alpha = 0;
  int nextAlpha = 0;
  int maxDecay = 20;
  int spreadDiameter = 1;
  
  public Cell(int x, int y, int size){
    this.x = x; this.y = y;
    this.size = size;
  }
  
  void fillIn(){
    this.alpha = 255;
  }
  
  void show(){
    fill(r, g, b, alpha);
    noStroke();
    rect(x * size, y * size, size, size);
  }
  
  boolean isFilled(){
    return this.alpha > 0;
  }
  
  void setNext(int next){
    if(next > this.nextAlpha){
      this.nextAlpha = next;
    }
  }
  
  void update(){
    this.alpha = nextAlpha;
    this.nextAlpha = 0;
  }
  
  void spread(){
    for(int i = -spreadDiameter; i <= spreadDiameter; i++){
      for(int j = -spreadDiameter; j <= spreadDiameter; j++){
        if(x + i >= 0 && x + i < grid.length && y + j >= 0 && y + j < grid[0].length){
          if(!(i == j && j == 0)){grid[x + i][y + j].setNext(alpha - floor(random(maxDecay / 4, maxDecay + 1)));}
        }
      }
    }
  }
  
}