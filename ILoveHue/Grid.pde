import java.util.Collections;

class Grid{
  int grid_width;
  int grid_height;
  int card_width = 100; 
  int card_height = 100;
  int card_sat = 150;
  color[] corner_colours = {color(0), color(0), color(0)};
  ArrayList<Card> cards = new ArrayList();
  int picked_card = -1;
  
  public Grid(int g_w,int g_h, color t_l, color t_r, color b_l){
    this.grid_width = g_w;
    this.grid_height = g_h;
    corner_colours[0] = t_l;
    corner_colours[1] = t_r;
    corner_colours[2] = b_l;
  }
  
  void randomize(){
    Card c;
    Card d;
    int _i = 0;
    for(int i = 0; i < grid_height; i++){
      for(int j = 0; j < grid_width; j++){
        d = null;
        c = cards.get(j + i * grid_height);
        if(!c.dotted){
          while(d == null || d.dotted){
            _i = floor(random(36));
            d = cards.get(_i);
          }
          swap(c, d, j + i * grid_height, _i);
        }
      }
    }
  }
  
  void swap(Card c, Card d, int c_i, int d_i){
    int[] temp_loc = {d.draw_x, d.draw_y};
    d.draw_x = c.draw_x;
    d.draw_y = c.draw_y;
    c.draw_x = temp_loc[0];
    c.draw_y = temp_loc[1];
    cards.set(c_i, d);
    cards.set(d_i, c);
  }
  
  void show(){
    Card c;
    for(int i = 0; i < grid_height; i++){
      for(int j = 0; j < grid_width; j++){
        c = cards.get(j + i * grid_height);
        c.show();
      }
    }
    if(picked_card != -1){
      cards.get(picked_card).show();
    }
  }
  
  ArrayList<Integer> gen_colours(){
    ArrayList<Integer> ret = new ArrayList();
    int temp;
    for(int i = 0; i < grid_height; i++){
      for(int j = 0; j < grid_width; j++){
        temp = (corner_colours[0] + 
             floor(j / float(grid_width) * corner_colours[1]) + 
             floor(i / float(grid_height) * corner_colours[2]));
        ret.add(color(temp, card_sat, 255));
      }
    }
    return ret;
  }
  
  void populate(){
    ArrayList<Integer> colours = gen_colours(); 
    for(int i = 0; i < grid_height; i++){
      for(int j = 0; j < grid_width; j++){
        cards.add(new Card(j, i, card_width, card_height, colours.get(j + i * grid_height), false));
      }
    }
    cards.get(0).dotted = true;
    cards.get(grid_width - 1).dotted = true;
    cards.get((grid_width) * (grid_height) -1).dotted = true;
    cards.get((grid_width) * (grid_height) - grid_width).dotted = true;
  }
  
  int get_card_loc(int x, int y){
    x = x / card_width;
    y = y / card_height;
    return x + y * grid_height;
  }
  
  void pick_card(int x, int y){    
    int _i = get_card_loc(x, y);
    if(picked_card == -1){
      if(!cards.get(_i).dotted){cards.get(_i).picked = true;}
      picked_card = _i;
    }
  }
  
  void up_pick_card(int x, int y){
    int _i = get_card_loc(x, y);
    if(_i != picked_card){
      cards.get(picked_card).picked = false;
      swap(cards.get(picked_card), cards.get(_i), picked_card, _i);
      picked_card = -1;
    }
    else{
      cards.get(picked_card).picked = false;
      picked_card = -1;
    }
  }
  
}