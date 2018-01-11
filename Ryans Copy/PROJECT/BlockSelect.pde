class BlockSelect {
  PImage image;
  float x;    
  float y; 
  float w;
  float h;

  BlockSelect(PImage image_, float xPos, float yPos, float w_, float h_) {
    image = image_;
    x = xPos;
    y = yPos;
    w = w_;
    h = h_;
  }

  void Draw() {
    image(image, x, y, w, h);
  }


  void clicked() {
    if (MouseIsOver() ==true) { 
      w = 35;
      h = 35;
      if (mousePressed == true) {
println("asdad");
        }
    } 
    else {
      w = 30;
      h = 30;
    }
  }
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {

      return true;
    }
    return false;
  }
}