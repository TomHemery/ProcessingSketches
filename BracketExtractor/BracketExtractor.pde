void setup(){

  String s = "(,(),(),((())),(),(((),())),(),(((()))),((),()),);";
  int countOpen = 0;
  int countClose = 0;
  PrintWriter output = createWriter("brackets.txt");
  
  int tab = 0;
  
  for(int i = 0; i < s.length(); i++){
    char c = s.charAt(i);
    if(c == '('){
      countOpen++;
      for(int x = 0; x < tab; x++){output.print("|\t");}
      output.print('(');
      tab++;
      //char cPrime = s.charAt(++i);
      //while(cPrime != '(' && cPrime != ')'){
      //  output.print(cPrime);
      //  cPrime = s.charAt(++i);
      //}
      //i--;
      output.println();
    }
    
    else if(c == ')'){
      tab--;
      for(int x = 0; x < tab; x++){output.print("|\t");}
      countClose++;
      output.println(')');
    }
  }
  
  println();
  
  println("Number of open brackets: " + countOpen);
  println("Number of close brackets: " + countClose);
  output.close();
  
  noLoop();
}
