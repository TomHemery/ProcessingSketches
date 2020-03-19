class Encounter{
  Node a;
  Node b;
  
  int lifeSpan = 960;
  int timeAlive = 0;
  
  Encounter(Node _a, Node _b){
    a = _a;
    b = _b;
  }
  
  void Update(){
    timeAlive++;
  }
  
  boolean Expired(){
    return timeAlive >= 240;
  }  
}
