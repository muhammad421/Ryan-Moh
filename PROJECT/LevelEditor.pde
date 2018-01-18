class LevelEditor {
  
//variables
  int [][] board;
  int cols, rows, cellWidth, cellHeight;
  boolean clicked, once, onGrid, saveOnce;
  char letter;
  String words = "";  


//Constructor
  LevelEditor() {
    saveOnce = false;
    once = false;
    cols = 20;
    rows = 20;
    board = new int[cols][rows];
    cellWidth = (600)/cols;
    cellHeight = (600)/rows;
    block= 1;
  }
  
//Initially makes the grid
  void makeGrid() {
    text("BLOCKS", 655,20);
    text("ERASER", 655,470);
    if (once == false) {
      for (int x=0; x<cols; x++) { 
        for (int y=0; y<rows; y++) { 
          
          board[x][y] = 1;
        }
      }
      once = true;
    }
  }
  
//creates and draws the grid filled with the correct blocks 
  void displayGrid() {
    board[19][0] = 4;
    words = "";
    for (int x=0; x<cols; x++) { 
      for (int y=0; y<rows; y++) {
        if (board[x][y] == 1) {
          fill(255);
          stroke(1);
          rect(y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + ".";
          } 
          if (y >= rows -1) {
            words = words + " ";

          }
        }
        if (board[x][y] == 2) {
          image(box, y*cellWidth, x*cellHeight, cellWidth, cellHeight);
          
          if (y < rows) {
            words = words + "B";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }

        if (board[x][y] == 3) {
          image(coin, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

           if (y < rows) {
            words = words + "C";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }

        if (board[x][y] == 4) {
          image(platform, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "#";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }
        if (board[x][y] == 5) {
          image(dirt, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "D";
          } 
          if (y >= rows -1) {
            words = words + " ";

          }
        }        
        if (board[x][y] == 6) {
          image(brick, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "Y";
          } 
          if (y >= rows -1) {
            words = words + " ";
          }
        }                
      }
    }
  }
  

//Detects if the mouse is on the grid 
  void mouseOnGrid() {
    if (mouseX<= width-121) {
      if (mouseX>= 0) {
        if (mouseY <= height - 101) { 
          if (mouseY >=0) {
            onGrid = true;
          } else {
            onGrid = false;
          }
        } else {
          onGrid = false;
        }
      } else {
        onGrid = false;
      }
    } else {
      onGrid = false;
    }
  }

//Places the selected block onto the grid
  void placeBlock() {
    mouseOnGrid();
    if (onGrid == true) {
      if (mousePressed == true) {
        println("asd");
        board[mouseY/30][mouseX/30] = block;
      }
    }
  }

//If the save button is clicked, saves to the txt fiel
  void saveButton() {
    if (saveOnce == false) {
      if (save == true) {
        println("sadas");
       words = words.substring(0, max(0, words.length() - 1));
        String[] list = split(words, ' ');
        saveStrings("data/levels/10.txt", list);
        saveOnce = true;
        save = false;
      }
      if (load == true) {
        state =1;
        n = 10;
      }
    }
  }



  void mousePressed() {
    clicked = true;
  }
}