//WMCI COMPSCI 20
//Dec 5th 2017
//MARIO PLATFORMER
//Muhammad Haris && Ryan McMurtry
//Muhammad did the Mario Object
//Ryan did the Goomba Object
//We collectivly did the colliding with grid and text files
//Only thing that needs to be fixed is having it so that when your on a coin the coin stays off the screen

char[][] tiles;
PImage levelBackground;
PImage platform, coin, box, goomba, p1, slime, empty, p2, p3, cloud;
int tilesHigh, tilesWide, x, y, n;
float tileWidth, tileHeight, lastMove, delay, fallSpeed, gravity, dy, jumpSpeed, goomMove;
String bgImage, levelToLoad;
boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft;
//import processing.sound.*;
//SoundFile music;
boolean gpaused;

int state = 0;
float w = 150;
float h = 80;
float buttX;
float buttY;

float buttX2;
float buttY2;

Goomba goomba1;
Mario mario;
LoadLevel level;
Mainmenu homeScreen;
//Sets background and calls on the mario and goomba functions
void setup() {
  size(720, 700);  
  bgImage = "level_background.png";

  buttX = width/2-75;
  buttY = height/2-40;
  buttY2 = height/2+150;
  buttX2 =width/2-75;
  gpaused = false;

  //music = new SoundFile(this, "music.mp3");
  //music.loop();

  initializeValues();
  mario = new Mario();
  goomba1 = new Goomba();
  level = new LoadLevel();
    homeScreen = new Mainmenu();
}

//Moves mario and the Goomba and checks to see what they are colliding with on the grid

void draw() {
  if (state == 0) {
  homeScreen.menu();
  }
  if (state == 2) {
    dead();
  }
  if (state == 3){
   instructions(); 
  }
  if ((state == 1)&& (gpaused == false)) {
    display();

    mario.move();
    mario.collidingWithGrid();


    goomba1.grid();
    goomba1.enemy();
    goomba1.test(mario);
    
    level.test(mario);
  }
  if ((gpaused == true)&& (state == 1)) {
    pause();
  }
}

//moves Mario
void keyPressed() {
  mario.keypressed();
    if (key == 'p' || key == 'P') {

    gpaused = !gpaused;
      
    if (state == 3){
     state = 0; 
    }
  }
}

void keyReleased() {
  mario.keyreleased();
}

//loads all the images used 
void initializeValues() {
  loadImages();
  loadLevel();

}

void pause() {
  fill(200, 200, 200, 1);
  rect(0, 0, width, height);
  fill(0);
  text("Paused", width/2-70, height/2);
    text("Press P to unpause", width/2-150, height/2+100);
  
}

//Instruction screen
void instructions(){
  background(255);
  fill(0);
  rect(100,100,width-200,height-200);
  fill(255);
  text("Controls", 300,200);
  textSize(20);
  text("WASD - to move", 150, 250);
  text("P - pause and unpause and go back",150, 300);
  textSize(32);
}

//Pause and start screen
void mainScreen() {

  if (state == 0) {
  image(levelBackground, 0, 0, width, height);
    fill(0);
    text("Super Moria", width/2-120, height/2-100);
    rect(buttX, buttY, w, h);
    rect(buttX2, buttY2,w,h);
    fill(255);
    textSize(40);
    text("Start", width/2-45, height/2);
    textSize(30);
    text("Instruction", width/2-80, height/2+190);

    if (mousePressed) {
      if (mouseX>buttX && mouseX <buttX+w && mouseY>buttY && mouseY <buttY+h) {
        state = 1;
      }
      if (mouseX>buttX2 && mouseX <buttX2+w && mouseY>buttY2 && mouseY <buttY2+h) {
        state = 3;
      }
    }
  }
}

void dead(){
  background(0);
  text("you dead", width/2-100, height/2);
  
}

//displays the background and places all the blocks
void display() {
  image(levelBackground, 0, 0, width, height);

  for (int y = 0; y < tilesHigh; y++) {
    for (int x = 0; x < tilesWide; x++) {
      showTile(tiles[x][y], x, y);

    }
  }
}

//assignes symbols to pictures
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
  } else if (location == '.') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
}

//loads Images
void loadImages() {
  //load background
  levelBackground = loadImage(bgImage);

  //load tile images
  platform = loadImage("platform.png");
  coin = loadImage("coin.png");
  box = loadImage("box.jpg");
  goomba = loadImage("goomba.png");
  slime = loadImage("slime.png");
  cloud = loadImage("cloud.png");
  empty = loadImage("empty.png");
}
  void loadLevel(){
  
  levelToLoad = "levels/1.txt";
  String lines[] = loadStrings(levelToLoad);

  tilesHigh = lines.length;
  tilesWide = lines[0].length();

  tileWidth = width/tilesWide;
  tileHeight = height/tilesHigh;
  tiles = new char[tilesWide+10][tilesHigh+10];
  for (int y = 0; y < tilesHigh; y++) {
    for (int x = 0; x < tilesWide; x++) {
      char tileType = lines[y].charAt(x);
      tiles[x][y] = tileType;
    }
  }
    tileWidth = width/tilesWide;
    tileHeight = height/tilesHigh;
  }