class Grid{
  
  static final int GRID_DIMS = 27;
  int current = 0;
  Cell [] cells = new Cell[GRID_DIMS * GRID_DIMS];
  String saveFile = "layout.txt";
  
  Grid(){
    for(int y = 0; y < GRID_DIMS; y++){
      for(int x = 0; x < GRID_DIMS; x++){
        cells[y * GRID_DIMS + x] = new Cell(x, y);
      }
    }
  }
  
  void render(){
    for(Cell c : cells) c.render();
  }
  
  void loadFromFile(){
    String [] file = loadStrings(saveFile);
    Cell current;
    for(int y = 0; y < file.length; y++){
      for(int x = 0; x < file[0].length(); x++){
        char value = file[y].charAt(x);
        current = cells[y * GRID_DIMS + x];
        current.value = value;
        switch(value){
          case Cell.COIN_VALUE:
            current.addCoin();
            break;
          case Cell.PLAYER_SPAWN_VALUE:
            player = new Player(x * Cell.ABS_DIMS + Cell.ABS_DIMS / 2, y * Cell.ABS_DIMS + Cell.ABS_DIMS / 2);
            break;
          case Cell.ENEMY_SPAWN_VALUE:
            enemies.add(new Enemy(x * Cell.ABS_DIMS + Cell.ABS_DIMS / 2, y * Cell.ABS_DIMS + Cell.ABS_DIMS / 2));
        }
      }
    }
    
    Cell c;
    for(int y = 0; y < GRID_DIMS; y++){
      for(int x = 0; x < GRID_DIMS; x++){
        c = cells[y * GRID_DIMS + x];
        if(c.value != Cell.WALL_VALUE){
          c.isIntersection = checkIsIntersection(x, y);
          c.isDeadEnd = checkIsDeadEnd(x, y);
        }
      }
    }
  }
  
  boolean checkIsIntersection(int x, int y){
    return checkNumPaths(x, y) >= 3;
  }
  
  boolean checkIsDeadEnd(int x, int y){
    return checkNumPaths(x, y) == 1;
  }
  
  int checkNumPaths(int x, int y){
    int numPaths = 0;
    if(x > 0){
      if(cells[y * GRID_DIMS + (x - 1)].value != Cell.WALL_VALUE){
        numPaths++;
      }
    } 
    if(x < GRID_DIMS - 1){
      if(cells[y * GRID_DIMS + (x + 1)].value != Cell.WALL_VALUE){
        numPaths++;
      }
    }
    if(y > 0){
      if(cells[(y - 1) * GRID_DIMS + x].value != Cell.WALL_VALUE){
        numPaths++;
      }
    } 
    if(y < GRID_DIMS - 1){
      if(cells[(y + 1) * GRID_DIMS + x].value != Cell.WALL_VALUE){
        numPaths++;
      }
    }
    return numPaths;
  }
  
  char getCellValue(float absX, float absY){
    return getCellAt(absX, absY).value;
  }
  
  Cell getCellAt(float absX, float absY){
    int gridX = ((int)absX) / Cell.ABS_DIMS;
    int gridY = ((int)absY) / Cell.ABS_DIMS;
    return cells[gridX + gridY * GRID_DIMS];
  }

}
