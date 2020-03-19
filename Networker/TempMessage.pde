class TempMessage{
  
  String message;
  PVector pos;
  int duration = 60;
  int startTime = 0;
  
  TempMessage(String message){
    this.message = message;
    pos = new PVector(width / 2, height / 2);
    startTime = frameCount;
  }
  
  boolean showAndCheckFinished(){
    fill(255, 0, 0);
    textSize(60);
    text(message, pos.x, pos.y);
    pos.y--;
    return frameCount - startTime > duration;
  }
  
}
