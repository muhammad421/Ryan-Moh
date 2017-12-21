class Goomba{
  //where he is and direction facing
  int  goomX, goomY, goomDirection;
  
//essentially switches if he spawns or is walking
  boolean goomWalk, goomSpawn;
  
//goomba images
  PImage goomba2, goomba;

  Goomba() {
    loadLevel();
    goomX = 600;
    goomY = int ((height - (2*tileHeight))- 3*tileHeight);
    goomWalk = true;
    goomDirection = 1;

    goomSpawn = true;
    jumpSpeed = 0;
    fallSpeed = 0;
    gravity = 5;
    goomba = loadImage("goomba.png");
    goomba2 = loadImage("goomba2.png");
  }

//spawns on the ! in the text file
  void spawn() {
      if (goomSpawn == true) {
    for (int y = 0; y < tilesHigh; y++) {
      for (int x = 0; x < tilesWide; x++) {
        if (tiles[x][y]=='!') {
      println("sadasd");
            goomX = x * width/tilesWide;
            goomY = y * width/tilesHigh;


            tiles[x][y] = '.';
            goomSpawn = false;
          }
        }
      }
    }
  }
  
  void test(Mario theCharacter){
    println(theCharacter.x);
    
  }
//allows interaction with the grid from the goomba
  void grid() {
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight)+1]!='#'){
      goomX -= 5;
      gravity();
      x = goomX;
    }
    if (tiles[int(goomX/tileWidth)+1][int(goomY/tileHeight)] == '#') {
      goomDirection = 2;
    }
    if (tiles[int(goomX/tileWidth)][int(goomY/tileHeight)] == '#') {
      goomDirection = 1;
    }
    
    
  }
  
// gravtiy function, controls the rate the goomba falls
  void gravity() {
    goomY =int(goomY + jumpSpeed);
    jumpSpeed = jumpSpeed + gravity;
    if (goomY >=630) {
      jumpSpeed = 0;
      y = 630;
    }
    y = goomY;
  }

// casues the goomba to move, and switches between two imgaes
  void enemy() {
    goomWalk();

    if (goomDirection == 1) {
      if (goomWalk == true) {
        image(goomba, goomX, goomY, tileWidth, tileHeight);
      }
      if (goomWalk == false) {
        image(goomba2, goomX, goomY, tileWidth, tileHeight);
      }
      goomX = goomX+5;
    }

    if (goomX == width-20) {
      goomDirection = 2;
    }


    if (goomDirection == 2) {
      if (goomWalk == false) {
        image(goomba2, goomX, goomY, tileWidth, tileHeight);
      }
      if (goomWalk == true) {
        image(goomba, goomX, goomY, tileWidth, tileHeight);
      }
      goomX = goomX-5;
    }
    if (goomX == 0) {
      goomDirection = 1;
    }
  }

//causes two images to flipped to create waling animation
  void goomWalk() {
    if (millis() > goomMove + delay) {
      goomWalk = !goomWalk;
      goomMove = 0;
    }
  }
  
 //loads the level to interact with goomba 

}