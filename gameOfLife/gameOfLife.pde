Cell grid[][];
int resolution = 10;
int startValues[] = {0, 255};
boolean go = false;
boolean showLine = false;
int min = 10;

void setup(){
  fullScreen();
  colorMode(HSB);
  textSize(32);
  reset();
  noStroke();    
}

void reset(){
  grid = new Cell[width/resolution][height/resolution];
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[i].length; j++){
        grid[i][j] = new Cell(0);
    }
  }
}

void draw(){
  background(0);
  if(mousePressed && mouseButton == LEFT){
    grid[mouseX / resolution][mouseY / resolution].value = 255;
  }
  else if(mousePressed){
    grid[mouseX / resolution][mouseY / resolution].value = 0;
  }
  for(int i = 0; i < grid.length; i++){
    for(int j = 0; j < grid[i].length; j++){
      if(grid[i][j].value > min)grid[i][j].show(i, j);
      if(showLine){grid[i][j].showLines(i, j);}
      if(go)grid[i][j].setNext(grid, i, j);
    }
  }
  if(go){
    for(Cell[] c : grid){
      for(Cell cell: c){
        cell.setValue();
      }
    }
  }
}

void keyPressed(){
  if(key == ENTER){
    go = true;
  }
  if(key == DELETE){
    go = false; 
    reset();
  }
  if(key == 'l'){
    showLine = !showLine;
  }
}