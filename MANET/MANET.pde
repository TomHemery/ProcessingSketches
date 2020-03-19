Network net;
int timeScale = 3000;

float averageLatency = 0;
float lastLatency = 0;
int deliveredPackets;

int activePackets = 0;

boolean showEncounters = false;
boolean showWeakEncounters = false;
boolean render = false;

void setup(){
  net = new Network();
  fullScreen();
}

void draw(){
  for(int i = 0; i < timeScale; i++)
    net.Update();
  if(render){
    background(0);
    net.Display();
  }
  else{
    fill(0);
    noStroke();
    rect(0, 0, 300, 140);
  }
  fill(255);
  textSize(20);
  textAlign(LEFT, TOP);
  text("Timescale: " + timeScale, 5, 0);
  text("Packets Delivered: " + deliveredPackets, 5, 20);
  text("Average Latency: " + averageLatency, 5, 40);
  text("Most Recent Latency: " + lastLatency, 5, 60);
  text("Active Packets: " + activePackets, 5, 80);
  text("Steps Per Second: " + frameRate * timeScale, 5, 100);
  text("Frame Rate: " + frameRate, 5, 120);
  textAlign(CENTER, CENTER);
}

void keyPressed(){
  if (key == CODED) {
    if (keyCode == UP) {
      timeScale++;
    } else if (keyCode == DOWN) {
      timeScale = timeScale > 1 ? timeScale - 1 : 1;
    } else if (keyCode == LEFT){
      timeScale = timeScale - 10;
      timeScale = timeScale < 1 ? 1 : timeScale;
    } else if (keyCode == RIGHT){
      timeScale += 10;
    }
  }
  else if(key == '1')
    timeScale = 1;
  
  else if(key == 'e')
    showEncounters = !showEncounters;
  else if(key == 'p')
    net.AddRandomPacket();
  else if(key == 'w')
    showWeakEncounters = !showWeakEncounters;
  else if(key == 'r'){
    render = !render;
    if(!render)
      background(0);
  }
}
