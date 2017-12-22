class Coin{
  
  Coin(){
    
    
  }
    
  void onCoin () {
if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] == 'C'){
  tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)] = '.';
}
  }
  
}