class GameObject{

  ArrayList<Component> components = new ArrayList();
  Transform transform;
  
  GameObject(){
    transform = new Transform(this);
    transform.position = new PVector(width/2, height/2);
    components.add(transform);
  }
  
  <T extends Component> T GetComponent(Class<T> cls){
    for(Component c : components){
      if(cls.isInstance(c)) return cls.cast(c);
    }
    return null;
  }
  
}
