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
    goomY = int (height - 3*tileHeight);
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
  void spawn() {
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
  void grid() {
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight)+1]!='#'){
      gravity();
    }
    if (tiles[int(goomX/tileWidth)+1][int(goomY/tileHeight)] == '#') {
      goomDirection = 2;
    }
    if (int(goomX/tileWidth)>=1){
    if (tiles[int(goomX/tileWidth)-1][int(goomY/tileHeight)] == '#') {
      goomDirection = 1;
    }
    }
    if (goomX <=0){
      goomDirection = 1;
    }
    
    
  }
  
// gravtiy function, controls the rate the goomba falls
  void gravity() {
    goomY+=3.81;
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight+1)]=='#') {
      goomY -= (goomY-int(goomY/tileHeight)*int(tileHeight));
      falling = false;
      acceleration = 36;
      marioUp = false;
    }
  }
void attacking(){
  if ((int(goomX/tileWidth)+1)>(int(mario.x/tileWidth))&&(int(mario.x/tileWidth))>(int(goomX/tileWidth)-1)){
    if((int(mario.y/tileHeight)+1)== int(goomY/tileHeight)){
      goomY = int(tileHeight);
canSeeGoomba= false;
    }
    
  }

  
  
  
}
// causes the goomba to move, and switches between two imgaes
  void enemy() {

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