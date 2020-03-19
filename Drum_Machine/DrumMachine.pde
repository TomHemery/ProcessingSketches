class DrumMachine{
  int cols = 16;
  int rows = 4;
  int controlColumns = 4;
  int controlRows = 1;
  
  int divisionsPerBeat = 4;
  int currentDivision = 0;
  
  ArrayList<boolean[]> tracks = new ArrayList();
  ArrayList<SoundFile> samples = new ArrayList();
  
  float buttonWidth = 0;
  float buttonHeight = 0;
  float controlPanelWidth = 0;
  float controlPanelHeight = 0;
  
  int bpm = 480;
  float time = 0;
  int msPerBeat;
  int msPerDivision;
  int elapsed = 0;
  
  boolean play;
  
  PlayButton playButton;
  
  DrumMachine(){
    for(int i = 0; i < rows; i++){
      tracks.add(new boolean[cols]);
    }
    playButton = new PlayButton();
    OnWindowResize();
    msPerBeat = floor((60.0 / bpm) * 1000.0); 
    msPerDivision = msPerBeat / (cols / divisionsPerBeat);
    println(msPerDivision);
    samples.add(LoadSoundFile("Kick_1.wav"));
    samples.add(LoadSoundFile("Snare_1.wav"));
    samples.add(LoadSoundFile("Clap_1.wav"));
    samples.add(LoadSoundFile("Hat_1.wav"));
  }
  
  void Render(){
    //render control panel 
    playButton.Render();
    //render control grid
    for(int row = 0; row < rows; row++){
      for(int col = 0; col < cols; col++){
        stroke(0);
        fill(tracks.get(row)[col] ? 150 : 50);
        strokeWeight(2);
        rect(controlPanelWidth + col * buttonWidth, controlPanelHeight + row * buttonHeight, buttonWidth, buttonHeight); 
      }
    }
    //render play bar
    stroke(0, 0, 255);
    strokeWeight(4);
    line(controlPanelWidth + currentDivision * buttonWidth, controlPanelHeight, controlPanelWidth + currentDivision * buttonWidth, height);
  } 
  
  void PlayBack(){
    int time;
    int prevTime = millis();
    TriggerSounds(0);
    while(play){
      time = millis();
      elapsed += time - prevTime;
      if(elapsed > msPerDivision){
        currentDivision = currentDivision < cols - 1 ? currentDivision + 1 : 0;
        elapsed = elapsed % msPerDivision;
        TriggerSounds(currentDivision);
      }
      prevTime = time;
    }
  }
  
  //updates the state of the drum machine
  void Update(int delta){
  }
  
  //triggers all sounds in a specified column
  void TriggerSounds(int col){
    for(int row = 0; row < tracks.size(); row++){
      if(tracks.get(row)[col]){
        samples.get(row).play();
      }
    }
  }
  
  //handles mouse presses
  void MousePressed(int x, int y){
    if(x > controlPanelWidth && y > controlPanelHeight){
      y -= controlPanelHeight;
      x -= controlPanelWidth;
      int col = x / (int)buttonWidth;
      int row = y / (int)buttonHeight;
      tracks.get(row)[col] = !tracks.get(row)[col];
    }
    else{
      if(playButton.MousePressed(x, y)){
        play = playButton.play;
        if(!playButton.play){
          currentDivision = 0;
          elapsed = 0;
        } 
        else{
          thread("PlayBack");
        }
      }
    }
  }
  
  //handles window resize
  void OnWindowResize(){
    buttonWidth = (float)width / (cols + controlColumns);
    buttonHeight = (float)height / (rows + controlRows);
    controlPanelWidth = controlColumns * buttonWidth;
    controlPanelHeight = controlRows * buttonHeight;
    playButton.OnWindowResize(controlPanelWidth, controlPanelHeight / 2 - buttonWidth / 2, buttonWidth, buttonWidth);
  }
}
