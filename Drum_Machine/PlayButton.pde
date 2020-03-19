class PlayButton{

  boolean play = false;
  
  float x, y, w, h;
  
  void Render(){
    fill(150);
    stroke(0);
    if(play){
      rect(x, y, w/3, h);
      rect(x + 2*w/3, y, w/3, h);
    }
    else{
      triangle(x, y, x, y + h, x + w, y + h / 2);
    }
  }
  
  void OnWindowResize(float _x, float _y, float _w, float _h){
    x = _x;
    y = _y;
    w = _w;
    h = _h;
  }
  
  boolean MousePressed(int mouseX, int mouseY){
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h){
      play = !play;
      return true;
    }
    return false;
  }
}
