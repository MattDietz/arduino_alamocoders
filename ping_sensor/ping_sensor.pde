import processing.opengl.*;
import processing.serial.*;

//Drawing mode and window size
String DRAWMODE = OPENGL;
int screenWidth = 1024, screenHeight = 768;

//My balls
ArrayList balls;


//How many frames do we wait until we read from the Serial port?
//Hacky but seems to match well with the output rate of the Arduino
int delay = 0, maxDelay = 3;

//Lifetime of the ball. 
int minBallLife = 120, maxBallLife = 240;

//Decay amount by frame. ball.ballLife / decay = Life in Frames
float decay = 5; 

//Everyone loves hard-coded brittle values
String fifoPath = "test_fifo";
String serialName = "/dev/tty.usbserial-A70063hT";
SmartFifo reader; 

void setup() {
  //Attempt to lock in at 30fps. Not guaranteed. YMMV
  frameRate(30);
  balls = new ArrayList();
  
  //Don't draw outlines on the circles. Get your mind out of the gutter
  noStroke();
  size(screenWidth, screenHeight, DRAWMODE); 
  colorMode(RGB);
  
  //Hacky data generator
  reader = new SmartFifo(this, serialName, fifoPath);    
}

void addBall(float magnitude) {
  float red = random(255), green = random(255), blue = random(255);
  
  float radius = magnitude;
  
  float x = random(screenWidth - radius/2) + radius/2;
  float y = random(screenHeight - radius/2) + radius/2;
 
  int ballLife = int(random(minBallLife))+maxBallLife;  
  balls.add(new Ball(x, y, radius, red, green, blue, ballLife));
}

//Returns magnitude
float readInput() {
  int input = -1;

  input = reader.read();
  
  return float(input);
}

void drawBalls() {
  for (int i = balls.size() - 1; i > 0; --i) {
    Ball b = (Ball)balls.get(i);
    
    //Is the ball dead?
    b.ballLife-=decay;
    if (b.ballLife == 0) {
      balls.remove(i);
      continue;
    }
    
    //Get the scaled alpha for the ball based on percentage life time remaining.
    float alphaFade = (float(b.ballLife) / float(b.maxBallLife))*255.0 + 1;
    fill(b.r, b.g, b.b, alphaFade);
    
    //Draw dat thang
    ellipse(b.x, b.y, b.radius, b.radius); 
  } 
}

void draw() {
  //Darkish gray?
  background(100,100,100);
  
  delay++;
  
  if (delay == maxDelay) {
    float input = readInput();
    if (input > 0)
      addBall(input);
    delay = 0;
  }
  drawBalls();
}
