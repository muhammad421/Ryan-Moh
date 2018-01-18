class Mainmenu {

  //Variables
  PImage mainScreen, shroom, bricks;
  int shroomX, shroomY ;
  int shroomLocation;

  //Constructor
  Mainmenu() {
    mainScreen = loadImage("mainscreen.jpg");
    shroom = loadImage("lilshroom.png");
    bricks = loadImage("bricks.jpg");
    shroomLocation = 1;
    shroomX = 200;
    shroomY = 400;
  }

  //Draws the mainmenu
  void menu() {
    keypressed();
    shroom();

    image(mainScreen, 0, 0, width, height); 
    image(shroom, shroomX, shroomY, 35, 35);
    textSize(30);
    text("1 PLAYER GAME", 380, 410);
    text("HELP", 380, 487);
    image(bricks, 0, 665, width, 35);
    levelEditor.Draw();
    levelEditor.clicked();
  }

  //Detects which key is pressed, and puts the shroom in the correct location
  void keypressed() {
    if (key == 'w' || key == 'W') {
      shroomLocation = 1;
    } 
    if (key== 's' || key=='S') {
      shroomLocation = 2;
    }
    if (key == ENTER || key == ENTER) {
      if (shroomLocation == 1) {
        counter = 0;
        state = 1;
      }
      if (shroomLocation ==2) {
        state = 3; 
        shroomLocation = 0;
      }
    }
  }

  //Draws and moves the little shroom
  void shroom() {
    if (shroomLocation == 1) {
      shroomY = 400;
      shroomX = 200;
    }
    if (shroomLocation == 2) {
      shroomY = 477;
      shroomX = 280;
    }
  }
}