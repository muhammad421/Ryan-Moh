import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class PROJECT extends PApplet {

//WMCI COMPSCI 30
//January 18th 2018
//MARIO PLATFORMER
//Muhammad Haris && Ryan McMurtry

//Setting global Variables
char[][] tiles;
PImage platform, empty, dirt, brick, coin, box, eraser, deathScreen, mainScreen, levelBackground, pole;
int tilesHigh, tilesWide, x, y, n, block, state, counter;
float tileWidth, tileHeight;
String bgImage, levelToLoad;
boolean gpaused, save, load;
PFont font;

//UnComment Lines 17,18 and 158 -162 to play music

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
BlockSelect poleS;

//Creates the button
Button backButton;
Button loadButton;
Button saveButton;
Button playagainS;
Button levelEditor;

//Sets values and screensize
public void setup() {
    
  initializeValues();
}

//Moves mario and the Goomba and checks to see what they are colliding with on the grid
public void draw() {
  mCoin.onCoin();

  //Mainmenu
  if (state == 0) {

    homeScreen.menu();
  }

  //Death screen
  if (state == 2) {
    dead();
  }

  //Instructions page  
  if (state == 3) {
    instructions();
  }

  //Main game loops
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

  //Level editor display  
  if (state == 4) {
    background(0xff3FBFFF);
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
    poleS.Draw();


    platformS.clicked();
    coinS.clicked();
    boxS.clicked();
    eraserS.clicked();
    dirtS.clicked();
    blockS.clicked();
    poleS.clicked();

    levelEdit.makeGrid();
    levelEdit.placeBlock();
    levelEdit.displayGrid();
    levelEdit.saveButton();
  }

//Displays when you reach the end of the level
  if (state == 5) {
    levelComplete();
  }

  //Pause menu
  if ((gpaused == true)&& (state == 1)) {
    pause();
  }
}

//Moves Mario
public void keyPressed() {
  mario.keypressed();
  if (key == 'p' || key == 'P') {
    gpaused = !gpaused;
  }
  if (key == 'm' || key =='M'){
    state = 0;
  }
}

public void keyReleased() {
  mario.keyreleased();
}

//loads all the images used 
public void initializeValues() {
  bgImage = "level_background.png";

  font = createFont("joystik.ttf", 20);
  gpaused = false;


  // UNSLASH TO PLAY MUSIC
  //  music = new SoundFile(this, "song.mp3");
  //  music.loop();

  //music = new SoundFile(this, "song.mp3");
  //music.loop();

  loadImages();

  state = 0;
  counter = 0;

  mario = new Mario();
  goomba1 = new Goomba();
  homeScreen = new Mainmenu();
  mCoin = new Coin();
  mBlock = new Mystery_Block();
  mBrick = new RegularBrick();
  levelEdit = new LevelEditor();
  loadLevel(mario.n);

  playagainS = new Button("Play Again", width/2 - 60, height/2+80, 50, 50, 3);
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
  poleS = new BlockSelect(pole, 630, 300, 30, 30, 7);
}

//Draws the pause loop
public void pause() {
  fill(200, 200, 200, 1);
  rect(0, 0, width, height);
  fill(0);
  text("Paused", width/2, height/2);
  text("Press P to unpause", width/2, height/2-100);
}

//Instruction screen
public void instructions() {
  image(deathScreen, 0, 0, width, height);
  backButton.Draw();
  backButton.clicked();
  text("Controls", width/2, 150);
  textSize(20);
  text("WASD - to move", width/2, 250);
  text("P - PAUSE AND UNPAUSE", width/2, 300);
  textSize(32);
}

//Draws the death screen
public void dead() {
  image(deathScreen, 0, 0, width, height);
  textFont(font);
  textAlign(CENTER, CENTER);
  playagainS.Draw();
  playagainS.clicked();

  textSize(50);
  text("GAMEOVER", width/2, height/2-200);
}

//Draw the level complete screen
public void levelComplete() {
  image(deathScreen, 0, 0, width, height);
  textSize(50);
  text("LEVEL COMPLETE", width/2, height/2-65);

  textSize(25);
  text("YOUR SCORE", width/2, height/2-200);
  text(counter, width/2,height/2-170);
  playagainS.Draw();
  playagainS.clicked();
}

//displays the background and places all the blocks
public void display() {
  image(levelBackground, 0, 0, width, height);

  for (int y = 0; y < tilesHigh; y++) {
    for (int x = 0; x < tilesWide; x++) {
      showTile(tiles[x][y], x, y);
    }
  }
}

//assignes symbols to pictures
public void showTile(char location, int x, int y) {
  
  //Allows the objects to use location of symbols
  mCoin.displayCoin(location, PApplet.parseInt(x*tileWidth), PApplet.parseInt(y*tileHeight));
  mBlock.display(location, PApplet.parseInt(x*tileWidth), PApplet.parseInt(y*tileHeight));
  mBrick.display(location, PApplet.parseInt(x*tileWidth), PApplet.parseInt(y*tileHeight));
  
  if (location == '.') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'D') {
    image(dirt, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'Y') {
    image(brick, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'F') {
    image(pole, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
}

//loads Images
public void loadImages() {

  //load background
  levelBackground = loadImage(bgImage);
  deathScreen = loadImage("deathScreen.jpg");
  mainScreen = loadImage("mainscreen.jpg");

  //load tile images
  platform = loadImage("platform.png");
  empty = loadImage("empty.png");
  dirt = loadImage("dirt.png");
  brick = loadImage("brick.png");
  coin = loadImage("coin0.png");
  box = loadImage("box.jpg");
  eraser = loadImage("Eraser.png");
  pole = loadImage("Pole.png");
}

//Loading Levels
public void loadLevel(int n) {
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
class BlockSelect {
  
//variables
  PImage image;
  float x, y, w, h;    
  float selectBlock;

//Constructor
  BlockSelect(PImage image_, float xPos, float yPos, float w_, float h_, float selectBlock_) {
    image = image_;
    x = xPos;
    y = yPos;
    w = w_;
    h = h_;
    selectBlock = selectBlock_;
  }

//Creates the blocks
  public void Draw() {
    image(image, x, y, w, h);
  }

//Detects which block is selected to be entered into the grid
  public void clicked() {
    if (MouseIsOver() ==true) { 
      w = 35;
      h = 35;
      if (mousePressed == true) {
        if (selectBlock == 3) {
          block = 3;
        }
        if (selectBlock == 2) {
          block = 2;
        }
        if (selectBlock == 4) {
          block = 4;
        }
        if (selectBlock == 1) {
          block = 1;
        }
        if (selectBlock == 5) {
          block = 5;
        }     
        if (selectBlock == 6) {
          block = 6;
        }      
        if (selectBlock == 7){
          block = 7;
        }
      }
    } else {
      w = 30;
      h = 30;
    }
  }
  
//Tells if the mouse is over the buttons
  public boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {

      return true;
    }
    return false;
  }
}
class Button {
  
//Local Variables  
  String label;
  float x, y, w, h;    
  float selectButton;

// Constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, float _selectButton ) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    selectButton = _selectButton;
    save = false;
    load = false;
  }


//Creates button
  public void Draw() {
    textSize(20);
    fill(0xff3FBFFF);
    stroke(141);
    noStroke();
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(font);
    text(label, x + (w / 2), y + (h / 2));
  }
  

//Detects if clicked and performs designated actions  
  public void clicked() {
    if (MouseIsOver() ==true) { 
      w = 110;
      h = 55;
      if (mousePressed == true) {

        if (selectButton==1) {
          save = true;
        }
        if (selectButton==2) {
          load = true;
          state = 1;
          loadLevel(10);
        }
        if (selectButton ==3) {
          state = 0;
          mario.x = 0;
          mario.y = 620;
          mario.n = 0;
          loadLevel(0);
        }
        if (selectButton == 4) {
          state = 4;
        }
        if (selectButton == 5){
          println("sdasd");
         state = 0; 
        }
      }
    } 
    else {
      w = 100;
      h = 50;
    }
  }
  
  
//Boolean if mouse is over the button, if true causes a reaction in clicked()  
  public boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}
class Coin {

  //Variables
  int coinCounter;
  PImage[] coinSpin = new PImage[6];

  //Constructors 
  Coin() {
    coinCounter = 0; 
    
    //Calls all images for coin
    for (int i = 0; i<coinSpin.length; i++) {
      coinSpin[i] = loadImage("coin"+i+".png");
    }
  }

//Detects if Mario is on coin and allows the player to collect it
  public void onCoin () {
    if (tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)] == 'C') {
      tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)] = '.';
      counter++;
    }
  }
  
//displays the coin at given locations, from the txt file
  public void displayCoin(int location, int x, int y) {
    if (location == 'C') {
      image(coinSpin[coinCounter], x, y, tileWidth, tileHeight);
      if (frameCount %4 == 0) {
        coinCounter ++;
        coinCounter = coinCounter % coinSpin.length;
      }
    }
  }
  
//Displays points in top left
  public void displayPoints() {
    textSize(32);
    text(counter, 100, 100);
  }
}
class Goomba {

  //Variables
  //Where he is and direction facing
  int  goomX, goomY, goomDirection, goomCounterOne, goomCounterTwo;

  //Essentially switches if he spawns or is walking
  boolean goomWalk, goomSpawn, canSeeGoomba;

  //goomba images
  PImage[] goombaLeft = new PImage[5];
  PImage[] goombaRight = new PImage[5];

  float acceleration;

  //Constructor
  Goomba() {
    goomX = 600;
    goomY = PApplet.parseInt (height - 3*tileHeight);
    goomWalk = true;
    goomDirection = 1;
    canSeeGoomba = true;

    goomCounterOne = 0;
    goomCounterTwo = 0;
    goomSpawn = true;
    for (int i =0; i<goombaLeft.length; i++) {
      goombaLeft[i] = loadImage("goomba"+i+".png");
    }
    for (int j =0; j<goombaRight.length; j++) {
      goombaRight[j] = loadImage("goombaTwo"+j+".png");
    }
    acceleration = 36;
  }

  //spawns on the ! in the text file, cannot have more than 1 ! within the text file
  public void spawn() {
    if (goomSpawn == true) {
      for (int y = 0; y < tilesHigh; y++) {
        for (int x = 0; x < tilesWide; x++) {
          if (tiles[x][y]=='!') {

            goomX = PApplet.parseInt(x*tileWidth);
            goomY = PApplet.parseInt(y*tileHeight);


            goomSpawn = false;
          }
        }
      }
    }
  }


//allows interaction with the grid from the goomba
  public void grid() {
    if (tiles[PApplet.parseInt(goomX/tileWidth)][PApplet.parseInt(goomY/tileHeight)+1]!='#') {
      gravity();
    }
    if (tiles[PApplet.parseInt(goomX/tileWidth)+1][PApplet.parseInt(goomY/tileHeight)] != '.'&&tiles[PApplet.parseInt(goomX/tileWidth)+1][PApplet.parseInt(goomY/tileHeight)] != 'C') {
      goomDirection = 2;
    }
    if (PApplet.parseInt(goomX/tileWidth)>=1) {
      if (tiles[PApplet.parseInt(goomX/tileWidth)-1][PApplet.parseInt(goomY/tileHeight)] != '.'&&tiles[PApplet.parseInt(goomX/tileWidth)-1][PApplet.parseInt(goomY/tileHeight)] != 'C') {
        goomDirection = 1;
      }
    }
    if (goomX <=0) {
      goomDirection = 1;
    }
  }

// gravity function, controls the rate the goomba falls
  public void gravity() {
    goomY+=5*3.81f;
    if (tiles[PApplet.parseInt(goomX/tileWidth)][PApplet.parseInt(goomY/tileHeight+1)]!='.'&&tiles[PApplet.parseInt(goomX/tileWidth)][PApplet.parseInt(goomY/tileHeight+1)]!='C') {
      goomY -= (goomY-PApplet.parseInt(goomY/tileHeight)*PApplet.parseInt(tileHeight));
      acceleration = 36;
    }
  }

//Detects if the player jumps on the Goomba
  public void attacked() {
    if ((PApplet.parseInt(goomX/tileWidth)+1)>(PApplet.parseInt(mario.x/tileWidth))&&(PApplet.parseInt(mario.x/tileWidth))>(PApplet.parseInt(goomX/tileWidth)-1)) {
      if ((PApplet.parseInt(mario.y/tileHeight)+1)== PApplet.parseInt(goomY/tileHeight)) {
        goomDirection =3;
      }
    }
  }

//Detects if the Goomba hits and kills the player, only works on the first level
  public void attacking() {
    if (goomX/tileWidth==mario.x/tileWidth&&goomY/tileHeight==mario.y/tileHeight) {
      state = 2;
    }
  }

// causes the goomba to move, and switches between two images
  public void enemy() {

    if (goomDirection == 1&&canSeeGoomba == true) {
      image (goombaRight[goomCounterTwo], goomX, goomY, tileWidth, tileHeight);
      if (frameCount%1 ==0) {
        goomCounterTwo++;
        goomCounterTwo =  goomCounterTwo% goombaRight.length;
      }
      goomX +=tileWidth/4;
    }

    if (goomX >= width-10) {
      goomDirection = 2;
    }

    if (goomDirection == 2&&canSeeGoomba == true) {
      image (goombaLeft[goomCounterOne], goomX, goomY, tileWidth, tileHeight);
      if (frameCount%1 ==0) {
        goomCounterOne++;
        goomCounterOne =  goomCounterOne% goombaLeft.length;
      }
      goomX -=tileWidth/4;
    }
    
    if (goomX <= 0) {
      goomDirection = 1;
    }

    if (goomDirection == 3) {
      goomSpawn = true;
      spawn();
    }
  }
}
class LevelEditor {
  
//variables
  int [][] board;
  int cols, rows, cellWidth, cellHeight;
  boolean clicked, once, onGrid;
  char letter;
  String words;  


//Constructor
  LevelEditor() {
    words = "";
    once = false;
    cols = 20;
    rows = 20;
    board = new int[cols][rows];
    cellWidth = (600)/cols;
    cellHeight = (600)/rows;
    block= 1;
  }
  
//Initially makes the grid
  public void makeGrid() {
    text("BLOCKS", 655,20);
    text("ERASER", 655,470);
    if (once == false) {
      for (int x=0; x<cols; x++) { 
        for (int y=0; y<rows; y++) { 
          
          board[x][y] = 1;
        }
      }
      once = true;
    }
  }
  
//creates and draws the grid filled with the correct blocks 
  public void displayGrid() {
    board[19][0] = 4;
    words = "";
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) {
        if (board[x][y] == 1) {
          fill(255);
          stroke(1);
          rect(y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + ".";
          } 
          if (y >= rows -1) {
            words = words + " ";

          }
        }
        if (board[x][y] == 2) {
          image(box, y*cellWidth, x*cellHeight, cellWidth, cellHeight);
          
          if (y < rows) {
            words = words + "B";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }

        if (board[x][y] == 3) {
          image(coin, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

           if (y < rows) {
            words = words + "C";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }

        if (board[x][y] == 4) {
          image(platform, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "#";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }
        if (board[x][y] == 5) {
          image(dirt, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "D";
          } 
          if (y >= rows -1) {
            words = words + " ";

          }
        }        
        
        if (board[x][y] == 6) {
          image(brick, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "Y";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }
        
        if (board[x][y] == 7) {
          image(pole, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "F";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }  
      }
    }
  }
  

//Detects if the mouse is on the grid 
  public void mouseOnGrid() {
    if (mouseX<= width-121) {
      if (mouseX>= 0) {
        if (mouseY <= height - 101) { 
          if (mouseY >=0) {
            onGrid = true;
          } else {
            onGrid = false;
          }
        } else {
          onGrid = false;
        }
      } else {
        onGrid = false;
      }
    } else {
      onGrid = false;
    }
  }

//Places the selected block onto the grid
  public void placeBlock() {
    mouseOnGrid();
    if (onGrid == true) {
      if (mousePressed == true) {
        println("asd");
        board[mouseY/30][mouseX/30] = block;
      }
    }
  }

//If the save button is clicked, saves to the txt file
  public void saveButton() {
      if (save == true) {
        println("sadas");
       words = words.substring(0, max(0, words.length() - 1));
        String[] list = split(words, ' ');
        saveStrings("data/levels/10.txt", list);
        save = false;
      }
      if (load == true) {
        state =1;
        n = 10;
      }
  }



  public void mousePressed() {
    clicked = true;
  }
}
class Mainmenu {

  //Variables
  PImage mainScreen, shroom, bricks;
  int shroomX, shroomY ;
  int shroomLocation;

  //Constructor
  Mainmenu() {
    mainScreen = loadImage("mainscreen.jpg");
    shroom = loadImage("lilshroom.png");
    bricks = loadImage("bricks.jpg");
    shroomLocation = 1;
    shroomX = 200;
    shroomY = 400;
  }

  //Draws the mainmenu
  public void menu() {
    keypressed();
    shroom();

    image(mainScreen, 0, 0, width, height); 
    image(shroom, shroomX, shroomY, 35, 35);
    textSize(30);
    text("1 PLAYER GAME", 380, 410);
    text("HELP", 380, 487);
    image(bricks, 0, 665, width, 35);
    levelEditor.Draw();
    levelEditor.clicked();
  }

  //Detects which key is pressed, and puts the shroom in the correct location
  public void keypressed() {
    if (key == 'w' || key == 'W') {
      shroomLocation = 1;
    } 
    if (key== 's' || key=='S') {
      shroomLocation = 2;
    }
    if (key == ENTER || key == ENTER) {
      if (shroomLocation == 1) {
        state = 1;
      }
      if (shroomLocation ==2) {
        state = 3; 
        shroomLocation = 0;
      }
    }
  }

  //Draws and moves the little shroom
  public void shroom() {
    if (shroomLocation == 1) {
      shroomY = 400;
      shroomX = 200;
    }
    if (shroomLocation == 2) {
      shroomY = 477;
      shroomX = 280;
    }
  }
}
class Mario {
  
  //loads marios Image
  PImage[]marioWalkingLeft = new PImage[11];
  PImage[]marioWalkingRight = new PImage[11];
  PImage stillMario1, stillMario2;
  
  //Controls everything about mario, from walking to falling to his size
  float lastMove, delay, fallSpeed, gravity, acceleration;
  int tilesHigh, tilesWide, x, y, n, counter, marioCounter, marioCounter2;
  boolean isWalkingLeft, isWalkingRight, falling, marioUp, marioRight, marioLeft, canGoLeft, canGoRight, facingRight;

  //declaring all the mario variables
  Mario() {  
    stillMario1 = loadImage("mario0.png");
    stillMario2 = loadImage("marioTwo0.png");
    marioCounter = 0;
    marioCounter2 =0;
    
    //Animations
    for (int i =0; i<marioWalkingLeft.length; i++) {
      marioWalkingLeft[i] = loadImage("mario"+i+".png");
    }
    for (int j =0; j<marioWalkingRight.length; j++) {
      marioWalkingRight[j] = loadImage("marioTwo"+j+".png");
    }

    //intializes all variables
    falling = false;
    acceleration = 36;
    marioUp = false;
    marioLeft = false;
    marioRight = false;
    gravity = 5;

    x =0;
    n=0;
    counter = 0;
    isWalkingLeft = false;
    isWalkingRight = false;
    facingRight = true;
    canGoLeft = true;
    canGoRight = true;
    delay = 150;
    lastMove = millis();
    y= 630;
  }

  //Moves Mario
  public void move() {
    
    //Mario moving
    if (marioUp == true) {
      jump();
    }
    if (falling == true) {
      gravity();
    }

    if (marioLeft == true&&canGoLeft == true) {
      x+=tileWidth/4;
      isWalkingLeft = false;
      isWalkingRight = true;
    }
    if (marioRight == true&&canGoRight == true) {
      x-=tileWidth/4;
      isWalkingRight = false;
      isWalkingLeft = true;
    }
    
    //Goes to next Level if off screen
    nextLevel();
    
    //calls mario animation, and makes it so that where ever mario stops his facing that direction
    if (isWalkingLeft == true) {
      walkingLeft();
    } else if (isWalkingRight == true) {
      walkingRight();
    } else if (facingRight == false) {
      image(stillMario1, x, y, tileWidth, tileHeight);
    } else {
      image(stillMario2, x, y, tileWidth, tileHeight);
    }
  }

  //Determins if you can goto next level
  public void nextLevel() {
    if (x >= width-40) {
      n++;
      goomba1.goomDirection = 1;
      goomba1.canSeeGoomba = true;
      x= 10;
      loadLevel(n);
    } 
    else if (x <=0&&n!=0) {
      x = 2;
    } else if ( n == 10) {
      n = 0;
      loadLevel(n);
    } else if ( n == 0&& x < 0) {
      x = 2;
    } else if (y>height) {
      y= PApplet.parseInt (height - 2*tileHeight);
    } else if (y<0) {
      y= PApplet.parseInt (height - 2*tileHeight);
    }
  }

  //Walking Left animation
  public void walkingLeft() {
    image (marioWalkingLeft[marioCounter], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter++;
      marioCounter = marioCounter % marioWalkingLeft.length;
    }
  }
  
  //Walking Right animation
  public void walkingRight() {
    image (marioWalkingRight[marioCounter2], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter2++;
      marioCounter2 = marioCounter2 % marioWalkingRight.length;
    }
  }

  //Sees if you are colliding with the grid
  public void collidingWithGrid() {
    if (tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt(y/tileHeight)]!= '.'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt(y/tileHeight)]!= 'C'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt(y/tileHeight)]!= '!'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt(y/tileHeight)]!= 'F') {
      canGoLeft = false;
    } else {
      canGoLeft = true;
    }
    if (PApplet.parseInt((y-tileHeight)/tileHeight)>=0) {
      if (tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y-tileHeight)/tileHeight)]!= '.'
        &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y-tileHeight)/tileHeight)]!= 'C'
        &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y-tileHeight)/tileHeight)]!= '!'
        &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y-tileHeight)/tileHeight)]!= 'F') {
        acceleration =0;
        falling = true;
      } else {

        falling = false;
      }
    }
    if (tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y)/tileHeight)]!= '.'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y)/tileHeight)]!= 'C'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y)/tileHeight)]!= '!'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y)/tileHeight)]!= 'F') {
      canGoRight = false;
    } else {
      canGoRight = true;
    }
    if (tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= '.'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= 'C'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= '!'
      &&tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= 'F') {
      falling = false;
    } else {
      falling = true;
    }
    if (tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= '.'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= 'C'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= '!'
      &&tiles[PApplet.parseInt((x+tileWidth)/tileWidth)][PApplet.parseInt((y+tileHeight)/tileHeight)]!= 'F') {
      falling = false;
    } else {
      falling = true;
    }
    if (tiles[PApplet.parseInt((x)/tileWidth)][PApplet.parseInt((y)/tileHeight)]== 'F'){
      state = 2;
      x=0;
      y=630;
    }
  }

  //Jump functions makes it so you jump but you being to slow down as you reach your peak
  public void jump() {
    if (acceleration != 0) {
      y-=acceleration;
      acceleration-=2;
    }
    falling = true;
  }

  //Prevents you from going too high, as well as prevents you from going through the ground
  public void gravity() {
    y+=5*3.81f;
    if (tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight+1)]!='.'
    &&tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight+1)]!='C'
    &&tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight+1)]!='!') {
      y -= (y-PApplet.parseInt(y/tileHeight)*PApplet.parseInt(tileHeight));
      acceleration = 36;
    }
  }

 //Moves mario depending on which key you press
  public void keypressed() {
    if (key == 'w' || key == 'W'&&(falling ==false)) {
      marioUp = true;
    } 
    if (key== 'a' || key=='A') {
      marioRight = true;
    }  
    if (key== 'd' || key=='D') {
      marioLeft = true;
    }
  }

  public void keyreleased() {
    if (key == 'w' || key == 'W') {
      acceleration = 0;
      marioUp = false;
    } 
    if (key== 'a' || key=='A') {
      marioRight = false;
      isWalkingLeft = false;
      facingRight = false;
    }
    if (key== 'd' || key=='D') {
      marioLeft = false;
      isWalkingRight = false;
      facingRight = true;
    }
  }
}
class Mystery_Block {

  //Variables
  int blockCounter;
  PImage[] spinBlock = new PImage[4];

  //Constructors
  Mystery_Block() {
    blockCounter = 0; 
    
    //calls all images for spining block
    for (int i = 0; i<spinBlock.length; i++) {
      spinBlock[i] = loadImage("Block"+i+".png");
    }
  }

  //The mystery block animation
  public void display(int location, int x, int y) {
    if (location == 'B') {
      image(spinBlock[blockCounter], x, y, tileWidth, tileHeight);
      if (frameCount %5 == 0) {
        blockCounter ++;
        blockCounter = blockCounter % spinBlock.length;
      }
    }
  }

  //Detects if mario is hitting the block and creates a coin above if the block is hit from underneath
  public void marioHittingBlock() {
    if (tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)-1]== 'B') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W') {
        tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)-2] = 'C';
      }
    }
  }
}
class RegularBrick{
  
  //Variables
  RegularBrick(){
    
  }
  
  //Displays the brick at the point read from the text file
  public void display(int location, int x, int y){
    
      if (location == '#') {
    image(platform, x, y, tileWidth, tileHeight);
  }  
       
  }
  
  //Detects if Mario is hitting the block and breaks it if hit fron underneath
  public void marioHittingBrick() {
    if (tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)-1]== 'Y') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W'){
       tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)-1] = '.';
      }
    }
  }
  
  
}
  public void settings() {  size(720, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PROJECT" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
