class LevelEditor {
  int [][] board;
  int cols, rows, cellWidth, cellHeight, vertical;
  boolean clicked, scanning, once, onGrid, saveOnce;
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
    cellWidth = (600)/cols;
    cellHeight = (600)/rows;
    counter = 0;
    counter1 = 0;
    scanning = true;
    block= 1;
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
            vertical = vertical+1;
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
            vertical = vertical+1;
          }
        }

        if (board[x][y] == 3) {
          image(coin, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

           if (y < rows) {
            words = words + "C";
          } 
          if (y >= rows -1) {
            words = words + " ";
            vertical = vertical+1;
          }
        }

        if (board[x][y] == 4) {
          image(platform, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "#";
          } 
          if (y >= rows -1) {
            words = words + " ";
            vertical = vertical+1;
          }
        }
        if (board[x][y] == 5) {
          image(dirt, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "D";
          } 
          if (y >= rows -1) {
            words = words + " ";
            vertical = vertical+1;
          }
        }        
        if (board[x][y] == 6) {
          image(brick, y*cellWidth, x*cellHeight, cellWidth, cellHeight);

          if (y < rows) {
            words = words + "Y";
          } 
          if (y >= rows -1) {
            words = words + " ";
            vertical = vertical+1;
          }
        }                

//        if (vertical == 19) {

//          String[] list = split(words, ' ');
 //         saveStrings("data/levels/10.txt", list);
  //      }
      }
    }
  }
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

  void placeBlock() {

    mouseOnGrid();
    if (onGrid == true) {
      if (mousePressed == true) {
        println("asd");
        board[mouseY/30][mouseX/30] = block;
      }
    }
  }


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