class Explosion{

  float radius = 0;
  float maxRadius = 15; 
  
  void Update(){
    radius += 0.5;
    if(radius > maxRadius) radius = 0;
    //if(radius > maxRadius) noLoop();
  }
  
  void Render(){
    
  }
}
