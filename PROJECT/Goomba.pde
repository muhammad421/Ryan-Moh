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
    goomY = int (height - 3*tileHeight);
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
  void spawn() {
    if (goomSpawn == true) {
      for (int y = 0; y < tilesHigh; y++) {
        for (int x = 0; x < tilesWide; x++) {
          if (tiles[x][y]=='!') {

            goomX = int(x*tileWidth);
            goomY = int(y*tileHeight);


            goomSpawn = false;
          }
        }
      }
    }
  }


//allows interaction with the grid from the goomba
  void grid() {
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight)+1]!='#') {
      gravity();
    }
    if (tiles[int(goomX/tileWidth)+1][int(goomY/tileHeight)] != '.'&&tiles[int(goomX/tileWidth)+1][int(goomY/tileHeight)] != 'C') {
      goomDirection = 2;
    }
    if (int(goomX/tileWidth)>=1) {
      if (tiles[int(goomX/tileWidth)-1][int(goomY/tileHeight)] != '.'&&tiles[int(goomX/tileWidth)-1][int(goomY/tileHeight)] != 'C') {
        goomDirection = 1;
      }
    }
    if (goomX <=0) {
      goomDirection = 1;
    }
  }

// gravity function, controls the rate the goomba falls
  void gravity() {
    goomY+=5*3.81;
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight+1)]!='.'&&tiles[int(goomX/tileWidth)][int(goomY/tileHeight+1)]!='C') {
      goomY -= (goomY-int(goomY/tileHeight)*int(tileHeight));
      acceleration = 36;
    }
  }

//Detects if the player jumps on the Goomba
  void attacked() {
    if ((int(goomX/tileWidth)+1)>(int(mario.x/tileWidth))&&(int(mario.x/tileWidth))>(int(goomX/tileWidth)-1)) {
      if ((int(mario.y/tileHeight)+1)== int(goomY/tileHeight)) {
        goomDirection =3;
      }
    }
  }

//Detects if the Goomba hits and kills the player, only works on the first level
  void attacking() {
    if (goomX/tileWidth==mario.x/tileWidth&&goomY/tileHeight==mario.y/tileHeight) {
      state = 2;
    }
  }

// causes the goomba to move, and switches between two images
  void enemy() {

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