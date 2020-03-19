Grid grid;
Player player = null;
ArrayList<Enemy> enemies; 

void setup(){
  fullScreen();
  enemies = new ArrayList();
  grid = new Grid();
  grid.loadFromFile();
  textAlign(TOP, CENTER);
  textSize(32);
  ellipseMode(RADIUS);
}

void draw(){
  background(0);
  grid.render();
  if(player != null){
    player.render();
    player.update();
    fill(255);
    text(player.score, Cell.ABS_DIMS * Grid.GRID_DIMS + 10, 10);
  }
  for(Enemy e : enemies){
    e.render();
    e.update();
  }
}
