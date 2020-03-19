class Node{

  PVector pos;
  PVector vel = new PVector();
  PVector acc = new PVector();
  int radius = 5;
  int commRadius = 100;
  
  float accSpeed = 0.5;
  float maxSpeed = 2.0;
  
  private boolean receivedMessage = false;
  private String message = "";
  private int messageTimerStart = 120;
  private int messageTimer;
  
  private int weakTransferTimerStart = 20;
  private int weakTransferTimer = 0;
  
  private int peturbationTimerStart = 60;
  private int peturbationTimer = 0;
  
  Packet payload = null;
  
  ArrayList<Encounter> encounters = new ArrayList();
  ArrayList<Encounter> weakEncounters = new ArrayList();
  
  int index;
  
  Node(float x, float y, int _index){
    pos = new PVector(x, y);
    index = _index;
    //commRadius = commRadius + floor(random(-20, 100));
  }
  
  void Update(){
    vel.add(acc);
    vel.limit(maxSpeed);
    pos.add(vel);
    acc = PVector.random2D().mult(accSpeed);
    ConstrainToScreen();
    if(payload != null){
      payload.Update();
    }
    
    for(int i = encounters.size() - 1; i >= 0; i--){
      encounters.get(i).Update();
      if(encounters.get(i).Expired())
        encounters.remove(i);
    }
    
    for(int i = weakEncounters.size() - 1; i >= 0; i--){
      if(weakEncounters.get(i).Expired())
        weakEncounters.remove(i);
    }
    
    weakTransferTimer = weakTransferTimer > 0 ? weakTransferTimer - 1 : 0;
    peturbationTimer = peturbationTimer > 0 ? peturbationTimer - 1 : 0;
  } 
  
  void EncounterNodes(ArrayList<Node> networkNodes){
    for(Node n : networkNodes){
      if(n != this && dist(pos.x, pos.y, n.pos.x, n.pos.y) < commRadius + n.commRadius){       
        boolean recorded = false;
        for(Encounter e : encounters){
          if(e.a == this && e.b == n || e.a == n && e.b == this){
            recorded = true;
            e.timeAlive = 0;
          }
        }
        if(!recorded){
          Encounter e = new Encounter(this, n);
          encounters.add(e);
          n.encounters.add(e);
          for(Encounter other : n.encounters){
            if(!encounters.contains(other))
              weakEncounters.add(other);
          }
          for(Encounter mine : encounters){
            if(!n.encounters.contains(mine))
              n.weakEncounters.add(mine);
          }
        }
      }
    }
  }
  
  void AttemptToPassPayload(ArrayList<Node> network){
    if(payload != null && !payload.passedThisStep && !payload.reachedDestination){
      for(Node n : network){
        if(n != this && !payload.previousCarriers.contains(n) && n.payload == null && 
            (n.HasEncountered(payload.dest) || weakTransferTimer <= 0 && n.HasWeaklyEncountered(payload.dest) || peturbationTimer <= 0)){
          if(dist(pos.x, pos.y, n.pos.x, n.pos.y) < commRadius + n.commRadius){
            n.TakePayload(payload);
            payload = null;
            
            if(render){
              strokeWeight(2);
              stroke(0, 255, 255);
              line(pos.x, pos.y, n.pos.x, n.pos.y);
            }
            
            break;
          }
        }
      }
    }
  }
  
  void Display(){
    if(payload != null)
      fill(255, 0, 0);
    else
      fill(0, 255, 0);
    noStroke();
    ellipse(pos.x, pos.y, radius * 2, radius * 2);
    noFill();
    stroke(255, 0, 255);
    ellipse(pos.x, pos.y, commRadius * 2, commRadius * 2);
    
    if(payload != null){
      stroke(255, 255, 0);
      strokeWeight(2);
      line(pos.x, pos.y, payload.dest.pos.x, payload.dest.pos.y);
      
      fill(255);
      textSize(15);
      text(weakTransferTimer, pos.x, pos.y + 20);
      text(peturbationTimer, pos.x, pos.y + 35);
    }
    
    if(receivedMessage){
      fill(255);
      textSize(15);
      text(message, pos.x, pos.y - map(messageTimer, messageTimerStart, 0, 0, 30));
      messageTimer --;
      receivedMessage = messageTimer > 0;
    }
    
    if(showEncounters){
      for(Encounter e : encounters){
        stroke(0, 0, 255);
        strokeWeight(2);
        line(e.a.pos.x, e.a.pos.y, e.b.pos.x, e.b.pos.y);
      }
    }
    
    if(showWeakEncounters){
      for(Encounter e : weakEncounters){
        stroke(100, 100, 200);
        strokeWeight(2);
        line(pos.x, pos.y, e.a.pos.x, e.a.pos.y);
        line(pos.x, pos.y, e.b.pos.x, e.b.pos.y);
      }
    }
  }
  
  private void ConstrainToScreen(){
    if(pos.x > width - radius){
      pos.x = width - radius;
      vel.x = -vel.x;
    }
    else if(pos.x < radius){
      pos.x = radius;
      vel.x = -vel.x;
    }
    if(pos.y > height - radius){
      pos.y = height - radius;
      vel.y = -vel.y;
    }
    else if(pos.y < radius){
      pos.y = radius;
      vel.y = -vel.y;
    }
  }
  
  void TakePayload(Packet p){
    payload = p;
    p.SetCarrier(this);
    weakTransferTimer = weakTransferTimerStart;
    peturbationTimer = peturbationTimerStart;
    if(payload.reachedDestination){
        message = "\"" + payload.data + "\"" + "\nReceived in: " + payload.timeAlive;
        receivedMessage = true;
        messageTimer = messageTimerStart;
        weakTransferTimer = 0;
        peturbationTimer = 0;
        
        deliveredPackets++;
        averageLatency = (averageLatency * (deliveredPackets - 1) + payload.timeAlive) / deliveredPackets;
        lastLatency = payload.timeAlive;
        
        payload = null;
    }
  }
  
  Boolean HasEncountered(Node n){
    for(Encounter e : encounters)
      if(e.a == n || e.b == n)
        return true;
    return false;
  }
  
  Boolean HasWeaklyEncountered(Node n){
    for(Encounter e : weakEncounters)
      if(e.a == n || e.b == n)
        return true;
    return false;
  }
  
  float DistToNode(Node other){
    return dist(pos.x, pos.y, other.pos.x, other.pos.y);
  }
  
  String toString(){
    return "MANET Node, index: " + index + " position: " + pos.x + ", " + pos.y + " payload: " + payload;
  }
}
