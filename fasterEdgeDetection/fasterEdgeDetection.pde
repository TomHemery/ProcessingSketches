import processing.video.*;

Capture cam;
PImage frame;
EdgeDetector edgeDetector = new EdgeDetector();

PShader blur;
PShader edgeDetection;
PShader grey;

void setup() {
  size(640, 480, P2D);
  
  edgeDetection = loadShader("edge.glsl");
  edgeDetection.set("sketchSize", float(width), float(height));
  
  blur = loadShader("gaussianBlur.glsl");
  blur.set("kernelSize", 5); // How big is the sampling kernel?
  blur.set("strength", 8.0); // How strong is the blur?

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  set(0, 0, cam);
  filter(blur);
  filter(edgeDetection);
}

PImage toGreyscale(PImage img){
  PImage result = new PImage(img.width, img.height);
  int curr;
  result.loadPixels();
  for(int i = 0; i < img.pixels.length; i++){
    curr = img.pixels[i];
    curr = ((curr >> 16 & 0xFF) + (curr >> 8 & 0xFF) + (curr & 0xFF)) / 3;
    result.pixels[i] = color(curr);
  }
  result.updatePixels();
  return result;
}
