import processing.opengl.*;

String DRAWMODE = OPENGL;
int screenWidth = 640, screenHeight = 480;
int brickWidth = 100, brickHeight = 100, brickDepth = 100;

ArrayList balls;
int delay = 0, maxDelay = 10; // Add a new ball every 10 frames
float decay = 5; // percent

void setup() {
  frameRate(30);
  balls = new ArrayList();
  noStroke();
  size(screenWidth, screenHeight, DRAWMODE); 
  colorMode(RGB);
}

void addBall() {
  float red = random(255), green = random(255), blue = random(255), alpha = random(255);
  
  float radius = random(200);
  float x = random(screenWidth - radius*2) + radius;
  float y = random(screenHeight - radius*2) + radius;
  int ballLife = int(random(120))+120;  
  balls.add(new Ball(x, y, radius, red, green, blue, ballLife));
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
    println(b.ballLife+" "+fade);
    fill(b.r, b.g, b.b, fade);
    ellipse(b.x, b.y, b.r, b.r); 
  } 
}

void draw() {
  background(100,100,100);
  
  delay++;
  
  if (delay == maxDelay) {
    addBall();
    delay = 0;
  }
  drawBalls();
}
