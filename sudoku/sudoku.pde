Board board;
boolean populateAtRender = false;

void setup(){
  fullScreen();
  textAlign(CENTER, CENTER);
  background(0);
  board = new Board(10, 10);
}

void draw(){
  background(0);
  board.render();
  if(populateAtRender){for(int i = 0; i < 1 + (Board.BOX_DIMS - 3) * 1000; i++) board.populateOneStep();}
}

void keyPressed(){
  if(key == 'a'){
    board.clearBoard();
    board.populate();
    populateAtRender = false;
  }
  else if(key == 's'){
    if(!populateAtRender){
      board.clearBoard();
      populateAtRender = true;
    } else populateAtRender = false;
  }
}
