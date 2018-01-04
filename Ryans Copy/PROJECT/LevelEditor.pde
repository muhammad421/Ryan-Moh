class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight, vertical;
  boolean clicked, scanning, once;
  char letter;
  String words = "";  
  int counter, counter1;
  LevelEditor() {
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
          board[x][y] = 2;
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
          rect(x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);

          if (y < rows - 1) {
            words = words + ".";
          } else {
            words = words + " ";
            vertical = vertical+1;
          }
        }
        if (board[x][y] == 2) {
          image(platform, x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);

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
  void mousePressed() {
    clicked = true;
  }
}