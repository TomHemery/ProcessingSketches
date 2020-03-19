class FlakeHandler{
  
  ArrayList<SnowFlake> snowFlakes = new ArrayList<SnowFlake>();
  int numFlakes = 500;
  
  FlakeHandler(){
    for(int i = 0; i < numFlakes; i ++){
      snowFlakes.add(new SnowFlake());
    }
  }
  
  void show(){
    for(SnowFlake flake : snowFlakes){
      flake.show();
      flake.applyForce(gravity);
      flake.applyForce(wind);
      flake.update();
    }
  }
  
  
}