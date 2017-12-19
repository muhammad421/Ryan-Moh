class Mario {
  //Image
  PImage p1, p2, p3;
  //How big is he
  float y, lastMove, delay, fallSpeed, gravity, dy, jumpSpeed;
  //Moving Mario
  int tilesHigh, tilesWide, x, n,counter;
  boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft,canGoLeft,canGoRight,canJump;

//declaring all the mario variables
  Mario() {  
    p1 = loadImage("p1.png");
    p2 = loadImage("p2.png");
    p3 = loadImage("p3.png");
   
    falling = false;
    jumping = false;
    jumpSpeed = 0;
    fallSpeed = 0;
    marioUp = false;
    marioLeft = false;
    marioRight = false;
    gravity = 5;

    x =0;
    n=0;
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
    y= int (height - 2*tileHeight);
  }

//Moves Mario
  void move() {
    //textSize(32);
    //fill(0);
    //text(counter,32,32);
    ////Detects if your on a coin ***NEEDS TO BE WORKED ON***
    //if (tiles[int(x/tileWidth)][int(y/tileHeight)]=='C') {
    //   tiles[int(x/tileWidth)][int(y/tileHeight)]='.';
    //   counter++;
    //}


    //mario moving
    if (marioUp == true&&canJump==true) {
      jumping = true;
    }
    if (jumping == true&&canJump==true) {
      jump();
    }
    if (marioLeft == true&&canGoLeft == true) {
      x+=tileWidth/2;
      walking();
    }
    if (marioRight == true&&canGoRight == true) {
      x-=tileWidth/2;
      walking();
    }
    //Goes to next Level if off screen
    nextLevel();
    
    //Walking Animation
    if (isWalking == false) {
      image(p3, x, y, tileWidth, tileHeight);
    } else {
      image(p2, x, y, tileWidth, tileHeight);
    }
  }
  
  //Determins if you can goto next level
  void nextLevel() {
    if (x >= width) {
      n++;
      x= 10;
    } else if (x <=0&&n!=0) {
      n--;
      x = width -10;
    } else if ( n == 3) {
      n = 0;
    } else if ( n == 0&& x < 0) {
      x = width -10;
    }
    else if (y>height){
      y= int (height - 2*tileHeight);
    }
    else if (y<0){
      y= int (height - 2*tileHeight);
    }
  }

//Walking timing
  void walking() {
    if (millis() > lastMove + delay) {
      isWalking = !isWalking;
      lastMove = millis();
    }
  }

//Sees if you are colliding with the grid
  void collidingWithGrid() {
    if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]=='#'&&((y/tileHeight)+1)!=19) {
      falling = false;
      jumping = false;
    } 
    else if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]!='#'&&((y/tileHeight)+1)!=19) {
      y += 2*gravity;
    }
    if (tiles[int(x/tileWidth)+1][int(y/tileHeight)]=='#') {
     canGoLeft =false;
    }
    else {
      canGoLeft = true;
    }
    if (x/tileWidth>=1){
    if (tiles[int(x/tileWidth)-1][int(y/tileHeight)]=='#') {
     canGoRight =false;
    }
    else {
      canGoRight = true;
    }
    }

  }

//Allows you to jump
  void jump() {
    y -=tileHeight;
    falling = true;
    if (falling == true) {
      gravity();
    }
  }
  
//Prevents you from going too high
  void gravity() {
    y =int( y + jumpSpeed);
    jumpSpeed +=gravity;
    if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]=='#') {
      if ((int(y/tileHeight))<=(y/tileHeight)){
        y = y-(int(y/tileHeight))-(y/tileHeight);
      jumping = false;
      falling = false;
      jumpSpeed = 0;
      }
    }
  }


  void keypressed() {

    if (key == 'w' || key == 'W') {
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
      marioUp = false;
    } 
    if (key== 'a' || key=='A') {
      marioRight = false;
    }
    if (key== 'd' || key=='D') {
      marioLeft = false;
    }
  }
  
  //Loads text file

}