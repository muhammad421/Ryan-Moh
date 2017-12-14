char[][] tiles;
PImage levelBackground;
PImage platform, coin, box, goomba, p1, slime, empty, p2, p3, cloud;
int tilesHigh, tilesWide, x, y, n, newY;
float tileWidth, tileHeight, lastMove, delay, fallSpeed, gravity, dy, jumpSpeed, goomMove;
String bgImage, levelToLoad;
boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft;

void setup() {
  size(720, 700);  
  bgImage = "level_background.png";

  initializeValues();
  y= int (height - 2*tileHeight);
}

void draw() {
  display();
  mario();
  collidingWithGrid();
}

void mario() {
  //mario moving
  if (marioUp == true) {
    jumping = true;
  }
  if (jumping == true) {
    jump();
  }
  if (marioLeft == true) {
    x+=tileWidth/2;
    walking();
  }
  if (marioRight == true) {
    x-=tileWidth/2;
    walking();
  }
  // next level
  if (x>width) {
    n++;
    x=0;
  } else if (x<0&&(n!=0)) {
    n--;
    x=(width);
  } else if (y>height) {
    y=0;
  } else if (y<0) {
    y=int(height-2*tileWidth);
  } else if (n == 3) {
    n = 0;
  } else if (  x<0 && (n==0)) {
    x = width;
  }
  //Walking on brick
  if (isWalking == false) {
    image(p3, x, y, tileWidth, tileHeight);
  } else {
    image(p2, x, y, tileWidth, tileHeight);
  }
}

void walking() {
  if (millis() > lastMove + delay) {
    isWalking = !isWalking;
    lastMove = millis();
  }
}

void initializeValues() {
  falling = false;
  jumping = false;
  jumpSpeed = 0;
  fallSpeed = 0;
  marioUp = false;
  marioLeft = false;
  marioRight = false;
  gravity = 5;

  x =0;
  newY = 0;
  n=0;
  isWalking = false;
  isMoving =false;
  onGround = true;
  canIJump = true;
  loadImages();
  delay = 100;
  lastMove = millis();
  levelToLoad = "levels/"+n+".txt";
  //load level data
  String lines[] = loadStrings(levelToLoad);

  tilesHigh = lines.length;
  tilesWide = lines[0].length();

  tileWidth = width/tilesWide;
  tileHeight = height/tilesHigh;

  //println(tilesHigh, tilesWide);

  tiles = new char[tilesWide+10][tilesHigh+10];

  //put values into 2d array of characters
  for (int y = 0; y < tilesHigh; y++) {
    for (int x = 0; x < tilesWide; x++) {
      char tileType = lines[y].charAt(x);
      tiles[x][y] = tileType;
    }
  }
}

void display() {
  image(levelBackground, 0, 0, width, height);

  for (int y = 0; y < tilesHigh; y++) {
    for (int x = 0; x < tilesWide; x++) {
      showTile(tiles[x][y], x, y);
    }
  }
}

void showTile(char location, int x, int y) {
  if (location == '#') {
    image(platform, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'C') {
    image(coin, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'B') {
    image(box, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'F') {
    image(goomba, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'P') {
    image(p1, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'S') {
    image(slime, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
}

void collidingWithGrid() {
  if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]=='#'&&((y/tileHeight)+1)!=19) {
    falling = false;
    jumping = false;
    newY = y;
  } else if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]!='#'&&((y/tileHeight)+1)!=19) {
    y += 2*gravity;
  } else if (tiles[int(x/tileWidth)][int(y/tileHeight)-1]=='#') {
  } else if (tiles[int(x/tileWidth)][int(y/tileHeight)-1]!='#') {
  }
}

void loadImages() {
  //load background
  levelBackground = loadImage(bgImage);

  //load tile images
  platform = loadImage("platform.png");
  coin = loadImage("coin.png");
  box = loadImage("box.jpg");
  goomba = loadImage("goomba.png");
  p1 = loadImage("p1.png");
  p2 = loadImage("p2.png");
  p3 = loadImage("p3.png");
  slime = loadImage("slime.png");
  cloud = loadImage("cloud.png");
}
void jump() {
  y -=tileHeight;
  if ((y-tileHeight)<y) {
    falling = true;
  }
  if (falling == true) {
    gravity();
  }
}
void gravity() {
  y =int( y + jumpSpeed);
  jumpSpeed = jumpSpeed + gravity;
  if (y >=630) {
    jumping = false;
    falling = false;
    jumpSpeed = 0;
    y = 630;

  }
  //if (y != 630){
  //  y= newY;
  //}
}
void keyPressed() {

  if (key == 'w' || key == 'W') {
    marioUp = true;
  } 
  if (key== 'a' || key=='A') {
    marioRight = true;
  }  
  if (key== 'd' || key=='D') {
    marioLeft = true;
  }
}
void keyReleased() {

  if (key == 'w' || key == 'W') {
    marioUp = false;
  } 
  if (key== 'a' || key=='A') {
    marioRight = false;
  }
  if (key== 'd' || key=='D') {
    marioLeft = false;
  }
}