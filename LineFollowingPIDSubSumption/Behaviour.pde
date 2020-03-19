abstract class Behaviour{

  Control output;
  LineFollower follower;
  
  abstract void Update();
  
  Behaviour(LineFollower f){
    allBehaviours.add(this);
    output = new Control();
    follower = f;
  }

}

class Control{

  float headingChange;
  float speed;
  boolean subsume = false;
  
}
