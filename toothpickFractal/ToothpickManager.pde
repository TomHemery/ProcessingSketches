class ToothpickManager{

  ArrayList<Toothpick> openToothpicks;
  int iterations = 1;
  int maxIterations = 512;

  ToothpickManager(){
    openToothpicks = new ArrayList<Toothpick>();
    Toothpick first = new Toothpick(width/2, height/2, Toothpick.HORIZONTAL);
    openToothpicks.add(first);
  }
  
  void update(){
    for(int i = openToothpicks.size() - 1; i >= 0; i--){
      openToothpicks.get(i).addToothpicks(openToothpicks);
      openToothpicks.remove(i);
    }
    render();
    trimOpenToothpicks();
    if(++iterations == maxIterations){
      noLoop();
    }
  }
  
  void render(){
    for(Toothpick pick : openToothpicks){
      pick.render();
    }
  }
  
  void trimOpenToothpicks(){
    Toothpick t;
    loadPixels();
    for(int i = openToothpicks.size() - 1; i >= 0; i--){
      t = openToothpicks.get(i);
      if(t.isClosed()){
        t.colour = Toothpick.oldColour;
        openToothpicks.remove(i);
      }
    }
  }
  

}
