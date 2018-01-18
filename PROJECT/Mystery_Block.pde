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
  void display(int location, int x, int y) {
    if (location == 'B') {
      image(spinBlock[blockCounter], x, y, tileWidth, tileHeight);
      if (frameCount %5 == 0) {
        blockCounter ++;
        blockCounter = blockCounter % spinBlock.length;
      }
    }
  }

  //Detects if mario is hitting the block and creates a coin above if the block is hit from underneath
  void marioHittingBlock() {
    if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1]== 'B') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W') {
        tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-2] = 'C';
      }
    }
  }
}