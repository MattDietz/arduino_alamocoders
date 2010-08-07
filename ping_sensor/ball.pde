class Ball {
  float x, y, r, g, b, radius; 
  int ballLife, maxBallLife;
  
  Ball(float x, float y, float radius, float r, float g, float b, int ballLife) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.g = g;
    this.b = b;
    this.radius = radius;
    this.ballLife = ballLife;
    this.maxBallLife = ballLife;
  }
}
