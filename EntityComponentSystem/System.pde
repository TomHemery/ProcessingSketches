abstract class System{
  
  protected Scene mainScene;
  
  System(Scene s){
    mainScene = s;
  }

  abstract void UpdateSystem();
  
}
