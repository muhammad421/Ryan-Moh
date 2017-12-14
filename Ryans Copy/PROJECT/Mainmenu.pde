class Mainmenu {
  PImage mainScreen, shroom, brick;
  int shroomX, shroomY;
  int shroomLocation;
  Mainmenu() {
    mainScreen = loadImage("mainscreen.jpg");
    shroom = loadImage("lilshroom.png");
    brick = loadImage("brick.jpg");
    shroomLocation = 1;
    shroomX = 510;
    shroomY = 417;
  }
  void menu() {
    keypressed();
    shroom();

    image(mainScreen, 0, 0, width, height); 
    image(shroom, shroomX, shroomY, 35, 35);

  }
  void keypressed() {

    if (key == 'w' || key == 'W') {
      shroomLocation = 1;
    } 
    if (key== 's' || key=='S') {
      shroomLocation = 2;
    }
    if (key == ENTER || key == ENTER){
      if (shroomLocation == 1){
       state = 1; 
      }
    }
  }
  void shroom(){
   if (shroomLocation == 1){
        shroomY = 417;
   }
   if (shroomLocation == 2){
         shroomY = 467;
   }
    
  }
}