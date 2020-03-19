class Cow{
  
  boolean found = false;
  PVector loc;
  float distance;
  SoundFile cow;
  float min_vol = 0.05;
  float low_vol = 800;
  int r;

  public Cow(int x, int y, SoundFile s, int _r){
    loc = new PVector(x, y);
    cow = s;
    this.r = _r;
  }
  
  public void update(PVector mouse){
    PVector dist;
    dist = PVector.sub(loc, mouse);
    this.distance = dist.mag();
    this.cow.amp(this.vol(this.distance));
  }
  
  public void click(PVector mouse){
    PVector dist;
    dist = PVector.sub(loc, mouse);
    if (dist.mag() < this.r){
      found = true;
    }
  }
  
  public float vol(float d){
    float v = min_vol;
    if (d < low_vol){
      v = 1 - d/low_vol;
      if (v < min_vol){v = min_vol;}
    }
    return v;
  }
  
  public void show(){
    //stroke(0);
    //strokeWeight(this.r * 2);
    //point(loc.x, loc.y);
    if (frameCount % 30 == 0){
      this.cow.play();
    }
  }

}