//WMCI COMPSCI 20
//Dec 5th 2017
//MARIO PLATFORMER
//Muhammad Haris && Ryan McMurtry

//Setting global Variables
char[][] tiles;
PImage platform, empty, dirt, brick, coin, box, eraser, deathScreen, mainScreen,levelBackground;
int tilesHigh, tilesWide, x, y, n, block, state;
float tileWidth, tileHeight;
String bgImage, levelToLoad;
boolean gpaused, save, load;
PFont font;

//UnComment to turn music on.
//import processing.sound.*;
//SoundFile music;

//Calling Goomba
Goomba goomba1;

//Calling Mario
Mario mario;

//Creating the HomeScreen
Mainmenu homeScreen;

//Creating Coins
Coin mCoin;

//Creating bricks
Mystery_Block mBlock;
RegularBrick mBrick;

//Creating the Level Editor
LevelEditor levelEdit;

//Allows you to choose the required blocks
BlockSelect platformS;
BlockSelect boxS;
BlockSelect coinS;
BlockSelect eraserS;
BlockSelect dirtS;
BlockSelect blockS;

//Creates the button
Button backButton;
Button loadButton;
Button saveButton;
Button playagainS;
Button levelEditor;
//Sets background and calls on the mario and goomba functions
void setup() {
  size(720, 700);  



  initializeValues();

}

//Moves mario and the Goomba and checks to see what they are colliding with on the grid

void draw() {
  mCoin.onCoin();
  if (state == 0||state==6) {

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
  }
  if (state == 4) {
    image(mainScreen, 0, 0, width, height);
    saveButton.Draw();
    loadButton.Draw();
    saveButton.clicked();
    loadButton.clicked();


    coinS.Draw();
    platformS.Draw();
    boxS.Draw();
    eraserS.Draw();
    dirtS.Draw();
    blockS.Draw();


    platformS.clicked();
    coinS.clicked();
    boxS.clicked();
    eraserS.clicked();
    dirtS.clicked();
    blockS.clicked();

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
    bgImage = "level_background.png";

  font = createFont("joystik.ttf", 20);
  gpaused = false;

  //  music = new SoundFile(this, "song.mp3");
  //  music.loop();

  //music = new SoundFile(this, "song.mp3");
  //music.loop();
  
  loadImages();
  
  state = 0;
  mario = new Mario();
  goomba1 = new Goomba();
  homeScreen = new Mainmenu();
  mCoin = new Coin();
  mBlock = new Mystery_Block();
  mBrick = new RegularBrick();
  loadLevel(mario.n);

  playagainS = new Button("Play Again", width/2 - 60, height/2+80, 50, 50, 3);
  levelEdit = new LevelEditor();
  saveButton = new Button("SAVE", 200, 620, 100, 50, 1);
  loadButton = new Button("LOAD", 400, 620, 100, 50, 2);
  levelEditor = new Button("Level Editor", 580, 580, 100, 20, 4);
  backButton = new Button("BACK", 10, 10, 30, 30, 5);

  coinS = new BlockSelect(coin, 630, 150, 30, 30, 3);
  boxS = new BlockSelect(box, 630, 200, 30, 30, 2);
  platformS = new BlockSelect(platform, 630, 100, 30, 30, 4);
  eraserS = new BlockSelect(eraser, 630, 500, 30, 30, 1);
  dirtS = new BlockSelect(dirt, 630, 50, 30, 30, 5);
  blockS = new BlockSelect(brick, 630, 250, 30, 30, 6);
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
  image(deathScreen, 0, 0, width, height);
    backButton.Draw();
  backButton.clicked();
  text("Controls", width/2, 150);
  textSize(20);
  text("WASD - to move", width/2, 250);
  text("P - PAUSE AND UNPAUSE", width/2, 300);
  textSize(32);

}

//Pause and start screen


void dead() {
  image(deathScreen, 0, 0, width, height);
  textFont(font);
  textAlign(CENTER, CENTER);
  playagainS.Draw();
  playagainS.clicked();

  textSize(50);
  text("GAMEOVER", width/2, height/2-200);
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
  if (location == '.') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'D') {
    image(dirt, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'Y') {
    image(brick, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } 
}

//loads Images
void loadImages() {
  //load background
  levelBackground = loadImage(bgImage);

  //load tile images
  platform = loadImage("platform.png");
  empty = loadImage("empty.png");
  dirt = loadImage("dirt.png");
  brick = loadImage("brick.png");

  coin = loadImage("coin0.png");
  box = loadImage("box.jpg");


  eraser = loadImage("Eraser.png");
  deathScreen = loadImage("deathScreen.jpg");
  mainScreen = loadImage("mainscreen.jpg");
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