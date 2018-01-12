class RegularBrick{
  
  
  RegularBrick(){
    
    
    
    
  }
  
  void display(int location, int x, int y){
    
      if (location == '#') {
    image(platform, x, y, tileWidth, tileHeight);
  }  
       
  }
  
  void marioHittingBrick() {
    if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1]== 'Y') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W'){
       tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1] = '.';
      }
    }
  }
  
  
  
}