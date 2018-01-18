class Coin {

  //Variables
  int coinCounter;
  PImage[] coinSpin = new PImage[6];

  //Constructors 
  Coin() {
    coinCounter = 0; 
    
    //Calls all images for coin
    for (int i = 0; i<coinSpin.length; i++) {
      coinSpin[i] = loadImage("coin"+i+".png");
    }
  }

//Detects if Mario is on coin and allows the player to collect it
  void onCoin () {
    if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] == 'C') {
      tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] = '.';
      counter++;
    }
  }
  
//displays the coin at given locations, from the txt file
  void displayCoin(int location, int x, int y) {
    if (location == 'C') {
      image(coinSpin[coinCounter], x, y, tileWidth, tileHeight);
      if (frameCount %4 == 0) {
        coinCounter ++;
        coinCounter = coinCounter % coinSpin.length;
      }
    }
  }
  
//Displays points in top left
  void displayPoints() {
    textSize(32);
    text(counter, 100, 100);
  }
}