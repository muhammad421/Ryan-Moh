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
        if (tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='Y'||tiles[int(mario.x/tileWidth)+1][int(mario.y/tileHeight)]=='D') {
      mario.canGoLeft =false;
    } else {
      mario.canGoLeft = true;
    }
        if (mario.x/tileWidth>=1) {
      if (tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='B'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='#'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='Y'||tiles[int(mario.x/tileWidth)-1][int(mario.y/tileHeight)]=='D') {
        mario.canGoRight =false;
      } else {
        mario.canGoRight = true;
      }
    }
  }
  void rectangle(){
        //println((l+tileWidth)/tileWidth,((k)/tileHeight));
        if (tiles[int((mario.x+tileWidth)/tileWidth)][int(mario.y/tileHeight)]!= '.'){
          fill(0,0,255);
        }
        else if (int((mario.y-tileHeight)/tileHeight)>=0){
           if (tiles[int((mario.x)/tileWidth)][int((mario.y-tileHeight)/tileHeight)]!= '.'){
          fill(255,255,255);
        }
        else{
          fill(255);
        }
        }
        if (tiles[int((mario.x)/tileWidth)][int((mario.y)/tileHeight)]!= '.'){
          fill(0,255,255);
        }
        else if(tiles[int((mario.x)/tileWidth)][int((mario.y+tileHeight)/tileHeight)]!= '.'){
          fill(0,255,0);
        }
        else if(tiles[int((mario.x+tileWidth)/tileWidth)][int((mario.y+tileHeight)/tileHeight)]!= '.'){
          fill(230,255,155);
        }
        else{
         fill(255); 
        }
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