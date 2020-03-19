class Network{

  ArrayList<Node> nodes;
  int startNodeCount = 40;
  int initialPacketCount = 1;
  
  int packetIndex = 0;
  
  Network(){
    nodes = new ArrayList();
    for(int i = 0; i < startNodeCount; i++){
      nodes.add(new Node(random(width), random(height), i));
    }
    
    for(int i = 0; i < initialPacketCount; i++){
      AddRandomPacket();
    }
  }
  
  void Update(){
    for(Node n : nodes){
      n.Update();
    }
    
    for(Node n : nodes){
      n.EncounterNodes(nodes);
    }
    
    for(Node n : nodes){
      n.AttemptToPassPayload(nodes);
    }
    
    if(activePackets == 0)
      AddRandomPacket();
  }
  
  void Display(){
    for(Node n : nodes){
      n.Display();
    }
  }

  void AddRandomPacket(){
    int source = 0;
      do{
        source = floor(random(0, startNodeCount));
      } while (nodes.get(source).payload != null);
      int dest = source;
      while(dest == source)
        dest = floor(random(0, startNodeCount));
      nodes.get(source).payload = new Packet("Hello world " + packetIndex++, nodes.get(source), nodes.get(dest));
  }

}
