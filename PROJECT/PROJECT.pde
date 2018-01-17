//WMCI COMPSCI 20
//Dec 5th 2017
//MARIO PLATFORMER
//Muhammad Haris && Ryan McMurtry

char[][] tiles;
PImage levelBackground;
PImage platform,goomba, slime, empty,dirt,brick, coin,box, eraser,gameover,playagain,deathScreen;
int tilesHigh, tilesWide, x, y, n;
float tileWidth, tileHeight, lastMove, delay, fallSpeed, gravity, dy, jumpSpeed, goomMove;
String bgImage, levelToLoad;
boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft;
//import processing.sound.*;
//SoundFile music;
boolean gpaused,save,load;
int block;



int state = 0;
float w = 150;
float h = 80;
float buttX;
float buttY;

float buttX2;
float buttY2;


PFont font;

Goomba goomba1;
Mario mario;
Mainmenu homeScreen;
Coin mCoin;
Mystery_Block mBlock;
RegularBrick mBrick;

LevelEditor levelEdit;

BlockSelect platformS;
BlockSelect boxS;
BlockSelect coinS;
BlockSelect eraserS;

Button loadButton;
Button saveButton;
Button playagainS;
Button levelEditor;
//Sets background and calls on the mario and goomba functions
void setup() {
  size(720, 700);  
  //fullScreen();
  bgImage = "level_background.png";

  font = createFont("joystik.ttf",20);

  buttX = width/2-75;
  buttY = height/2-40;
  buttY2 = height/2+150;
  buttX2 =width/2-75;
  gpaused = false;

//  music = new SoundFile(this, "song.mp3");
//  music.loop();

  initializeValues();

  mario = new Mario();
  goomba1 = new Goomba();
  homeScreen = new Mainmenu();
  mCoin = new Coin();
  mBlock = new Mystery_Block();
  mBrick = new RegularBrick();
  loadLevel(mario.n);
  
    playagainS = new Button("Play Again", width/2 - 60, height/2+80, 50,50,3,2);
    levelEdit = new LevelEditor();
    saveButton = new Button("SAVE",200,620,100,50,1,1);
    loadButton = new Button("LOAD",400,620,100,50,2,1);
    levelEditor = new Button("Level Editor", 580,580, 100,20,4,2);
    coinS = new BlockSelect(coin,630,300,30,30,3);
    boxS = new BlockSelect(box,630,350,30,30,2);
    platformS = new BlockSelect(platform,630,250,30,30,4);
    eraserS = new BlockSelect(eraser, 630,200,30,30,5);
}

//Moves mario and the Goomba and checks to see what they are colliding with on the grid

void draw() {
  mCoin.onCoin();
  if (state == 0) {
    homeScreen.menu();
  }
  if (state == 2) {
    dead();
  }
  if (state == 3) {
    instructions();
  }
  if ((state == 1)&& (gpaused == false)) {
    display();
    
    mCoin.displayPoints();

    mario.move();
    mario.collidingWithGrid();

    goomba1.spawn();
    goomba1.attacked();
    goomba1.attacking();
    goomba1.grid();
    goomba1.enemy();
    
    mBlock.marioHittingBlock();
    
    mBrick.marioHittingBrick();
    mBrick.rectangle();
  }
      if (state == 4){
    background(0);
    saveButton.Draw();
    loadButton.Draw();
    saveButton.clicked();
    loadButton.clicked();
    coinS.Draw();
    platformS.Draw();
    boxS.Draw();
    eraserS.Draw();
    platformS.clicked();
    coinS.clicked();
    boxS.clicked();
    eraserS.clicked();
    levelEdit.makeGrid();
    levelEdit.placeBlock();
    levelEdit.displayGrid();
    levelEdit.saveButton();
  }
  
  if ((gpaused == true)&& (state == 1)) {
    pause();
  }
}

//moves Mario
void keyPressed() {
  mario.keypressed();
  mBrick.keypressed();
  if (key == 'p' || key == 'P') {

    gpaused = !gpaused;

    if (state == 3) {
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
  delay = 150;
  lastMove = millis();
}

void pause() {
  fill(200, 200, 200, 1);
  rect(0, 0, width, height);
  fill(0);
  text("Paused", width/2-70, height/2);
  text("Press P to unpause", width/2-150, height/2+100);
}

//Instruction screen
void instructions() {
  background(255);
  fill(0);
  rect(100, 100, width-200, height-200);
  fill(255);
  text("Controls", 300, 200);
  textSize(20);
  text("WASD - to move", 150, 250);
  text("P - pause and unpause and go back", 150, 300);
  textSize(32);
}

//Pause and start screen
void mainScreen() {

  if (state == 0) {
    image(levelBackground, 0, 0, width, height);
    fill(0);
    text("Super Moria", width/2-120, height/2-100);
    rect(buttX, buttY, w, h);
    rect(buttX2, buttY2, w, h);
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

void dead() {
  image(deathScreen,0,0,width,height);
  textFont(font);
  textAlign(CENTER,CENTER);
    playagainS.Draw();
  playagainS.clicked();

  textSize(50);
  text("GAMEOVER", width/2,height/2-200);

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
  mCoin.displayCoin(location, int(x*tileWidth), int(y*tileHeight));
  mBlock.display(location, int(x*tileWidth), int(y*tileHeight));
  mBrick.display(location, int(x*tileWidth), int(y*tileHeight));
 if (location == 'F') {
    image(goomba, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'S') {
    image(slime, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == '.') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
  else if (location == 'D') {
    image(dirt, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
  else if (location == 'Y') {
    image(brick, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
}

//loads Images
void loadImages() {
  //load background
  levelBackground = loadImage(bgImage);

  //load tile images
  platform = loadImage("platform.png");
  goomba = loadImage("goomba.png");
  slime = loadImage("slime.png");
  empty = loadImage("empty.png");
  dirt = loadImage("dirt.png");
  brick = loadImage("brick.png");
  
    coin = loadImage("coin0.png");
  box = loadImage("box.jpg");
  
  
  eraser = loadImage("Eraser.png");
  gameover = loadImage("gameover.png");
  playagain = loadImage("playagain.png");
  deathScreen = loadImage("deathScreen.jpg");
}

//Loading Levels
void loadLevel(int n) {
  levelToLoad = "levels/"+n+".txt";
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