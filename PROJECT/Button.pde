class Button {
  String label;
  float x;    
  float y;   
  float w;    
  float h;  
  float selectButton;
  float c;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, float _selectButton, float c_) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    c = c_;
    selectButton = _selectButton;
    save = false;
    load = false;
  }
  
  void Draw() {
      textSize(20);
      if (c ==1){
    fill(#3FBFFF);
      }
      if (c == 2){
       fill(#3FBFFF); 
      }
    stroke(141);
      noStroke();
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
  fill(255);
      textFont(font);
    text(label, x + (w / 2), y + (h / 2));
  }
  void clicked(){
    if (MouseIsOver() ==true){ 
      w = 110;
      h = 55;
      if(mousePressed == true){

      if (selectButton==1){
       save = true;
      }
      if (selectButton==2){
        load = true;
      }
      if (selectButton ==3){
        state = 0;
        mario.x = 0;
        mario.y = 620;
        mario.n = 0;
      }
      if (selectButton == 4){
       state = 4; 
      }
      }

    }
        else{
          w = 100;
    h = 50;
      }  
    
  }
  boolean MouseIsOver() {
    if (mouseX > x && mouseX < (x + w) && mouseY > y && mouseY < (y + h)) {
      return true;
    }
    return false;
  }
}