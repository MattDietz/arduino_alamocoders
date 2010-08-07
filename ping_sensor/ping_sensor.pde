import processing.opengl.*;
import processing.serial.*;

String DRAWMODE = OPENGL;
int screenWidth = 640, screenHeight = 480;
int brickWidth = 100, brickHeight = 100, brickDepth = 100;

ArrayList balls;
int delay = 0, maxDelay = 10; // Add a new ball every 10 frames
float decay = 5; // percent

String fifoPath = "test_fifo";
RandFifo reader; 

void setup() {
  frameRate(30);
  balls = new ArrayList();
  noStroke();
  size(screenWidth, screenHeight, DRAWMODE); 
  colorMode(RGB);
  
  reader = new RandFifo(fifoPath);    
}

void addBall(float magnitude) {
  float red = random(255), green = random(255), blue = random(255);
  
  float radius = magnitude;
  float x = random(screenWidth - radius*2) + radius;
  float y = random(screenHeight - radius*2) + radius;
  int ballLife = int(random(120))+120;  
  // Ball(float x, float y, float radius, float r, float g, float b, int ballLife)
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
    b.ballLife--;
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
