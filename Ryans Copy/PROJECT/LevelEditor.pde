class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight, vertical;
  boolean clicked, scanning, once,onGrid,saveOnce;
  char letter;
  String words = "";  
  int counter, counter1;
  
  LevelEditor() {
    saveOnce = false;
    once = false;
    vertical = 0;
    cols = 20;
    rows = 20;
    board = new int[cols][rows];
    cellWidth = (450)/cols;
    cellHeight = (450)/rows;
    counter = 0;
    counter1 = 0;
    scanning = true;
  }
  void makeGrid() {
    if (once == false) {
      background(0);
      for (int x=0; x<cols; x++) { 
        for (int y=0; y<rows; y++) { 
          board[x][y] = 1;
        }
      }
      once = true;
    }
  }
  void displayGrid() {
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) {
        if (board[x][y] == 1) {
          fill(255);
          rect(x*cellWidth, y*cellHeight, cellWidth, cellHeight);

          if (y < rows - 1) {
            words = words + ".";
          } else {
            words = words + " ";
            vertical = vertical+1;
          }
        }
        if (board[x][y] == 2) {
          image(platform, x*cellWidth, y*cellHeight, cellWidth, cellHeight);

          if (y < rows - 1) {
            words = words + "#";
          } else {
            words = words + " ";
            vertical = vertical+1;
          }
        }
        if (vertical == 19) {
         String[] list = split(words, ' ');
          saveStrings("data/levels/10.txt", list);
        }
      }
    }
  }
  void mouseOnGrid(){
  if (mouseX<= width-262){
   if (mouseX>= 0){
    if(mouseY <= height - 262){ 
     if (mouseY >=0){
     onGrid = true;
     }
     else{
           onGrid = false;
     }
    }
    else {
          onGrid = false; 
    }
   }
   else {
         onGrid = false; 
   }
  }
  else {
        onGrid = false; 
  }
}

  void placeBlock() {

    mouseOnGrid();
    if (onGrid == true){
    if (mousePressed == true){
  println("asd");
   board[mouseX/22][mouseY/22] = 2;  
    }
    }
}


  void saveButton(){
    if (saveOnce == false){
    if (save == true){
            println("sadas");
          String[] list = split(words, ' ');
          saveStrings("data/levels/10.txt", list);
          saveOnce = true;
    }
    if (load == true){
            println("ljhjhk");
     
    }

    }
  }
    
    
  
  void mousePressed() {
    clicked = true;
  }
}