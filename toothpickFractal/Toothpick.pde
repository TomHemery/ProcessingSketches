class Toothpick{
  
  static final int VERTICAL = 1;
  static final int HORIZONTAL = 2;
  static final int PICK_LENGTH = 4;
  
  int xCenter, yCenter, direction, colour;
  int xStart, yStart, xEnd, yEnd;
  static final color newColour = #A0A0A0;
  static final color oldColour = #A0A0A0;
  
  boolean hasStartNeighbour = false;
  boolean hasEndNeighbour = false;
  
  int lineWidth = 1;
  
  Toothpick(int x, int y, int direction){
    this.direction = direction;
    xCenter = x;
    yCenter = y;
    colour = newColour;
    xStart = direction == HORIZONTAL ? x - PICK_LENGTH / 2 : x;
    xEnd = direction == HORIZONTAL ? x + PICK_LENGTH / 2 : x;
    yStart = direction == VERTICAL ? y - PICK_LENGTH / 2 : y;
    yEnd = direction == VERTICAL ? y + PICK_LENGTH / 2 : y;
  }
  
  void render(){
    stroke(colour);
    strokeWeight(lineWidth);
    if(direction == VERTICAL){
      line(xStart, yStart, xEnd, yEnd);
    } else {
      line(xStart, yStart, xEnd, yEnd);
    }
  }
  
  void addToothpicks(ArrayList<Toothpick> open){
    if(!hasStartNeighbour){
      Toothpick startNeighbour = new Toothpick(xStart, yStart, direction == VERTICAL ? HORIZONTAL : VERTICAL);
      open.add(startNeighbour); 
    }
    if(!hasEndNeighbour){
      Toothpick endNeighbour = new Toothpick(xEnd, yEnd, direction == VERTICAL ? HORIZONTAL : VERTICAL);
      open.add(endNeighbour);  
    }
    colour = oldColour;
  }
  
  boolean isClosed(){
    int offset = lineWidth;
    if(direction == VERTICAL){
      if(pixels[(yStart - offset) * width + xStart] != bgCol){
        hasStartNeighbour = true;
      } 
      if(pixels[(yEnd + offset) * width + xEnd] != bgCol){
        hasEndNeighbour = true;
      }
    } else {
      if(pixels[(yStart) * width + xStart - offset] != bgCol){
        hasStartNeighbour = true;
      } 
      if(pixels[(yEnd) * width + xEnd + offset] != bgCol){
        hasEndNeighbour = true;
      }
    }
    return hasStartNeighbour && hasEndNeighbour;
  }
}
