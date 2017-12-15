class Coin{
  int x,y;
  
  
  Coin(){
    
    
    
    
  }
  //void placeCoins(){
  //    if (tiles[int(x/tileWidth)][int(y/tileHeight)]=='C') {
  //     tiles[int(x/tileWidth)][int(y/tileHeight)]='.';
  //  }
  //}
  void showTile(Mario theMario, char location, int x, int y) {
    if (location == 'C') {
    image(empty, x*tileWidth, y*tileHeight, tileWidth, tileHeight);
    
  }
  }

  
  
}