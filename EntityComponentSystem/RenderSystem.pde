class RenderSystem extends System{
  
  RenderSystem(Scene mainScene){
    super(mainScene);
  }
  
  void UpdateSystem(){
    background(0);
    for(GameObject g : mainScene.objects){
      BasicRenderer r = g.GetComponent(BasicRenderer.class);
      if(r != null) r.Render();
    }
  
  }
  
}
