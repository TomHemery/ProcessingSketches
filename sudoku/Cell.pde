class Cell{

  int gridX, gridY, absX, absY, absW;
  int value = -1;
  
  Cell(int gridX, int gridY, int absX, int absY, int absW){
    this.gridX = gridX;
    this.gridY = gridY;
    this.absX = absX;
    this.absY = absY;
    this.absW = absW;
  }
  
  void render(){
    stroke(255);
    strokeWeight(2);
    noFill();
    rect(absX, absY, absW, absW);
    if(value > 0){
      text(value, absX + absW / 2, absY + absW / 2);
    }
  }
  
}
