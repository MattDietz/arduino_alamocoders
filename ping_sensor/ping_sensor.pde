import processing.opengl.*;
import processing.serial.*;

String DRAWMODE = OPENGL;
int screenWidth = 1024, screenHeight = 768;
int brickWidth = 100, brickHeight = 100, brickDepth = 100;

ArrayList balls;
int delay = 0, maxDelay = 3; // Add a new ball every 10 frames
int minBallLife = 120, maxBallLife = 240;
float decay = 5; 

//Everyone loves hard-coded brittle values
String fifoPath = "test_fifo";
String serialName = "/dev/tty.usbserial-A70063hT";
SmartFifo reader; 

void setup() {
  frameRate(30);
  balls = new ArrayList();
  noStroke();
  size(screenWidth, screenHeight, DRAWMODE); 
  colorMode(RGB);
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
    b.ballLife-=decay;
    if (b.ballLife == 0) {
      balls.remove(i);
      continue;
    }
    float fade = (float(b.ballLife) / float(b.maxBallLife))*255.0 + 1;
    fill(b.r, b.g, b.b, fade);
    ellipse(b.x, b.y, b.radius, b.radius); 
  } 
}

void draw() {
  background(100,100,100);
  
  delay++;
  
  if (delay == maxDelay) {
    float input = readInput();
    if (input > -1)
      addBall(input);
    delay = 0;
  }
  drawBalls();
}
