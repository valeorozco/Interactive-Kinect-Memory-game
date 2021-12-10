import org.openkinect.processing.*;

// Kinect Library object
Kinect kinect;

float minThresh = 480;
float maxThresh = 830;
PImage img;

void setup() {
  size(512, 424);
  kinect = new Kinect(this);
  kinect.initDepth();
  img = createImage(kinect.width, kinect.height, RGB);
}


void draw() {
  background(0);

  img.loadPixels();


  //change threshold with mouse
  //minThresh = map(mouseX, 0, width, 0, 4500);
  //maxThresh = map(mouseY, 0, height, 0, 4500);

  // Get the raw depth as array of integers
  int[] depth = kinect.getRawDepth();

  float sumX = 0;
  float sumY = 0;
  float totalPixels = 0;

  for (int x = 0; x < kinect.width; x++) {
    for (int y = 0; y < kinect.height; y++) {
      int offset = x + y * kinect.width;
      int d = depth[offset];

      if (d > minThresh && d < maxThresh && x > 100) {
        img.pixels[offset] = color(255, 0, 150);

        sumX += x;
        sumY += y;
        totalPixels++;
      } else {
        img.pixels[offset] = color(0);
      }
    }
  }

  img.updatePixels();
  image(img, 0, 0);

  //avarage tracking point
  float avgX = sumX / totalPixels;
  float avgY = sumY / totalPixels;
  fill(150, 0, 255);
  ellipse(avgX, avgY, 64, 64);

  fill(255);
  textSize(32);
  text(minThresh + " " + maxThresh, 10, 64);
}

//change threshold minimum with a & s and threshold minimum with z & x
  void keyReleased() {
    if (key == 'a') {
      minThresh = constrain(minThresh+10, 0, maxThresh);
    } else if (key == 's') {
      minThresh = constrain(minThresh-10, 0, maxThresh);
    } else if (key == 'z') {
      maxThresh = constrain(maxThresh+10, minThresh, 2047);
    } else if (key =='x') {
      maxThresh = constrain(maxThresh-10, minThresh, 2047);
    }
  }
