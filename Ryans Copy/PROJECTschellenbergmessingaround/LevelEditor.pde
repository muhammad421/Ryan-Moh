class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight, vertical,counter;
  boolean clicked, go, go1;
  char letter;
  String words;  


  LevelEditor() {
    cols = 20;
    rows = 20;
    board = new int[cols][rows];
    cellWidth = (450)/cols;
    cellHeight = (450)/rows;
    words = "";
    go = false;
    go1 = go;
    vertical = 0;
    counter = 0;
  }
  void assignValues() {
  if (counter < (rows*cols)) {
    board[x][y]=1;
    counter++;
  }
  }
  
  void makeGrid() {
    background(0);
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) { 
        assignValues();
          fill(255);
          rect(x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);
      }
    }
  }
  void displayGrid() {
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) {
        if (board[x][y] == 1) {


          if (y < rows - 1) {
            words = words + ".";
          } else {
            words = words + " ";
            vertical = vertical+1;
          }
          if (x < cols - 1) {
            go = true;
          }
        }

        if (board[x][y] == 2) {
          image(platform, x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);
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