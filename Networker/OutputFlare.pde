class OutputFlare{
  
  private PVector pos;
  private int startTime;
  private int duration = 60;
  private int startDiameter;
  private int maxDiameter;
  private color c;
  
  OutputFlare(float x, float y, int startDiameter, color c){
    pos = new PVector(x, y);
    this.startDiameter = startDiameter;
    this.maxDiameter = startDiameter * 4;
    this.c = c;
    startTime = frameCount;
  }
  
  void show(){
    float d = map(frameCount - startTime, 0, duration, startDiameter, maxDiameter);
    noFill();
    stroke(c);
    strokeWeight(2);
    ellipse(pos.x, pos.y, d, d);
  }
  
  boolean isDone(){
    return frameCount - startTime > duration;
  }
  
}
