package com.hemery.edgeDetector;

import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import processing.video.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class fasterEdgeDetection extends PApplet {



Capture cam;
PImage frame;
EdgeDetector edgeDetector = new EdgeDetector();

PShader blur;
PShader edgeDetection;
PShader grey;

public void setup() {
  
  
  edgeDetection = loadShader("edge.glsl");
  edgeDetection.set("sketchSize", PApplet.parseFloat(width), PApplet.parseFloat(height));
  
  blur = loadShader("gaussianBlur.glsl");
  blur.set("kernelSize", 5); // How big is the sampling kernel?
  blur.set("strength", 8.0f); // How strong is the blur?

  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }      
}

public void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  set(0, 0, cam);
  filter(blur);
  filter(edgeDetection);
}

public PImage toGreyscale(PImage img){
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
class BasicGaussian extends KernelOperator{
  
  int rounds = 3;
  
  public PImage applyToImage(PImage img){
    PImage result = super.applyToImage(img);
    for(int i = 0; i < rounds - 1; i++)
      result = super.applyToImage(result);
    return result;
  }
  
  BasicGaussian(){
    super(3);
    kernelMatrix = new float[][]{
      {1, 2, 1},
      {2, 4, 2},
      {1, 2, 1},
    };
    normalization = 16;
  }
  
}
class EdgeDetector extends KernelOperator{
  
  SobelX sobelX = new SobelX();
  SobelY sobelY = new SobelY();
  
  EdgeDetector(){
    super(0);
  }
  
  public PImage applyToImage(PImage img){
    img = cleanBorders(img);
    PImage sobelResult = new PImage(img.width, img.height);
    float gX;
    float gY;
    float [][] angles = new float[img.width][img.height];
    int val;
    img.loadPixels();
    for(int x = 1; x < img.width - 1; x++){
      for(int y = 1; y < img.height - 1; y++){
        gX = sobelX.calculatePoint(img, x, y);
        gY = sobelY.calculatePoint(img, x, y);
        val = PApplet.parseInt(sqrt(gX * gX + gY * gY));
        sobelResult.pixels[x + y * img.width] = color(val, val, val);
        angles[x][y] = gX > 0 ? atan(gY / gX) : 0;
      }
    }  
    sobelResult.updatePixels();
    return cannyOperator(cleanBorders(sobelResult), angles);
  }
  
  public PImage cannyOperator(PImage img, float[][] angles){
    PImage cannyResult = new PImage(img.width, img.height);
    int max = 0;
    int checkWidth = 5;
    int val;
    for(int x = 1; x < img.width-1; x++){
      for(int y = 1; y < img.height-1; y++){
        if(angles[x][y] >= 1.25f * PI && angles[x][y] <= 1.75f * PI ||
           angles[x][y] >= 0.25f * PI && angles[x][y] <= 0.75f * PI){ //vertically dominated
           for(int z = -checkWidth; z <= checkWidth; z++){
             if(x + z > 0 && x + z < img.width - 1){
               val = extractVal(img, x + z, y);
               max = max > val ? max : val;
             }
           }
        } else { //horizontally dominated
          for(int z = -checkWidth; z <= checkWidth; z++){
             if(y + z > 0 && y + z < img.height - 1){
               val = extractVal(img, x, y + z);
               max = max > val ? max : val;
             }
           }
        }
        cannyResult.pixels[x + y * img.width] = color(extractVal(img, x, y) == max ? max : 0);
        max = 0;
      }
    }
    return hysteresisThresholding(cleanBorders(cannyResult));
  }
  
  public PImage hysteresisThresholding(PImage image){
    int topThreshold = 35;
    int lowThreshold = 8;
    boolean change = true;
    image.loadPixels();
    while(change){
      change = false;
      for(int x = 1; x < image.width-1; x ++){
        for(int y = 1; y < image.height-1; y++){
          if(extractVal(image, x, y) > topThreshold){
            image.pixels[x + y * image.width] = 0xffFFFFFF;
            for(int x2 = -1; x2 <= 1; x2++){
              for(int y2 = -1; y2 <= 1; y2++){
                if(x2 != 0 && y2 != 0 && extractVal(image, x + x2, y + y2) > lowThreshold && extractVal(image, x + x2, y + y2) < 255){
                  change = true;
                  image.pixels[x + x2 + (y + y2) * image.width] = 0xffFFFFFF;
                }
              }
            }
          }
        }
      }
      
      if(change){
        for(int x = image.width - 2; x > 0; x --){
          for(int y = image.height - 2; y > 0; y--){
            if(extractVal(image, x, y) > topThreshold){
              image.pixels[x + y * image.width] = 0xffFFFFFF;
              for(int x2 = -1; x2 <= 1; x2++){
                for(int y2 = -1; y2 <= 1; y2++){
                  if(x2 != 0 && y2 != 0 && extractVal(image, x + x2, y + y2) > lowThreshold && extractVal(image, x + x2, y + y2) < 255){
                    change = true;
                    image.pixels[x + x2 + (y + y2) * image.width] = 0xffFFFFFF;
                  }
                }
              }
            }
          }
        }
      }
    }
    
    for(int x = 0; x < image.width; x++){
      for(int y = 0; y < image.height; y++){
        image.pixels[x + y * image.width] = extractVal(image, x, y) == 255 ? 0xffFFFFFF : 0xff000000;
      }
    }
    image.updatePixels();
    return cleanBorders(image);
  }
  
  public PImage cleanBorders(PImage img){
    img.loadPixels();
    for(int x = 0; x < img.width; x++){
      img.pixels[x] = 0xff000000;
      img.pixels[x + (img.height - 1) * img.width] = 0xff000000;
    }
    
    for(int y = 0; y < img.height; y++){
      img.pixels[y * img.width] = 0xff000000;
      img.pixels[img.width - 1 + y * img.width] = 0xff000000;
    }
    return img;
  }
  
  private class SobelX extends KernelOperator{
    SobelX(){
      super(3);
      kernelMatrix = new float[][]{
        {-1, 0, 1},
        {-2, 0, 2},
        {-1, 0, 1}
      };
      normalization = 2;
    }
  }

  private class SobelY extends KernelOperator{
    SobelY(){
      super(3);
      kernelMatrix = new float[][]{
        {1, 2, 1},
        {0, 0, 0},
        {-1, -2, -1}
      };
      normalization = 2;
    }
  }
}
class KernelOperator{

  float[][] kernelMatrix;
  int halfKernelMatrixWidth;
  float normalization = 1;
  
  KernelOperator(int w){
    halfKernelMatrixWidth = w / 2;
  }
  
  public PImage applyToImage(PImage img){
    PImage result = new PImage(img.width, img.height);
    img.loadPixels();
    for(int x = halfKernelMatrixWidth; x < img.width - halfKernelMatrixWidth; x++){
      for(int y = halfKernelMatrixWidth; y < img.height - halfKernelMatrixWidth; y++){
        float sum = 0;
        for(int kernelX = -halfKernelMatrixWidth; kernelX <= halfKernelMatrixWidth; kernelX++){
          for(int kernelY = -halfKernelMatrixWidth; kernelY <= halfKernelMatrixWidth; kernelY++){
            sum += extractVal(img, x + kernelX, y + kernelY) * kernelMatrix[kernelX + 1][kernelY + 1];
          }
        }
        sum = sum / normalization;
        result.pixels[x + y * img.width] = color(sum);
      }
    }  
    result.updatePixels();
    return result;
  }
  
  public float calculatePoint(PImage img, int x, int y){
    float sum = 0;
    for(int kernelX = -halfKernelMatrixWidth; kernelX <= halfKernelMatrixWidth; kernelX++){
      for(int kernelY = -halfKernelMatrixWidth; kernelY <= halfKernelMatrixWidth; kernelY++){
        sum += extractVal(img, x + kernelX, y + kernelY) * kernelMatrix[kernelX + 1][kernelY + 1];
      }
    }
    sum = sum / normalization;
    return sum;
  }
  
  public int extractVal(PImage img, int x, int y){
    return img.pixels[x + y * img.width] & 0xFF;
  }
  
}
  public void settings() {  size(640, 480, P2D); }
}
