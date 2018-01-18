class RegularBrick{
  
  //Variables
  RegularBrick(){
    
  }
  
  //Displays the brick at the point read from the text file
  void display(int location, int x, int y){
    
      if (location == '#') {
    image(platform, x, y, tileWidth, tileHeight);
  }  
       
  }
  
  //Detects if Mario is hitting the block and breaks it if hit fron underneath
  void marioHittingBrick() {
    if (tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1]== 'Y') {
      mario.acceleration = 0; 
      if (key == 'w' || key == 'W'){
       tiles[int(mario.x/tileWidth)][int(mario.y/tileHeight)-1] = '.';
      }
    }
  }
  
  
}