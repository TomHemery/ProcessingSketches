Parser parser;
LSystem system;

void setup(){
  parser = new Parser();
  system = parser.parse("Example1.txt");
  println(system + "\n");
}

void draw(){

}

void keyPressed(){
  if(key == ' '){
    system.step();
    println(system.getCurrent()); 
  }
}
