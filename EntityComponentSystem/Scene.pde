class Scene{

  ArrayList<GameObject> objects;
  ArrayList<System> systems;
  
  Scene(){
    objects = new ArrayList();
    systems = new ArrayList();
    GameObject test = new GameObject();
    test.components.add(new BasicRenderer(test));
    objects.add(test);
    systems.add(new RenderSystem(this));
  }
  
  void Update(){
    for(System s: systems) s.UpdateSystem();
  }

}
