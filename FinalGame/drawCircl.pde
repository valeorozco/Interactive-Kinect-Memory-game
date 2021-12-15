class drawCircles{
  PVector circlPos = new PVector();
  int x, y, lvl;
  ArrayList<PVector> circls = new ArrayList<PVector>();
  boolean correctPos = true;
  
  drawCircles(int level){
    
   lvl = level;

   while (circls.size() < lvl){
     x = int(random(100, width-100));
     y = int(random(100, height-100));
     
     circlPos.x = x;
     circlPos.y = y;
     
     correctPos = true;
     
     if (circls.size() == 0){
       circls.add(new PVector(x,y));
       }
         
     else {
       for (int pos_ = 0; pos_ < circls.size(); pos_++){
         if (circls.get(pos_).dist(circlPos) < 200){
           correctPos = false;
         }
       }
          
       if (correctPos){
         circls.add(new PVector(x, y));
       }
     }
   }
  }

  ArrayList<PVector> getC_Array(){
    return circls;
  }
}
