class Coin{
  int x,y;
 
  
  Coin(){
    
    
  }
    
    void onCoin (Mario theCharacter,int location, int x, int y){
      if (location == 'C'){
      if (theCharacter.x == x*tileWidth&& theCharacter.y == y*tileHeight){
        tiles[x][y] = '.';
        
      }
      }
    }
    


  
  
}