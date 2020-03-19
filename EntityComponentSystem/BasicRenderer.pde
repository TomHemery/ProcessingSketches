class BasicRenderer extends Component{
  
  float w = 20, h = 20;
  
  BasicRenderer(GameObject g){
    super(g);
  }
  
  void Render(){
    Transform t = gameObject.transform;
    if(t != null){
      fill(255);
      rect(t.position.x, t.position.y, w, h);
    }
  }
  
}
