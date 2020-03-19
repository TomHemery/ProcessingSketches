class Link{
  
  Node[] nodes = new Node [2];
  Direction direction;
  long prevProcessStep = -1;
  
  final int POINTING_AT = 1;
  final int STARTING_AT = 0;
  
  Data payload = null;
  long receivedDataAt = -1;
  int holdTime = 30;
  
  Link(Node a, Node b){
    nodes[0] = a;
    nodes[1] = b;
    direction = Direction.UNSET;
  }
  
  void show(){
    strokeWeight(2);
    if(payload == null){
      stroke(255);
      switch (direction){
        case SET:
          drawArrow(nodes[0].pos.x, nodes[0].pos.y, nodes[1].pos.x, nodes[1].pos.y);
          break;
        case UNSET:
          line(nodes[0].pos.x, nodes[0].pos.y, nodes[1].pos.x, nodes[1].pos.y);
          break;
        case CLOSED:
          drawClosed(nodes[0].pos.x, nodes[0].pos.y, nodes[1].pos.x, nodes[1].pos.y);
      }
    } else {
      drawDataPath(nodes[STARTING_AT].pos.x, nodes[STARTING_AT].pos.y, nodes[POINTING_AT].pos.x, nodes[POINTING_AT].pos.y);
      if(frameCount - receivedDataAt > holdTime){
        nodes[POINTING_AT].passData(payload);
        payload = null;
        receivedDataAt = 0;
      }
    }
  }
  
  boolean setStart(Node n, long processStep){
    if(processStep == prevProcessStep){
      direction = Direction.CLOSED;
      return false;
    } else {
      prevProcessStep = processStep;
      if(direction == Direction.UNSET){
        direction = Direction.SET;
        if(n != nodes[0]){
          Node temp = nodes[1];
          nodes[1] = nodes[0];
          nodes[0] = temp;
        }
        return true;
      }
    }
    return false;
  }
  
  void drawArrow(float x1, float y1, float x2, float y2){
    line(x1, y1, x2, y2);
    pushMatrix();
    translate(x2 + (x1 - x2) / 2, y2 + (y1 - y2) / 2);
    float a = atan2(x1-x2, y2-y1);
    rotate(a);
    line(0, 0, -10, -10);
    line(0, 0, 10, -10);
    popMatrix();
  }
  
  void drawClosed(float x1, float y1, float x2, float y2){
    line(x1, y1, x2, y2);
    pushMatrix();
    translate(x2 + (x1 - x2) / 2, y2 + (y1 - y2) / 2);
    float a = atan2(x1-x2, y2-y1);
    rotate(a);
    line(0, 0, -10, 0);
    line(0, 0, 10, 0);
    popMatrix();
  }
  
  void drawDataPath(float xS, float yS, float xE, float yE){
    long elapsed = frameCount - receivedDataAt;
    float percent = (float) elapsed / holdTime;
    percent = percent > 1.0? 1.0 : percent;

    PVector distance = new PVector(xE - xS, yE - yS);
    distance.mult(percent);
    
    stroke(payload.c);
    line(xS, yS, xS + distance.x, yS + distance.y);
    stroke(255);
    line(xS + distance.x, yS + distance.y, xE, yE);
  }
  
  Node getOther(Node n){
    if(n == nodes[0]) return nodes[1];
    else if (n == nodes[1]) return nodes[0];
    return null;
  }
  
  boolean pointingAt(Node n){
    return (
      direction == Direction.SET && n == nodes[POINTING_AT]
    );
  }
  
  void resetState(){
    direction = Direction.UNSET;
  }
  
  void passData(Data d){
    if (direction == Direction.SET){
      payload = d;
      receivedDataAt = frameCount;
    }
  }
  
}

static enum Direction{
  SET, UNSET, CLOSED
}
