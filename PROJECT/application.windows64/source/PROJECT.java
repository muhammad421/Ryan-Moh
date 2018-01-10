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
PImage platform, box, goomba, slime, empty;
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
Mainmenu homeScreen;
Coin mCoin;
//Sets background and calls on the mario and goomba functions
public void setup() {
    
  //fullScreen();
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
  homeScreen = new Mainmenu();
  mCoin = new Coin();
  loadLevel(mario.n);
}

//Moves mario and the Goomba and checks to see what they are colliding with on the grid

public void draw() {
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
    //mario.collidingWithGoomba();


    goomba1.spawn();
    goomba1.attacking();
    goomba1.grid();
    goomba1.enemy();
  }
  if ((gpaused == true)&& (state == 1)) {
    pause();
  }
}

//moves Mario
public void keyPressed() {
  mario.keypressed();
  if (key == 'p' || key == 'P') {

    gpaused = !gpaused;

    if (state == 3) {
      state = 0;
    }
  }
}

public void keyReleased() {
  mario.keyreleased();
}

//loads all the images used 
public void initializeValues() {
  loadImages();
  delay = 150;
  lastMove = millis();
}

public void pause() {
  fill(200, 200, 200, 1);
  rect(0, 0, width, height);
  fill(0);
  text("Paused", width/2-70, height/2);
  text("Press P to unpause", width/2-150, height/2+100);
}

//Instruction screen
public void instructions() {
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
public void mainScreen() {

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

public void dead() {
  background(0);
  text("you dead", width/2-100, height/2);
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
  mCoin.displayCoin(location, PApplet.parseInt(x*tileWidth), PApplet.parseInt(y*tileHeight));
  if (location == '#') {
    image(platform, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }  else if (location == 'B') {
    image(box, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'F') {
    image(goomba, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == 'S') {
    image(slime, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  } else if (location == '.') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
  }
}

//loads Images
public void loadImages() {
  //load background
  levelBackground = loadImage(bgImage);

  //load tile images
  platform = loadImage("platform.png");
  box = loadImage("box.jpg");
  goomba = loadImage("goomba.png");
  slime = loadImage("slime.png");
  empty = loadImage("empty.png");
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
class Coin{
  int counter, coinCounter;
  PImage[] coinSpin = new PImage[6];

  
  Coin(){
    counter = 0;
    coinCounter = 0;
    
    for (int i = 0; i<coinSpin.length; i++){
      coinSpin[i] = loadImage("coin"+i+".png");
    }
  }
    
  public void onCoin () {
if (tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)] == 'C'){
  tiles[PApplet.parseInt(mario.x/tileWidth)][PApplet.parseInt(mario.y/tileHeight)] = '.';
  counter++;
}
  }
  public void displayCoin(int location, int x, int y){
    if (location == 'C') {
      image(coinSpin[coinCounter], x,y, tileWidth, tileHeight);
      if (frameCount %1 == 0){
        coinCounter ++;
        coinCounter = coinCounter % coinSpin.length;
      }
        
  }
  }
public void displayPoints(){
textSize(32);
text(counter, 100, 100);
  
}
public void walkingLeft(){
  
  
}
  
}
class Goomba{
  //where he is and direction facing
  int  goomX, goomY, goomDirection, goomCounterOne, goomCounterTwo;
  
//essentially switches if he spawns or is walking
  boolean goomWalk, goomSpawn, canSeeGoomba;
  
//goomba images
  PImage[] goombaLeft = new PImage[5];
  PImage[] goombaRight = new PImage[5];
  
  float acceleration;

  Goomba() {
    goomX = 600;
    goomY = PApplet.parseInt (height - 3*tileHeight);
    goomWalk = true;
    goomDirection = 1;
    canSeeGoomba = true;

    goomCounterOne = 0;
    goomCounterTwo = 0;
    goomSpawn = true;
    jumpSpeed = 0;
    fallSpeed = 0;
    gravity = 5;
    for (int i =0; i<goombaLeft.length; i++) {
      goombaLeft[i] = loadImage("goomba"+i+".png");
    }
     for (int j =0; j<goombaRight.length; j++) {
      goombaRight[j] = loadImage("goombaTwo"+j+".png");
    }
    acceleration = 36;
  }

//spawns on the ! in the text file
  public void spawn() {
      if (goomSpawn == true) {
    for (int y = 0; y < tilesHigh; y++) {
      for (int x = 0; x < tilesWide; x++) {
        if (tiles[x][y]=='!') {
    
            goomX = x*width/tilesWide;
            goomY = y*height/tilesHigh;


            tiles[x][y] = '.';
            goomSpawn = false;
          }
        }
      }
    }
  }
  

//allows interaction with the grid from the goomba
  public void grid() {
    if (tiles[PApplet.parseInt(goomX/tileWidth)][PApplet.parseInt(goomY/tileHeight)+1]!='#'){
      gravity();
    }
    if (tiles[PApplet.parseInt(goomX/tileWidth)+1][PApplet.parseInt(goomY/tileHeight)] == '#') {
      goomDirection = 2;
    }
    if (PApplet.parseInt(goomX/tileWidth)>=1){
    if (tiles[PApplet.parseInt(goomX/tileWidth)-1][PApplet.parseInt(goomY/tileHeight)] == '#') {
      goomDirection = 1;
    }
    }
    if (goomX <=0){
      goomDirection = 1;
    }
    
    
  }
  
// gravtiy function, controls the rate the goomba falls
  public void gravity() {
    goomY+=3.81f;
    if (tiles[PApplet.parseInt(goomX/tileWidth)][PApplet.parseInt(goomY/tileHeight+1)]=='#') {
      goomY -= (goomY-PApplet.parseInt(goomY/tileHeight)*PApplet.parseInt(tileHeight));
      falling = false;
      acceleration = 36;
      marioUp = false;
    }
  }
public void attacking(){
  if ((PApplet.parseInt(goomX/tileWidth)+1)>(PApplet.parseInt(mario.x/tileWidth))&&(PApplet.parseInt(mario.x/tileWidth))>(PApplet.parseInt(goomX/tileWidth)-1)){
    if((PApplet.parseInt(mario.y/tileHeight)+1)== PApplet.parseInt(goomY/tileHeight)){
      goomY = PApplet.parseInt(tileHeight);
canSeeGoomba= false;
    }
    
  }

  
  
  
}
// causes the goomba to move, and switches between two imgaes
  public void enemy() {

    if (goomDirection == 1) {
          image (goombaRight[goomCounterTwo], goomX, goomY, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      goomCounterTwo++;
      goomCounterTwo =  goomCounterTwo% goombaRight.length;
    }
      goomX +=tileWidth/2;
    }

    if (goomX >= width-10) {
      goomDirection = 2;
    }


    if (goomDirection == 2) {
      println(goomX);
          image (goombaLeft[goomCounterOne], goomX, goomY, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      goomCounterOne++;
      goomCounterOne =  goomCounterOne% goombaLeft.length;
    }
      goomX -=tileWidth/2;
    }
    if (goomX <= 0) {
      goomDirection = 1;
    }
  }

//causes two images to flipped to create waling animation

 //loads the level to interact with goomba 

}
class Mainmenu {
  PImage mainScreen, shroom, bricks;
  int shroomX, shroomY ;
  int shroomLocation;
  Mainmenu() {
    mainScreen = loadImage("mainscreen.jpg");
    shroom = loadImage("lilshroom.png");
    bricks = loadImage("bricks.jpg");
    shroomLocation = 1;
    shroomX = 200;
    shroomY = 417;

  }
  public void menu() {
    keypressed();
    shroom();

    image(mainScreen, 0, 0, width, height); 
    image(shroom, shroomX, shroomY, 35, 35);

    image(bricks,0,665,width,35);

  }
  public void keypressed() {

    if (key == 'w' || key == 'W') {
      shroomLocation = 1;
    } 
    if (key== 's' || key=='S') {
      shroomLocation = 2;
    }
    if (key == ENTER || key == ENTER){
      if (shroomLocation == 1){
       state = 1; 
      }
    }
  }
  public void shroom(){
   if (shroomLocation == 1){
        shroomY = 417;
   }
   if (shroomLocation == 2){
         shroomY = 467;
   }
    
  }
}
class Mario {
  //Image
  PImage[]marioWalkingLeft = new PImage[11];
  PImage[]marioWalkingRight = new PImage[11];
  PImage stillMario1, stillMario2;
  float lastMove, delay, fallSpeed, gravity, dy, acceleration;
  int tilesHigh, tilesWide, x, y, n, counter, marioCounter, marioCounter2;
  boolean isWalkingLeft, isWalkingRight, falling, marioUp, marioRight, marioLeft, canGoLeft, canGoRight, facingRight;

  //declaring all the mario variables
  Mario() {  
    stillMario1 = loadImage("mario0.png");
    stillMario2 = loadImage("marioTwo0.png");
    marioCounter = 0;
    marioCounter2 =0;
    for (int i =0; i<marioWalkingLeft.length; i++) {
      marioWalkingLeft[i] = loadImage("mario"+i+".png");
    }
    for (int j =0; j<marioWalkingRight.length; j++) {
      marioWalkingRight[j] = loadImage("marioTwo"+j+".png");
    }

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
    y= PApplet.parseInt (height - 3*tileHeight);
  }

  //Moves Mario
  public void move() {
    isWalking = false;
    //mario moving
    if (marioUp == true) {
      jump();
    }
    if (falling == true) {
      gravity();
    }

    if (marioLeft == true&&canGoLeft == true) {
      x+=tileWidth/2;
      isWalkingLeft = false;
      isWalkingRight = true;
    }
    if (marioRight == true&&canGoRight == true) {
      x-=tileWidth/2;
      isWalkingRight = false;
      isWalkingLeft = true;
    }
    //Goes to next Level if off screen
    nextLevel();
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
    if (x >= width) {
      n++;
      x= 10;
      loadLevel(n);
    } else if (x <=0&&n!=0) {
      x = 2;
      loadLevel(n);
    } else if ( n == 9) {
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

  //Walking animation
  public void walkingLeft() {
    image (marioWalkingLeft[marioCounter], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter++;
      marioCounter = marioCounter % marioWalkingLeft.length;
    }
  }
  public void walkingRight() {
    image (marioWalkingRight[marioCounter2], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter2++;
      marioCounter2 = marioCounter2 % marioWalkingRight.length;
    }
  }

  //Sees if you are colliding with the grid
  public void collidingWithGrid() {
    if (tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight)+1]!='#') {
      y += 2*gravity;
    }
    if (tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight)-1]=='#') {
      acceleration = 0;
    }
    if (tiles[PApplet.parseInt(x/tileWidth)+1][PApplet.parseInt(y/tileHeight)]=='#') {
      canGoLeft =false;
    } else {
      canGoLeft = true;
    }
    if (x/tileWidth>=1) {
      if (tiles[PApplet.parseInt(x/tileWidth)-1][PApplet.parseInt(y/tileHeight)]=='#') {
        canGoRight =false;
      } else {
        canGoRight = true;
      }
    }
  }

  //Allows you to jump
  public void jump() {
    if (acceleration != 0) {
      y-=acceleration;
      acceleration-=2;
    }
    falling = true;
  }

  //Prevents you from going too high
  public void gravity() {
    y+=3.81f;
    if (tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight+1)]=='#') {
      y -= (y-PApplet.parseInt(y/tileHeight)*PApplet.parseInt(tileHeight));
      falling = false;
      acceleration = 36;
      marioUp = false;
    }
  }


  public void keypressed() {

    if (key == 'w' || key == 'W'&&(falling ==false)) {
      marioUp = true;
      if (tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight)-1]=='#') {
        tiles[PApplet.parseInt(x/tileWidth)][PApplet.parseInt(y/tileHeight)-1] ='.';
      }
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
  public void settings() {  size(1440, 700); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PROJECT" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
