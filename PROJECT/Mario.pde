class Mario {
  //Image
  PImage[]marioWalk = new PImage[4];
  PImage stillMario;
  //How big is he
  float lastMove, delay, fallSpeed, gravity, dy, acceleration;
  //Moving Mario
  int tilesHigh, tilesWide, x, y, n, counter, flipThroughPicture,marioCounter;
  boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft, canGoLeft, canGoRight, canJump;

  //declaring all the mario variables
  Mario() {  
    stillMario = loadImage("smallMarioRunning4.png");
    marioCounter = 0;

for(int i =0; i<marioWalk.length; i++){
  marioWalk[i] = loadImage("smallMarioRunning"+i+".png");
}

    falling = false;
    jumping = false;
    acceleration = 36;
    marioUp = false;
    marioLeft = false;
    marioRight = false;
    gravity = 5;

    x =0;
    n=0;
    flipThroughPicture = 1;
    counter = 0;
    isWalking = false;
    isMoving =false;
    onGround = true;
    canIJump = true;
    canGoLeft = true;
    canGoRight = true;
    canJump = true;
    delay = 150;
    lastMove = millis();
    y= int (height - 3*tileHeight);

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
      x+=20;
      isWalking = true;
    }
    if (marioRight == true&&canGoRight == true) {
      x-=20;
      isWalking = true;
    }
    //Goes to next Level if off screen
    nextLevel();
    if (isWalking == true){
      walking();      
    }
    else{
            image(stillMario, x, y, tileWidth, tileHeight);
    }
  }

  //    
  //Determins if you can goto next level
  void nextLevel() {
    if (x >= width) {
      n++;
      x= 10;
      loadLevel(n);
    } else if (x <=0&&n!=0) {
      n--;
      x = width -10;
      loadLevel(n);
    } else if ( n == 9) {
      n = 0;
      loadLevel(n);
    } else if ( n == 0&& x < 0) {
      x = width -10;
    } else if (y>height) {
      y= int (height - 2*tileHeight);
    } else if (y<0) {
      y= int (height - 2*tileHeight);
    }
  }

  //Walking timing
  void walking() {
    image (marioWalk[marioCounter],x,y,tileWidth,tileHeight);
    if (frameCount%1 ==0){
      marioCounter++;
      marioCounter = marioCounter % marioWalk.length;
      
    }
  }

  //Sees if you are colliding with the grid
  void collidingWithGrid() {
    if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]!='#') {
      y += 2*gravity;
    }
    if (tiles[int(x/tileWidth)][int(y/tileHeight)-1]=='#') {
      acceleration = 0;
    }
    if (tiles[int(x/tileWidth)+1][int(y/tileHeight)]=='#') {
      canGoLeft =false;
    } else {
      canGoLeft = true;
    }
    if (x/tileWidth>=1) {
      if (tiles[int(x/tileWidth)-1][int(y/tileHeight)]=='#') {
        canGoRight =false;
      } else {
        canGoRight = true;
      }
    }
  }

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
    y+=3.81;
    if (tiles[int(x/tileWidth)][int(y/tileHeight+1)]=='#') {
      y -= (y-int(y/tileHeight)*int(tileHeight));
      falling = false;
      acceleration = 36;
      marioUp = false;
    }
  }


  void keypressed() {

    if (key == 'w' || key == 'W'&&(falling ==false)) {
      marioUp = true;
     if (tiles[int(x/tileWidth)][int(y/tileHeight)-1]=='#') {
      tiles[int(x/tileWidth)][int(y/tileHeight)-1] ='.';
      tiles[int(x/tileWidth)][int(y/tileHeight)-2] ='#';
       }
             
      
      if (millis() > lastMove + delay) {
      lastMove = millis();
      tiles[int(x/tileWidth)][int(y/tileHeight)-2] ='.';
    }

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
      flipThroughPicture =1;
    }
    if (key== 'd' || key=='D') {
      marioLeft = false;
      flipThroughPicture =1;
    }
  }
}