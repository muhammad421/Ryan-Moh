class BlockSelect {
  
//variables
  PImage image;
  float x, y, w, h;    
  float selectBlock;

//Constructor
  BlockSelect(PImage image_, float xPos, float yPos, float w_, float h_, float selectBlock_) {
    image = image_;
    x = xPos;
    y = yPos;
    w = w_;
    h = h_;
    selectBlock = selectBlock_;
  }

//Creates the blocks
  void Draw() {
    image(image, x, y, w, h);
  }

//Detect which block is selected to be entered into the grid
  void clicked() {
    if (MouseIsOver() ==true) { 
      w = 35;
      h = 35;
      if (mousePressed == true) {
        if (selectBlock == 3) {
          block = 3;
        }
        if (selectBlock == 2) {
          block = 2;
        }
        if (selectBlock == 4) {
          block = 4;
        }
        if (selectBlock == 1) {
          block = 1;
        }
        if (selectBlock == 5) {
          block = 5;
        }     
        if (selectBlock == 6) {
          block = 6;
        }      
        if (selectBlock == 7){
          block = 7;
        }
        println("asdad");
      }
    } else {
      w = 30;
      h = 30;
    }
  }
  
//Tells if the mouse is over the buttons
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {

      return true;
    }
    return false;
  }
}