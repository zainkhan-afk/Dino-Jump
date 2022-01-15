PImage[] dino = new PImage[6];
PImage[] cacti = new PImage[3];
PImage[] bird = new PImage[2];
PImage pipeHead, pipeBody, wall, ground, cloud;

int pop = 250;
float mutationRatio = 0.1;
int gen = 0;
float scale = 0.4;
float fittestScore = 0;

Background bg;
Characters[] m = new Characters[pop];
Enemies e;
void setup() {
  size(800, 500);
  frameRate(30);
  dino[0] = loadImage("data/dinorun0000.png");
  dino[1] = loadImage("data/dinorun0001.png");
  dino[2] = loadImage("data/dinoJump0000.png");
  dino[3] = loadImage("data/dinoDead0000.png");
  dino[4] = loadImage("data/dinoduck0000.png");
  dino[5] = loadImage("data/dinoduck0001.png");

  cacti[0] = loadImage("data/cactusBig0000.png");
  cacti[1] = loadImage("data/cactusSmall0000.png");
  cacti[2] = loadImage("data/cactusSmallMany0000.png");

  bird[0] = loadImage("data/berd.png");
  bird[1] = loadImage("data/berd2.png");
  bg = new Background();
  for (int i = 0; i<pop; i++) {
    m[i] = new Characters();
  }
  e = new Enemies();
}

void draw() {
  background(255);      
  int dead = 0;
  bg.drawBG();
  showScore();
  e.drawEnemy();
  for (int i = 0; i<pop; i++) {
    if (!m[i].dead) {
      m[i].drawCharacters();
    } else {
      m[i].dead();
      dead++;
    }
  }

  if (dead == pop) {
    gen++;
    int fittest = findFittest();
    copyFittest(fittest);
    mutate();
    for (int p = 0; p<pop; p++) {
      m[p] = new Characters();
    }
    e = new Enemies();
    bg = new Background();
    fittestScore = 0;
  }
}

void showScore() {
  textSize(20);
  fill(0);
  text("Score: ", 10, 20);
  int fit = findFittest();
  fittestScore = m[fit].score;
  text("Generation: ", 300, 20);
  text(gen, 450, 20);
  text(int(m[fit].score), 80, 20);
  if (m[fit].score == 100) {
    bg.BGVel += 0.5;
  }
}

int findFittest() {
  int fittest = 0;
  float highest = m[fittest].score;
  for (int i = 0; i<pop; i++) {
    if (m[i].score>highest) {
      highest = m[i].score;
      fittest = i;
    }
  }
  return fittest;
}

void copyFittest(int fittest) {
  for (int p = 0; p<pop; p++) {
    for (int o = 0; o<m[0].b.outputs; o++) {
      for (int i = 0; i<m[0].b.inputs; i++) {
        m[p].b.weights[i][o]= m[fittest].b.weights[i][o];
      }
    }
  }
}

void mutate() {
  for (int p = 1; p<pop; p++) {
    m[p].mutate();
  }
}
