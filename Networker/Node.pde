class Node{
  
  int index;
  
  private ArrayList<Link> links;
  PVector pos;
  int visualDiameter = 30;
  color colour = 100;
  
  boolean expanded = false;
  
  boolean isInputNode = false;
  boolean isOutputNode = false;
  
  Data payload = null;
  long receivedDataAt = -1;
  int holdTime = 10;
  
  Node(float x, float y, int index){
    links = new ArrayList<Link>();
    pos = new PVector(x, y);
    this.index = index;
  }
  
  void show(){
    stroke(payload == null ? colour : payload.c);
    fill(payload == null ? colour : payload.c);
    
    if(isOutputNode){
      noFill();
      strokeWeight(2);
      ellipse(pos.x, pos.y, visualDiameter, visualDiameter);
    } else if(isInputNode){
      noStroke();
      ellipse(pos.x, pos.y, visualDiameter, visualDiameter);
      noFill();
      stroke(payload == null ? colour : payload.c);
      strokeWeight(2);
      ellipse(pos.x, pos.y, visualDiameter + visualDiameter / 5, visualDiameter + visualDiameter / 5);
    } else {
      noStroke();
      ellipse(pos.x, pos.y, visualDiameter, visualDiameter);
    }
    
    if(payload != null && frameCount - receivedDataAt > holdTime){
      for(Link l : links){
        if(!l.pointingAt(this))l.passData(payload);
      }
      payload = null;
      receivedDataAt = -1;
    }
  }
  
  void checkIfOutput(){
    if(!isInputNode){
      boolean amOutput = true;
      for(Link l : links){
        if(l.pointingAt(l.getOther(this))){
          amOutput = false;
          break;
        }
      }
      isOutputNode = amOutput;
    }
  }
  
  void mark(){
    colour = color(200, 40, 40);
  }
  
  void unMark(){
    colour = color(100);
  }
    
  boolean isAt(float x, float y){
    return dist(x, y, pos.x, pos.y) < (visualDiameter / 2);
  }
  
  void resetState(){
    isInputNode = false;
    isOutputNode = false;
    expanded = false;
    unMark();
  }
  
  void passData(Data d){
    this.payload = d;
    receivedDataAt = frameCount;
    if(isOutputNode){
      network.outputFlares.add(new OutputFlare(pos.x, pos.y, visualDiameter, payload.c));    
    }  
  }

}
