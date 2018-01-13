class Mario {
  //Image
  PImage[]marioWalkingLeft = new PImage[11];
  PImage[]marioWalkingRight = new PImage[11];
  PImage stillMario1, stillMario2;
  float lastMove, delay, fallSpeed, gravity, acceleration;
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
    y= 620;
  }

  //Moves Mario
  void move() {
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
  void nextLevel() {
    if (x >= width) {
      n++;
 goomba1.goomDirection = 1;
      goomba1.canSeeGoomba = true;
      x= 10;
      loadLevel(n);
    } else if (x <=0&&n!=0) {
      x = 2;
    } else if ( n == 9) {
      n = 0;
      loadLevel(n);
    } else if ( n == 0&& x < 0) {
      x = 2;
    } else if (y>height) {
      y= int (height - 2*tileHeight);
    } else if (y<0) {
      y= int (height - 2*tileHeight);
    }
  }

  //Walking animation
  void walkingLeft() {
    image (marioWalkingLeft[marioCounter], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter++;
      marioCounter = marioCounter % marioWalkingLeft.length;
    }
  }
  void walkingRight() {
    image (marioWalkingRight[marioCounter2], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter2++;
      marioCounter2 = marioCounter2 % marioWalkingRight.length;
    }
  }

  //Sees if you are colliding with the grid
  void collidingWithGrid() {
    if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]=='.'||tiles[int(x/tileWidth)][int(y/tileHeight+1)]=='C') {
      falling = true;
    } else {
      falling = false;
    }
    if (tiles[int(x/tileWidth)][int(y/tileHeight)-1]=='#') {
      acceleration = 0;
    }
  }
  //
  //Allows you to jump
  void jump() {
    if (acceleration != 0) {
      y-=acceleration;
      acceleration-=2;
    }
    falling = true;
  }

  //Prevents you from going too high
  void gravity() {
    y+=5*3.81;
  if (tiles[int(x/tileWidth)][int(y/tileHeight+1)]!='.'&&tiles[int(x/tileWidth)][int(y/tileHeight+1)]!='C') {
      y -= (y-int(y/tileHeight)*int(tileHeight));
      //falling = false;
      //marioUp = false;
      acceleration = 36;
    }
  }


  void keypressed() {

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

  void keyreleased() {

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