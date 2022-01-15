class Enemies {
  float cactiX, cactiY;
  float birdX, birdY;
  float cactiH, cactiW;
  float birdH, birdW;
  int count, ctr;
  float r;
  float floor;
  float eX;
  float eY;
  Enemies() {
    cactiX = width;
    birdX = width;
    birdY = height/2.5;
    count = 0;
    ctr = 0;
    r = random(0, 1);
    eX = 0;
    eY = 0;
  }

  void drawEnemy() {
    if(fittestScore>10 && cactiX == width){
      if ( r>=0.5) {
        drawcacti();
        eX = cactiX;
        eY = cactiY;
      } else if (r<0.5) {
        drawbird();
        eX = birdX;
        eY = birdY;
      }
    }
    else{
      drawcacti();
      eX = cactiX;
      eY = cactiY;
    }
    ctr++;
    if(ctr == 3){
      ctr = 0;
    }
  }

  void drawcacti() {
    if (r<0.66) {
      cactiY = height - bg.ground/2 - (scale-0.1)*cacti[0].height;
      cactiW = (scale-0.1)*cacti[0].width;
      cactiH = (scale-0.1)*cacti[0].height;
      image(cacti[0], cactiX, cactiY, cactiW, cactiH);
    } else if(r>=0.66 && r<0.833) {
      cactiY = height - bg.ground/2 - scale*cacti[1].height;
      cactiW = scale*cacti[1].width;
      cactiH = scale*cacti[1].height;
      image(cacti[1], cactiX, cactiY, cactiW, cactiH);
    } else {
      cactiY = height - bg.ground/2 - scale*cacti[2].height;
      cactiW = scale*cacti[2].width;
      cactiH = scale*cacti[2].height;
      image(cacti[2], cactiX, cactiY, cactiW, cactiH);
    }
    cactiX -= bg.BGVel+5;

    if (cactiX<=-cactiW) {
      cactiX = width;
      r = random(0, 1);
    }
  }

  void drawbird() {
    if(ctr == 0){
      birdH = scale*bird[0].height;
      birdW = scale*bird[0].width;
      image(bird[0], birdX, birdY, birdW, birdH);
    } else{
      birdH = scale*bird[1].height;
      birdW = scale*bird[1].width;
      image(bird[1], birdX, birdY, birdW, birdH);
    }
    birdX -= bg.BGVel+5;

    if (birdX<=-50) {
      birdX = width;
      float temp = floor(random(0, 2));
      if(temp == 0){
        birdY = height/2.5;
      } else if(temp == 1){
        birdY = height/1.92;
      }
      r = random(0, 1);
    }
  }
};
