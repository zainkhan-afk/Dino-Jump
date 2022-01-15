class Background {
  float wallSize;
  float cloudX, cloudY;
  float pipeX, pipeY;
  float BGVel;
  float n = 0;
  float ground;
  Background() {
    wallSize = 60;
    cloudX = width;
    cloudY = random(0, height/3);
    pipeX = width;
    pipeY = random(height/3, height/2);
    BGVel = 10;
    ground = height/1.5 - 1;
  }

  void drawBG() {
    drawGround();
  }

  void drawGround() {
    stroke(0);
    line(0, ground, width, ground);
  }

};
