class Parser{
  
  Network parse(String sFileName){
    Network generated = new Network();
    String[] lines = loadStrings(sFileName);
    int index = 0;
    
    for(int i = 0; i < lines.length; i++){
      String[] tokens = lines[i].split("\t");
      if(tokens[0].equals("Node")){
        generated.hardAddNode(new Node(new Float(tokens[1]), new Float(tokens[2]), index++));
      } else if(tokens[0].equals("Link")){
        Node n1 = generated.getNodeAtIndex(new Integer(tokens[1]));
        Node n2 = generated.getNodeAtIndex(new Integer(tokens[2]));
        Link newLink = new Link(n1, n2);
        n1.links.add(newLink);
        n2.links.add(newLink);
        generated.hardAddLink(newLink);
      } else{
        println("Error on line " + (i+1) + " of input file");
      }
    }
    
    generated.index = index;
    
    return generated;
  }
}
