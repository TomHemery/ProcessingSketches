import processing.sound.*;

DrumMachine drumMachine;
float oldWidth, oldHeight;
int prevTime;

void setup(){
  drumMachine = new DrumMachine();
  size(800, 800);
  surface.setResizable(true);
  oldWidth = width;
  oldHeight = height;
  frameRate(60);
}

void draw(){
  if(oldWidth != width || oldHeight != height){
    drumMachine.OnWindowResize();
  }
  
  background(100);
  drumMachine.Render();
  
  int time = millis();
  drumMachine.Update(time - prevTime);
  prevTime = time;
}

void mousePressed(){
  drumMachine.MousePressed(mouseX, mouseY);
}

SoundFile LoadSoundFile(String name){
  return new SoundFile(this, name);
}

void PlayBack(){
  drumMachine.PlayBack();
}
