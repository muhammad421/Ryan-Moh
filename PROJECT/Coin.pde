class Coin{
  int counter;
  
  Coin(){
    counter = 0;
    
  }
    
  void onCoin () {
if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] == 'C'){
  tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] = '.';
  counter++;
}
  }

void displayPoints(){
textSize(32);
text(counter, 100, 100);
  
}
  
}