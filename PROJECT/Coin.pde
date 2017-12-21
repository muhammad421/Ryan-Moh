class Coin{
  
  Coin(){
    
    
  }
    
  void onCoin (int location, int i, int o) {
    if (location == 'C') {
      if (mario.x/tileWidth== i&& mario.y/tileHeight == o) {
        tiles[i][o] = '.';
      }
    }
  }
  
}