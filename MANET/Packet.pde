class Packet implements Cloneable{
  String data;
  
  Node source;
  Node dest;
  Node carrier;
  ArrayList<Node> previousCarriers = new ArrayList();
  
  int aversionTimer;
  int aversionTimerStart = 80;
  
  boolean passedThisStep = false;
  boolean reachedDestination = false;
  
  int timeAlive = 0;
  
  Packet(String d, Node _source, Node _dest){
    data = d;
    source = _source;
    dest = _dest;
    carrier = _source;
    aversionTimer = aversionTimerStart;
    activePackets ++;
  }
  
  Packet(String d, Node _source, Node _dest, Node _carrier){
    data = d;
    source = _source;
    dest = _dest;
    carrier = _carrier;
  }
  
  void Update(){
    passedThisStep = false;
    timeAlive ++;
    aversionTimer--;
    if(aversionTimer <= 0 && previousCarriers.size() > 0){
      aversionTimer = aversionTimerStart;
      previousCarriers.remove(0);
    }
  }
  
  void SetCarrier(Node _c){
    previousCarriers.add(carrier);
    carrier = _c;
    passedThisStep = true;
    if(carrier == dest){
      reachedDestination = true;
      activePackets --;
    }
  }
  
  String toString(){
    return "Packet, data: " + data;
  }
  
  public Packet clone(){
    return new Packet(data, source, dest, carrier);
  }
}
