
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
  void move() {
    
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
  void nextLevel() {
    if (x >= width-40) {
      n++;
      goomba1.goomDirection = 1;
      goomba1.canSeeGoomba = true;
      goomba1.goomX = 350;
      goomba1.goomY = 300;
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
      y= int (height - 2*tileHeight);
    } else if (y<0) {
      y= int (height - 2*tileHeight);
    }
  }

  //Walking Left animation
  void walkingLeft() {
    image (marioWalkingLeft[marioCounter], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter++;
      marioCounter = marioCounter % marioWalkingLeft.length;
    }
  }
  
  //Walking Right animation
  void walkingRight() {
    image (marioWalkingRight[marioCounter2], x, y, tileWidth, tileHeight);
    if (frameCount%1 ==0) {
      marioCounter2++;
      marioCounter2 = marioCounter2 % marioWalkingRight.length;
    }
  }

  //Sees if you are colliding with the grid
  void collidingWithGrid() {
    if (tiles[int((x+tileWidth)/tileWidth)][int(y/tileHeight)]!= '.'
      &&tiles[int((x+tileWidth)/tileWidth)][int(y/tileHeight)]!= 'C'
      &&tiles[int((x+tileWidth)/tileWidth)][int(y/tileHeight)]!= '!'
      &&tiles[int((x+tileWidth)/tileWidth)][int(y/tileHeight)]!= 'F') {
      canGoLeft = false;
    } else {
      canGoLeft = true;
    }
    if (int((y-tileHeight)/tileHeight)>=0) {
      if (tiles[int((x)/tileWidth)][int((y-tileHeight)/tileHeight)]!= '.'
        &&tiles[int((x)/tileWidth)][int((y-tileHeight)/tileHeight)]!= 'C'
        &&tiles[int((x)/tileWidth)][int((y-tileHeight)/tileHeight)]!= '!'
        &&tiles[int((x)/tileWidth)][int((y-tileHeight)/tileHeight)]!= 'F') {
        acceleration =0;
        falling = true;
      } else {

        falling = false;
      }
    }
    if (tiles[int((x)/tileWidth)][int((y)/tileHeight)]!= '.'
      &&tiles[int((x)/tileWidth)][int((y)/tileHeight)]!= 'C'
      &&tiles[int((x)/tileWidth)][int((y)/tileHeight)]!= '!'
      &&tiles[int((x)/tileWidth)][int((y)/tileHeight)]!= 'F') {
      canGoRight = false;
    } else {
      canGoRight = true;
    }
    if (tiles[int((x)/tileWidth)][int((y+tileHeight)/tileHeight)]!= '.'
      &&tiles[int((x)/tileWidth)][int((y+tileHeight)/tileHeight)]!= 'C'
      &&tiles[int((x)/tileWidth)][int((y+tileHeight)/tileHeight)]!= '!'
      &&tiles[int((x)/tileWidth)][int((y+tileHeight)/tileHeight)]!= 'F') {
      falling = false;
    } else {
      falling = true;
    }
    if (tiles[int((x+tileWidth)/tileWidth)][int((y+tileHeight)/tileHeight)]!= '.'
      &&tiles[int((x+tileWidth)/tileWidth)][int((y+tileHeight)/tileHeight)]!= 'C'
      &&tiles[int((x+tileWidth)/tileWidth)][int((y+tileHeight)/tileHeight)]!= '!'
      &&tiles[int((x+tileWidth)/tileWidth)][int((y+tileHeight)/tileHeight)]!= 'F') {
      falling = false;
    } else {
      falling = true;
    }
    if (tiles[int((x)/tileWidth)][int((y)/tileHeight)]== 'F'){
      state = 5;
      x=0;
      y=630;
    }
  }

  //Jump functions makes it so you jump but you being to slow down as you reach your peak
  void jump() {
    if (acceleration != 0) {
      y-=acceleration;
      acceleration-=2;
    }
    falling = true;
  }

  //Prevents you from going too high, as well as prevents you from going through the ground
  void gravity() {
    y+=5*3.81;
    if (tiles[int(x/tileWidth)][int(y/tileHeight+1)]!='.'
    &&tiles[int(x/tileWidth)][int(y/tileHeight+1)]!='C'
    &&tiles[int(x/tileWidth)][int(y/tileHeight+1)]!='!') {
      y -= (y-int(y/tileHeight)*int(tileHeight));
      acceleration = 36;
    }
  }

 //Moves mario depending on which key you press
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