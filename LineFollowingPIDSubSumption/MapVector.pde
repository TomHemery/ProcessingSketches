class MapVector{

  public float heading;
  public float magnitude;
  public PVector start;
  
  MapVector(float h, float m, PVector s){
    heading = h;
    magnitude = m;
    start = s;
  }

  String toString(){
    return "[" + heading + ", " + magnitude + "]";
  }

  boolean alike(MapVector other){
    float angleThreshold = 0.7f;
    float magThreshold = 30.0f;
    float minMag = 30.f;
    return 
      abs(other.heading - heading) < angleThreshold 
      && abs(other.magnitude - magnitude) < magThreshold 
      && magnitude > minMag && other.magnitude > minMag
      && near(start, other.start);
  }
  
  boolean near(PVector a, PVector b){
    float minDist = 30.0f;
    return (PVector.dist(a, b) < minDist);
  }

}

MapVector checkForLoop(ArrayList<MapVector> map){
  MapVector newest = map.get(map.size() - 1);
  for(MapVector m : map){
    if(m != newest){
      if(newest.alike(m)){ //completed a loop
        return m;
      }
    }
  }
  return null;
}

MapVector longest(ArrayList<MapVector> map, int min, int max){
  MapVector longest = null;
  MapVector m;
  
  for(int i = min; i <= max; i++){
    m = map.get(i);
    if(longest == null || m.magnitude > longest.magnitude){
      longest = m;
    }
  }
  return longest;
}
