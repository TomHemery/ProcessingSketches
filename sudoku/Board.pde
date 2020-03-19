class Board{
  public static final int BOX_DIMS = 3;
  private static final int CELLS_PER_SIDE = BOX_DIMS * BOX_DIMS;
  private static final int CELL_ABS_W = 50;
  private Cell[] cells;
  private int x, y;
  private float maxProgress = 0f;
  private final int MAX_ATTEMPTS_PER_ROW = int(pow(3, BOX_DIMS));
  
  private int oneStepRowAttempts = 0;
  private int oneStepIndex = 0;
  
  Board(int x, int y){
    textSize(3 * float(CELL_ABS_W) / 5);
    this.x = x; this.y = y;
    cells = new Cell[CELLS_PER_SIDE * CELLS_PER_SIDE];
    for(int i = 0; i < cells.length; i++){
      int cellX = i % CELLS_PER_SIDE;
      int cellY = i / CELLS_PER_SIDE;
      cells[i] = new Cell(cellX, cellY, x + cellX * CELL_ABS_W, y + cellY * CELL_ABS_W, CELL_ABS_W); 
    }
  }
  
  void populate(){
    Cell c;
    int currRowAttempts = 0;
    boolean success;
    
    for(int i = 0; i < cells.length;){
      success = true;
      
      if(currRowAttempts > MAX_ATTEMPTS_PER_ROW){
        clearBoard();
        i = 0;
        currRowAttempts = 0;
      }
      
      c = cells[i];
      int startValue = floor(random(1, CELLS_PER_SIDE + 1));
      c.value = startValue;
      while(rowContains(c) || columnContains(c) || boxContains(c)){
        c.value = c.value < CELLS_PER_SIDE ? c.value + 1 : 1;
        if(c.value == startValue){
          i = restartRow(i);
          currRowAttempts++;
          success = false;
          break;
        }
      }
      if(success){ 
        i++;
        if(i % CELLS_PER_SIDE == 0)currRowAttempts = 0;
        //float progress = float(i) / cells.length;
        //if(maxProgress < progress){
        //  maxProgress = progress;
        //  println("Max progress: " + (maxProgress * 100) + "%");
        //} 
      }
    }
  }
  
  void printBoard(){
    for(int y = 0; y < CELLS_PER_SIDE; y++){
      print("[");
      for(int x = 0; x < CELLS_PER_SIDE; x ++){
        print(cells[y * CELLS_PER_SIDE + x].value);
        if(y < CELLS_PER_SIDE - 1) print(",");
      }
      println("]");
    }
    println();
  }
  
  void clearBoard(){
    for(Cell c : cells) c.value = -1;
    oneStepIndex = 0;
    oneStepRowAttempts = 0;
  }
  
  int restartRow(int index){
    index = (index / CELLS_PER_SIDE) * CELLS_PER_SIDE;
    for(int i = 0; i < CELLS_PER_SIDE; i++) cells[index + i].value = -1;
    return index;
  }
  
  boolean rowContains(Cell toCheck){
    int rowStart = toCheck.gridY * CELLS_PER_SIDE;
    for(int x = 0; x < CELLS_PER_SIDE; x++){
      int index = rowStart + x;
      if(cells[index] != toCheck){
        if(cells[index].value == toCheck.value){
          return true;
        }
      }
    }
    return false;
  }
  
  boolean columnContains(Cell toCheck){
    int colStart = toCheck.gridX;
    for(int y = 0; y < CELLS_PER_SIDE; y++){
      int index = y * CELLS_PER_SIDE + colStart;
      if(cells[index] != toCheck){
        if(cells[index].value == toCheck.value){
          return true;
        }
      }
    }
    return false;
  }
  
  boolean boxContains(Cell toCheck){
    int startX = (toCheck.gridX / BOX_DIMS) * BOX_DIMS;
    int startY = (toCheck.gridY / BOX_DIMS) * BOX_DIMS;
    int index;
    for(int y = startY; y < startY + BOX_DIMS; y++){
      for(int x = startX; x < startX + BOX_DIMS; x++){
        index = y * CELLS_PER_SIDE + x;
        if(cells[index] != toCheck){
          if(cells[index].value == toCheck.value){
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void populateOneStep(){
    if(oneStepIndex < cells.length){
      boolean success = true;
      Cell c;
      
      if(oneStepRowAttempts > MAX_ATTEMPTS_PER_ROW){
        clearBoard();
        oneStepIndex = 0;
        oneStepRowAttempts = 0;
      }
      
      c = cells[oneStepIndex];
      int startValue = floor(random(1, CELLS_PER_SIDE + 1));
      c.value = startValue;
      while(rowContains(c) || columnContains(c) || boxContains(c)){
        c.value = c.value < CELLS_PER_SIDE ? c.value + 1 : 1;
        if(c.value == startValue){
          oneStepIndex = restartRow(oneStepIndex);
          oneStepRowAttempts++;
          success = false;
          break;
        }
      }
      if(success){ 
        oneStepIndex++;
        if(oneStepIndex % CELLS_PER_SIDE == 0)oneStepRowAttempts = 0;
      }
    }
  }
  
  void render(){
    for(Cell c : cells){
      c.render();
    }
    pushMatrix();
    translate(x, y);
    strokeWeight(5);
    stroke(255);
    for(int x = 0; x <= BOX_DIMS; x++){
      line(x * BOX_DIMS * CELL_ABS_W, 0, x * BOX_DIMS * CELL_ABS_W, CELLS_PER_SIDE * CELL_ABS_W);
      line(0, x * BOX_DIMS * CELL_ABS_W, CELLS_PER_SIDE * CELL_ABS_W, x * BOX_DIMS * CELL_ABS_W);
    }
    popMatrix();
  }
}
