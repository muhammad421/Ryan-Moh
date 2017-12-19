class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight;
  boolean clicked;
  
  
  LevelEditor() {
    cols = 20;
    rows = 20;
    board = new int[cols][rows];
    cellWidth = (450)/cols;
    cellHeight = (450)/rows;
  }

  void makeGrid() {
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
          }
          if (board[x][y] == 2){
           image(platform, x*cellWidth+140, y*cellHeight+140, cellWidth, cellHeight);
          }
        }
      }
    }
    void mousePressed(){
     clicked = true; 
      
    }
  }