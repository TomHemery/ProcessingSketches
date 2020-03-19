class Parser{
  
  static final String START_TAG = "start:";
  static final String BEGIN_RULES_TAG = "<rules>";
  static final String END_RULES_TAG = "</rules>";
  
  LSystem parse(String fileName){
    LSystem result = new LSystem();
    String [] lines = loadStrings(fileName);
    String curr;
    for(int i = 0; i < lines.length; i++){
      curr = lines[i];
      if(curr.startsWith(START_TAG)){
        result.setStart(curr.split(" ")[1]);
      } else if(curr.equals(BEGIN_RULES_TAG)){
        for(curr = lines[++i]; i < lines.length && !curr.equals(END_RULES_TAG); curr = lines[++i]){
          curr = curr.trim();
          result.addRule(curr.charAt(0), curr.split(" ")[1]);
        }
      }
    }
    return result;
  }
}
