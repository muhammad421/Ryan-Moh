class RegularBrick{
  int k ,l;
  
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
        //if (tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='Y'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='D') {
      //mario.canGoLeft =false;
    //} else {
    //  mario.canGoLeft = true;
    //}
        //if (mario.x/tileWidth>=1) {
      //if (tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='Y'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='D') {
        //mario.canGoRight =false;
      //} else {
        //mario.canGoRight = true;
      //}
    //}
  }
  void rectangle(){
        //println((l+tileWidth)/tileWidth,((k)/tileHeight));

  }
    void keypressed(){
      if (key == 'y' || key == 'Y'){
        k -=5;
      }
      if (key == 'h' || key == 'H'){
        k +=5;
      }
      if (key == 'j' || key == 'J'){
        l +=5;
      }
      if (key == 'g' || key == 'G'){
        l -=5;
      }
    }
  
  
}