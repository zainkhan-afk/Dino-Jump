class Characters {
  int ctr;
  float gravity, jumpForce, velocity;
  float x, y;
  float cactiX, cactiY;
  float birdX, birdY;
  float dinoW, dinoH;
  float cactiSize;
  float floor;
  float groundLine;
  boolean jump, reached, crouch, dead;
  float r;
  int count;
  float score;
  Brain b = new Brain();
  Characters() {
    dead = false;
    score = 0;
    ctr = 0;
    gravity = 2;
    jumpForce = -3;
    velocity = 0;
    cactiSize = 50;
    x = width/7;
    y = bg.ground - scale*dino[0].height;
    floor = y;
    groundLine = bg.ground;
    jump = false;
    crouch = false;
    birdX = width;
    birdY = height/2;
    count = 0;
    r = random(0, 1);
  }

  void drawCharacters() {
    float vertPos = y - e.eY;
    if(vertPos>0){
      vertPos = 1;
    } else if(vertPos<0){
      vertPos = -1;
    } else{
      vertPos = 0;
    }
    int dec = b.think(e.eX/width, e.eY/height, y/height, vertPos, (e.eX-x)/width);
    if ( dec == 1) {
      jump = true;
    } else if( dec == 2) {
      crouch = true;
    }
    drawdino();
    collisionDet();

    ctr++;
    if (ctr == 2) {
      ctr = 0;
    }
  }

  void drawdino() {
    if (!jump && !crouch) {
      if (ctr == 0) {
        y = bg.ground - scale*dino[0].height;
        dinoW = scale*dino[0].width;
        dinoH = scale*dino[0].height;
        image(dino[0], x, y, dinoW, dinoH);
      } else if (ctr == 1) {
        y = bg.ground - scale*dino[1].height;
        dinoW = scale*dino[1].width;
        dinoH = scale*dino[1].height;
        image(dino[1], x, y, dinoW, dinoH);
      }
    } else if ( crouch) {
      if (ctr == 0){
        y = bg.ground - scale*dino[4].height;
        dinoW = scale*dino[4].width;
        dinoH = scale*dino[4].height;
        image(dino[4], x, y, dinoW, dinoH);
      } else if (ctr == 1){
        y = bg.ground - scale*dino[5].height;
        dinoW = scale*dino[5].width;
        dinoH = scale*dino[5].height;
        image(dino[5], x, y, dinoW, dinoH);
      }
      count++;
      if (count == 20) {
        y = height - 2*bg.wallSize - 90;
        crouch = false;
        count = 0;
      }
    } else {
      jump();
    }
    if (!dead) {
      score += bg.BGVel/20;
    }
  }

  void jump() {
    float forceToAdd = 0;
    if (!reached) {
      forceToAdd = jumpForce;
    } else {
      forceToAdd = gravity;
    }
    y += velocity;
    velocity += forceToAdd;
    dinoW = scale*dino[2].width;
    dinoH = scale*dino[2].height;
    image(dino[2], x, y, dinoW, dinoH);
    if (y>= 0 && y <= 260) {
      reached = true;
    } else if (y > floor) {
      y = floor;
      reached = false;
      jump = false;
      velocity = 0;
    }
  }

  void collisionDet() {
    if (x > e.cactiX && x < e.cactiX + e.cactiW || x + dinoW>e.cactiX && x + dinoW < e.cactiX + e.cactiW) {
      if (e.cactiY < y + dinoH) {
        dead =  true;
        reached = false;
      }
    }

    if (x > e.birdX && x < e.birdX + e.birdW || x + dinoW>e.birdX && x + dinoW < e.birdX + e.birdW) {
      if (e.birdY < y + dinoH && e.birdY + e.birdW > y + dinoH || e.birdY + e.birdW > y && e.birdY < y) {
        dead =  true;
        reached = false;
      }
    }
  }

  void dead() {
    float forceToAdd = 0;
    forceToAdd = jumpForce+1;
    forceToAdd = gravity+0.5;
    y += velocity;
    velocity += forceToAdd;
    image(dino[3], x, y, 45, 45);
    if (y>= 0 && y <= 240) {
      reached = true;
    } else if (y > height) {
      velocity = 0;
    }
  }
  
  void mutate() {
    for (int o = 0; o<b.outputs; o++) {
      for (int i = 0; i<b.inputs; i++) {
        if (random(0, 1)<mutationRatio) {
          b.weights[i][o] = random(-1, 1);
          break;
        }
      }
    }
  }
};
