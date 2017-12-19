class Coin{
  int x,y;
 
  
  Coin(){
    
    
  }
    
    void onCoin (Mario theCharacter,int location, int x, int y){
      if (location == 'C'){
      if (mario.x == x*tileWidth&& mario.y == y*tileHeight){
        tiles[x][y] = '.';
        
      }
      }
    }
    


  
  
}