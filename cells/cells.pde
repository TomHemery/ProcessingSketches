Cell grid[][];
int size = 4;

void setup(){
  size(800, 800, P2D);
  textSize(32);
  resetCells();
}

void draw(){
  background(0);
  if(mousePressed){setCell(mouseX, mouseY);}
  setCell(width/2, height/2);
  showCells();
}

void resetCells(){
  grid = new Cell[width/size][height/size];
  for(int i = 0; i < width/size; i++){
    for(int j = 0; j < height/size; j++){
      grid[i][j] = new Cell(i,j,size);
    }
  }
}

void showCells(){
  for(Cell[] row: grid){
    for(Cell cell: row){
      if(cell.isFilled()){cell.show(); cell.spread();}
    }
  }
  for(Cell[] row: grid){
    for(Cell cell: row){
      cell.update();
    }
  }
}

void setCell(int x, int y){
  grid[constrain(x, 0, width - 1)/size][constrain(y, 0, height - 1)/size].fillIn();
}