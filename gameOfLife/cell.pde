class Cell{

  int value;
  int nextValue;
  int threshold = 150;
  int growth = 5;
  
  public Cell(int val){
    this.value = val; 
  }
  
  void show(int x, int y){
    fill(value, 200, 255, value);
    rect(x * resolution, y * resolution, resolution, resolution);
  }
  
  void showLines(int x, int y){
    noFill();
    stroke(0, 0, 50);
    rect(x * resolution, y * resolution, resolution, resolution);
    noStroke();
  }
  
  int getValue(){
    if(value > threshold){
      return 1;
    }
    return 0;
  }
  
  void setValue(){
    this.value = nextValue;
  }
  
  void setNext(Cell grid[][], int x, int y){
    int count = 0;
    for(int i = -1; i <= 1; i++){
      for(int j = -1; j <= 1; j++){
        if(x + i >= 0 && x + i < grid.length && y + j >= 0 && y + j < grid[0].length){
          count += grid[x + i][y + j].getValue();
        }
      }
    }
    count -= this.getValue();
    if(value == 1){fill(0);}
    else{fill(255);}
    if(count == 3 && getValue() == 0){
      nextValue = threshold + growth;
    }
    else if(count < 2 || count > 3){
      nextValue = value-growth;
    }
    else{
      nextValue = value;
    }
  }

}