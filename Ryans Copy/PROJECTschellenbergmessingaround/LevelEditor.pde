class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight;
  boolean clicked, scanning;
  char letter;
  String words = "";  
  int counter, counter1;
  LevelEditor() {
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


    String[] list = split(words, ' ');   
    saveStrings("data/levels/10.txt", list);     



    background(0);
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) { 
        board[x][y] = 1;
      }
    }
  }
  void displayGrid() {
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) {
        if (board[x][y] == 1) {
          fill(255);
          rect(x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);
          if (scanning == true) {
            words = words + ".";  
            counter++;
            if (counter >= 20 ) {
              words = words + ' ';
              counter = 0;
              counter1++;
            }
            if (counter1 >= 20);
            scanning = false;
          }
        }
        if (board[x][y] == 2) {
          image(platform, x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);
        }
      }
    }
  }
  void mousePressed() {
    clicked = true;
  }
}