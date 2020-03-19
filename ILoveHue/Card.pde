class Card{
  
  int w;
  int h;
  int start_x;
  int start_y;
  int draw_x;
  int draw_y;
  color c;
  boolean dotted = false;
  boolean picked = false;

  public Card(int _x, int _y, int _w, int _h, color _c, boolean _d){
    this.w = _w;
    this.h = _h;
    this.c = _c;
    this.start_x = _x;
    this.draw_x = _x;
    this.draw_y = _y;
    this.start_y = _y;
    this.dotted = _d;
  }
  
  void show(){
    noStroke();
    fill(this.c);
    if(!picked){rect(draw_x * w, draw_y * h, w, h);}
    else{rect(mouseX, mouseY, w, h);}
    if(dotted){
      stroke(0);
      strokeWeight(4);
      point(draw_x * w + this.w/2, draw_y * h + this.h/2);
    }
  }
  
}