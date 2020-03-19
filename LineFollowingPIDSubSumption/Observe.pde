class Observe extends Behaviour{
  
  boolean doMapping = true;
  ArrayList<MapVector> map = new ArrayList();
  MapVector loop = null;
  
  int loopStart;
  int loopEnd;
  int returnCounter;
  MapVector longestStraight;
  
  float turnThreshold = 0.2f;
  float returnMag = 0.f;
  
  Observe(LineFollower f){
    super(f); 
  }
  
  void Update(){    
    if(doMapping){
      if(map.size() == 0){
        map.add(new MapVector(follower.heading, follower.speed, new PVector(0, 0)));
      }
      else{
        float mapHeading = map.get(map.size() - 1).heading;
        if(abs(mapHeading - follower.heading) < turnThreshold){
          map.get(map.size() - 1).magnitude += follower.speed;
          map.get(map.size() - 1).heading = (15 * mapHeading + follower.heading) / 16;
        }
        else{
          loop = checkForLoop(map);
          if(loop == null){
            MapVector last = map.get(map.size() - 1);
            map.add(new MapVector(follower.heading, follower.speed, PVector.add(last.start, PVector.fromAngle(last.heading).mult(last.magnitude))));
          }
          else{
            doMapping = false;
            loopStart = map.indexOf(loop);
            loopEnd = map.size() - 1;
            returnCounter = loopStart;
            longestStraight = longest(map, loopStart, loopEnd);
          }
        }
      }
    }
    else{
      if(returnCounter != map.indexOf(longestStraight) && abs(map.get(returnCounter).heading - follower.heading) >= turnThreshold * 1.5){
        returnCounter = returnCounter < loopEnd ? returnCounter + 1 : loopStart;
      }
      if(returnCounter == map.indexOf(longestStraight)){
        returnMag += follower.speed;
        if(returnMag > longestStraight.magnitude / 2){
          output.subsume = true;
          output.speed = 0;
          output.headingChange = 0;
        }
      }
    }
    
    drawMap();
    
    fill(0, 0, 255);
    text("Current: " + returnCounter, 10, 2);
    text("Longest: " + map.indexOf(longestStraight), 10, 22);
    text("Start: " + loopStart, 10, 42);
    text("End: " + loopEnd, 10, 62);
  }
  
  void drawMap(){
    PVector prevPos = follower.startPos;
    MapVector m;
    for(int i = 0; i < map.size(); i ++){
      m = map.get(i);
      PVector curr = PVector.fromAngle(m.heading).mult(m.magnitude);
      
      if(m == longestStraight)
        stroke(0, 255, 0);
      else if (i == loopStart)
        stroke(255, 0, 0);
      else if(i == loopEnd)
        stroke(0, 255, 255);
      else
        stroke(0, 0, 255);
        
      strokeWeight(2);
      line(prevPos.x, prevPos.y, prevPos.x + curr.x, prevPos.y + curr.y);
      prevPos = PVector.add(prevPos, curr);
    }
  }
}
