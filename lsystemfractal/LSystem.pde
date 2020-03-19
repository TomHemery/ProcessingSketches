class LSystem {
  
  private String start;
  private String current;
  private HashMap<Character, String> rules;
  private StringBuilder builder;
  
  LSystem(){
    rules = new HashMap<Character, String>();
    builder = new StringBuilder();
  }
  
  void addRule(Character c, String s){
    rules.put(c, s);
  }
  
  void setStart(String s){
    start = s;
    current = s;
  }
  
  String getCurrent(){
    return current;
  }
  
  void step(){
    builder.setLength(0);
    for(char c : current.toCharArray()){
      if(rules.get(c) != null){
        builder.append(rules.get(c));
      } else{
        builder.append(c);
      }
    }
    current = builder.toString();
  }
  
  String toString(){
    builder.setLength(0);
    builder.append("L System, Start: " + start + "\n");
    for(HashMap.Entry<Character, String> pair : rules.entrySet()){
      builder.append("Rule: " + pair.getKey() + " -> " + pair.getValue() + "\n");
    }
    return builder.toString();
  }
  
}
