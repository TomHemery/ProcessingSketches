class Cell{
  
  public static final char WALL_VALUE = 'w';
  public static final char ENEMY_SPAWN_VALUE = 's';
  public static final char CLEAR_VALUE = 'x';
  
  public static final char COIN_VALUE = '-';
  public static final char PLAYER_SPAWN_VALUE = 'p';
  
  private static final color WALL_COLOUR = #FFFFFF;
  private static final color WALL_BORDER_COLOUR = #000000;
  private static final color SPAWN_COLOUR = #2020FF;
  
  private static final int WALL_BORDER_THICKNESS = 1;
  
  public boolean isIntersection = false;
  public boolean isDeadEnd = false;
  
  public static final int ABS_DIMS = 24;
  int [] index = new int[2];
  char value = '-';
  
  Coin coin = null;
  
  Cell(int x, int y){
    index[0] = x; 
    index[1] = y;
  }
  
  void addCoin(){
    coin = new Coin(index[0] * ABS_DIMS + ABS_DIMS / 2, index[1] * ABS_DIMS + ABS_DIMS / 2);
  }
  
  void render(){
    switch(value){
      case WALL_VALUE:
        stroke(WALL_BORDER_COLOUR);
        strokeWeight(WALL_BORDER_THICKNESS);
        fill(WALL_COLOUR);
        rect(index[0] * ABS_DIMS, index[1] * ABS_DIMS, ABS_DIMS, ABS_DIMS);
        break;
      case CLEAR_VALUE: 
      case ENEMY_SPAWN_VALUE:
        stroke(WALL_BORDER_COLOUR);
        fill(SPAWN_COLOUR);
        rect(index[0] * ABS_DIMS, index[1] * ABS_DIMS, ABS_DIMS, ABS_DIMS);
        break;
      default:
        if(coin != null){
          coin.render();
        }
        break;
    }
  }

}
