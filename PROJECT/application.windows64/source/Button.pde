class Button {
  
//Local Variables  
  String label;
  float x, y, w, h;    
  float selectButton;

// Constructor
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, float _selectButton ) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    selectButton = _selectButton;
    save = false;
    load = false;
  }


//Creates button
  void Draw() {
    textSize(20);
    fill(#3FBFFF);
    stroke(141);
    noStroke();
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(255);
    textFont(font);
    text(label, x + (w / 2), y + (h / 2));
  }
  

//Detects if clicked and performs designated actions  
  void clicked() {
    if (MouseIsOver() ==true) { 
      w = 110;
      h = 55;
      if (mousePressed == true) {

        if (selectButton==1) {
          save = true;
        }
        if (selectButton==2) {
          load = true;
          state = 1;
          loadLevel(10);
        }
        if (selectButton ==3) {
          state = 0;
          mario.x = 0;
          mario.y = 620;
          mario.n = 0;
          loadLevel(0);
        }
        if (selectButton == 4) {
          state = 4;
        }
        if (selectButton == 5){
          println("sdasd");
         state = 0; 
        }
      }
    } 
    else {
      w = 100;
      h = 50;
    }
  }
  
  
//Boolean if mouse is over the button, if true causes a reaction in clicked()  
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}