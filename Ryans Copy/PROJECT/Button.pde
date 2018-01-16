class Button {
  String label;
  float x;    
  float y;   
  float w;    
  float h;  
  float selectButton;
  
  Button(String labelB, float xpos, float ypos, float widthB, float heightB, float _selectButton) {
    label = labelB;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    selectButton = _selectButton;
    save = false;
    load = false;
  }
  
  void Draw() {
      textSize(20);
    fill(#68E0D9);
    stroke(141);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    fill(0);
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