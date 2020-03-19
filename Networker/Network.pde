class Network{
  
  int index = 0;

  ArrayList<Link> links;
  ArrayList<Node> nodes;
  Node addingLinkTo = null;
  
  Node inputNode = null;
  ArrayList<Node> toProcess = null;
  long processStep = 0;
  
  int pulseRate = 150;
  boolean autoPulse = false;
  ArrayList<OutputFlare> outputFlares;
   
  Network(){
    links = new ArrayList<Link>();
    nodes = new ArrayList<Node>();
    outputFlares = new ArrayList<OutputFlare>();
  }
  
  void show(){
    
    if(toProcess != null && !toProcess.isEmpty() && frameCount % 10 == 0){
      ArrayList<Node> nextToProcess = new ArrayList();
      for(Node n : toProcess){
        n.unMark();
        if(!n.expanded){
          for(Link l : n.links){
            if(l.setStart(n, processStep)){
              Node other = l.getOther(n);
              other.mark();
              nextToProcess.add(other);
            }
          }
          n.expanded = true;
        }
      }
      toProcess = nextToProcess;
      processStep++;
    } else if(toProcess != null && toProcess.isEmpty()){
      processStep = 0;
      toProcess = null;
      for(Node n : nodes)n.checkIfOutput();
    }
    
    if(inputNode != null && currentMode == Mode.DATA_PULSE && autoPulse && frameCount % pulseRate == 0){
      sendPulse();
    }
    
    for(Link l : links){
      l.show();
    } 
    for(Node n: nodes){
      n.show();
    }
    
    for(int i = outputFlares.size() - 1; i >= 0; i--){
      OutputFlare f = outputFlares.get(i);
      f.show();
      if(f.isDone()){
        outputFlares.remove(i);
      }
    }
    
  }
  
  void addNode(float x, float y){
    if(getNodeAt(x, y) == null)
      nodes.add(new Node(x, y, index++));
  }
  
  void addLink(float x, float y){
    Node selected = getNodeAt(x, y);  
    if(selected != null){
      if(addingLinkTo == null){
        addingLinkTo = selected;
        selected.mark();
      } else {
        Link l = new Link(addingLinkTo, selected);
        links.add(l);
        selected.links.add(l);
        addingLinkTo.links.add(l);
        addingLinkTo.unMark();
        addingLinkTo = null;
      }
    }
  }
  
  void processFrom(float x, float y){
    if(inputNode == null){
      inputNode = getNodeAt(x, y);
      if(inputNode != null){
        inputNode.mark();
        inputNode.isInputNode = true;
        toProcess = new ArrayList();
        toProcess.add(inputNode);
      }
    }
  }
  
  private Node getNodeAt(float x, float y){
    for(Node n : nodes){
      if(n.isAt(x, y)){
        return n;
      }
    }
    return null;
  }
  
  public void modeChanged(Mode newState, Mode prevState){
    if(newState != Mode.PLACE_LINK){
      if(addingLinkTo != null){
         addingLinkTo.unMark();
         addingLinkTo = null;
      }
    }
    
    if(prevState == Mode.PROCESS || prevState == Mode.DATA_PULSE){
      if(newState != Mode.PROCESS && newState != Mode.DATA_PULSE){
        resetState();
      }
    }
    
  }
  
  private void resetState(){
    for(Node n: nodes){
      n.resetState();
    } for(Link l: links){
      l.resetState();
    }
    inputNode = null;
    toProcess = null;
    processStep = 0;
  }
  
  private void sendPulse(){
    if(inputNode != null){inputNode.passData(new Data(color(200, 0, 240)));}
  }
  
  public void hardAddNode(Node n){
    nodes.add(n);
  }

  public void hardAddLink(Link l){
    links.add(l);
  }
  
  public Node getNodeAtIndex(int i){
    return nodes.get(i);
  }
  
  public void saveNetwork(String saveFile){
    PrintWriter output = createWriter(saveFile);
    for(Node n: nodes)
      output.println("Node\t" + n.pos.x + "\t" + n.pos.y);
    for(Link l: links)
      output.println("Link\t" + l.nodes[0].index + "\t" + l.nodes[1].index);
    output.flush();
    output.close();
  }

}
