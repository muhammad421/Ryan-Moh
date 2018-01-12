class Mystery_Block {
  int blockCounter;
  PImage[] spinBlock = new PImage[4];

  Mystery_Block() {
    blockCounter = 0; 
    for (int i = 0; i<spinBlock.length; i++) {
      spinBlock[i] = loadImage("Block"+i+".png");
    }
  }
  void display(int location, int x, int y) {
    if (location == 'B') {
      image(spinBlock[blockCounter], x, y, tileWidth, tileHeight);
      if (frameCount %5 == 0) {
        blockCounter ++;
        blockCounter = blockCounter % spinBlock.length;
      }
    }
  }

  void marioHittingBlock() {
    if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1]== 'B') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W'){
      tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-2] = 'C';
      }
    }
    if (tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='Y') {
      mario.canGoLeft =false;
    } else {
      mario.canGoLeft = true;
    }
    if (x/tileWidth>=1) {
      if (tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='Y') {
        mario.canGoRight =false;
      } else {
        mario.canGoRight = true;
      }
    }
  }
}