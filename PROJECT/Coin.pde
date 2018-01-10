class Coin{
  int counter, coinCounter;
  PImage[] coinSpin = new PImage[6];

  
  Coin(){
    counter = 0;
    coinCounter = 0;
    
    for (int i = 0; i<coinSpin.length; i++){
      coinSpin[i] = loadImage("coin"+i+".png");
    }
  }
    
  void onCoin () {
if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] == 'C'){
  tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] = '.';
  counter++;
}
  }
  void displayCoin(int location, int x, int y){
    if (location == 'C') {
      image(coinSpin[coinCounter], x,y, tileWidth, tileHeight);
      if (frameCount %1 == 0){
        coinCounter ++;
        coinCounter = coinCounter % coinSpin.length;
      }
        
  }
  }
void displayPoints(){
textSize(32);
text(counter, 100, 100);
  
}

  
}