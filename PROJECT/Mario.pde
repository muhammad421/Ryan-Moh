class Mario {
  //Image
  PImage p1, p2, p3;
  //How big is he
  float lastMove, delay, fallSpeed, gravity, dy, acceleration;
  //Moving Mario
  int tilesHigh, tilesWide, x, y, n, counter;
  boolean isWalking, isMoving, onGround, canIJump, falling, jumping, marioUp, marioRight, marioLeft, canGoLeft, canGoRight, canJump;

  //declaring all the mario variables
  Mario() {  
    p1 = loadImage("p1.png");
    p2 = loadImage("p2.png");
    p3 = loadImage("p3.png");

    falling = false;
    jumping = false;
    acceleration = 36;
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
    //mario moving
    if (marioUp == true) {
      jump();
    }
    if (falling == true) {
      gravity();
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
    } else if ( n == 3) {
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
    } else if (tiles[int(x/tileWidth)][int(y/tileHeight)+1]!='#'&&((y/tileHeight)+1)!=19) {
      y += 2*gravity;
    }
    //else if (tiles[int(x/tileWidth)][int(y/tileHeight)]=='C') {
    //  println("YES");
    // tiles[int(x/tileWidth)][int(y/tileHeight)] = '.';
    //}
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
      println(int(x/tileWidth), int(y/tileHeight)*tileHeight, y);
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