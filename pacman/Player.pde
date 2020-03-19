class Player extends Entity{
  
  private int score = 0;
  
  protected color colour;
  
  Player(int x, int y){
    super(x, y);
    colour = color(255, 255, 0);
  }
  
  void render(){
    stroke(0);
    strokeWeight(1);
    fill(colour);
    ellipse(pos.x, pos.y, radius, radius);
  }
  
  void setVelocity(float vX, float vY){
    velDesired = new PVector(vX, vY);
  }
  
  void update(){ 
    super.update();
    Cell curr = grid.getCellAt(pos.x, pos.y);
    if(curr.coin != null){
      curr.coin = null;
      score++;
    }
  }
}
