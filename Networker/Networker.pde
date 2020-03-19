Mode currentMode = Mode.PLACE_NODE;
Network network;
Parser parser = new Parser();
boolean showTempMessage = false;
TempMessage tempMessage = null;

void setup(){
  fullScreen();
  network = new Network();
}

void draw(){
  background(0);
  fill(255);
  textSize(20);
  text(currentMode.toString() + "\nS: Save, O: Open\nN: Place Node, L: Place Link\nP: Process, D: Data Pulse"
    + (currentMode == Mode.DATA_PULSE ? "\n[Space]: Send Data Pulse, " + 
      (network.autoPulse ? "A: Disable Auto pulse" : "A: Enable Auto Pulse")
    : ""),
    0, 20);
  network.show();
  
  if(tempMessage != null){
    if(tempMessage.showAndCheckFinished()){
      tempMessage = null;
    }
  }
  
}

void mouseClicked(){
  switch(currentMode){
    case PLACE_NODE:
      network.addNode(mouseX, mouseY);
      break;
    case PLACE_LINK:
      network.addLink(mouseX, mouseY);
      break;
    case PROCESS:
      network.processFrom(mouseX, mouseY);
      break;
    default:
      break;
  }
}

void keyReleased(){
  Mode tempMode = currentMode;
  switch(key){
    case '-':
      network = new Network();
    case 'n':
      currentMode = Mode.PLACE_NODE;
      break;
    case 'l':
      currentMode = Mode.PLACE_LINK;
      break;
    case 'p':
      currentMode = Mode.PROCESS;
      break;
    case 'd':
      currentMode = Mode.DATA_PULSE;
      break;
    case 'a':{
      if(currentMode == Mode.DATA_PULSE){
        network.autoPulse = !network.autoPulse;
      }
      break;
    }
    case ' ':{
      if(currentMode == Mode.DATA_PULSE){
        network.sendPulse();
      }
      break;
    }
    case 's':{
      network.saveNetwork("saveFile.txt");
      tempMessage = new TempMessage("Saved File");
      break;
    }
    case 'o':{
      network = parser.parse("saveFile.txt");
      tempMessage = new TempMessage("Opened File");
    }
  }
  if(tempMode != currentMode){
    network.modeChanged(currentMode,tempMode);
  }
}

enum Mode{
  PLACE_NODE,
  PLACE_LINK,
  PROCESS,
  DATA_PULSE
}
