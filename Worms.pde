int wurmCount = 50;
int pixelSize = 10;
int spielFeldSize = 10;

boolean recording = false;

Wurm[] worms;
SpielFeld spielFeld;

void setup() {
  frameRate(120);
  size(800, 800, P2D);
  smooth(10);
  background(22, 22, 24);

  setupVariables();
}

void setupVariables() {
  spielFeldSize = width / pixelSize;

  spielFeld = new SpielFeld(spielFeldSize);

  worms = new Wurm[wurmCount];

  placeWormsRandom();
}

void placeWormsRandom() {
  for (int i = 0; i < wurmCount; i++) {

    int x = int(random(0, spielFeldSize));
    int y = int(random(0, spielFeldSize));
    boolean turnLeft = boolean((int)(random(0, 1)));
    Direction direction = directionFromIndex(int(random(0, 3)));

    worms[i] = new Wurm(new Vector(x, y), direction, turnLeft);
  }
}

void setupStroke(color c) {
  stroke(0);
  fill(c);
}

void mouseClicked() {
  spielFeld.setZero();
  placeWormsRandom();
  background(22, 22, 24);
}

void draw() {
  drawWorms();
  makeProgress();
  if (recording) {
    saveFrame("f###.gif");
    if (allWormsDead()) {
      exit();
    }
  }
}

void drawWorms() {
  for (int i = 0; i < wurmCount; i++) {
    Vector wurmPosition = worms[i].getPosition().expectedMultiplyResult(pixelSize);
    setupStroke(worms[i].getColor());
    rect(wurmPosition.X(), wurmPosition.Y(), pixelSize, pixelSize);
  }
}

void makeProgress() {
  moveWorms();
  updateSpielFeld();
}

void moveWorms() {
  for (int i = 0; i < wurmCount; i++) {
    worms[i].makeProgress(spielFeld);
  }
}

void updateSpielFeld() {
  for (int i = 0; i < wurmCount; i++) {
    spielFeld.setFeld(worms[i].getPosition(), true);
  }
}

boolean allWormsDead() {
  for (int i = 0; i < wurmCount; i++) {
    if (worms[i].isAlive()) {
      return false;
    }
  }
  return true;
}
