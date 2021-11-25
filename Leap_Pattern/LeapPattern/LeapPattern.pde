float stMillisPat = 0, stMillisLine = 0, crMillisPat;
float prevCX, prevCY, actualCX, actualCY, distMC, textTime = 0;

int[] initialPat = {0, 1, 2, 3, 4, 5};
int periodPat = initialPat.length * 1000, periodLine = periodPat/5 - 100, countPat = 0, circlPos = -1;
int posi;

boolean containsC = false, correctPat =false, notContains = true, passed = false;

ArrayList<drawCirc> circls = new ArrayList<drawCirc>();
ArrayList<Integer> pattern = new ArrayList<Integer>();

PVector handPosition = new PVector();

import de.voidplus.leapmotion.*;
LeapMotion leap;

void setup() {  
  size(600,400);
  background(0);
  
  leap = new LeapMotion(this);
  
  // We start by adding 6 circles at RANDOM positions in an ARRAYLIST called circls.
  circls.add(new drawCirc(1, 20, 20));
  circls.add(new drawCirc(2, 20, 20));
  circls.add(new drawCirc(3, 20, 20));
  circls.add(new drawCirc(4, 20, 20));
  circls.add(new drawCirc(5, 20, 20));
  circls.add(new drawCirc(6, 20, 20));
  
}

void draw(){
  background(255);
  
  // To DISPLAY the circles on canvas.
  for (int i = 0; i < circls.size(); i++){
    circls.get(i).displayCirc(); 
  }
  
  patternToDo();
  
  if (crMillisPat - stMillisPat > periodPat) {
    drawPattern();
  }
  
  if (passed){
    textSize(50);
    text("WELL DONE!", 100, 100);
    if (crMillisPat - textTime > 2000){
      passed =  false;
    }
  }
  
  else if (!correctPat){
    textSize(50);
    text("TRY AGAIN!", 100, 100);
    if (crMillisPat - textTime > 2000){
      correctPat =  true;
    }
  }
}

void patternToDo(){
  crMillisPat = millis();  
  if (crMillisPat - stMillisPat < periodPat) {
    for (int intP1 = 0; intP1 < countPat -1; intP1++){
        prevCX = circls.get(initialPat[intP1]).x;
        prevCY = circls.get(initialPat[intP1]).y;
        actualCX = circls.get(initialPat[intP1+1]).x;
        actualCY = circls.get(initialPat[intP1+1]).y;
        fill(0);
        line(prevCX, prevCY, actualCX, actualCY);
      } 
      
    if (crMillisPat - stMillisLine >= periodLine){
      stMillisLine = crMillisPat;
      countPat += 1;
    } 
  }  
}

void drawPattern(){
  /*
  for (Hand hand : leap.getHands ()) {
    handPosition = hand.getPosition();
    hand.draw();
  }
  
  fill(153);
  circle(handPosition.x, handPosition.y, 5);*/
  
  handPosition.x = mouseX;
  handPosition.y = mouseY;
  
  for (int i = 0; i < circls.size(); i++){
    distMC = circls.get(i).getCVect().dist(handPosition);
    if (distMC < 50){
      circlPos = i;
    }
  }
  
  if (pattern.size() == 0 && circlPos != -1){
    pattern.add(circlPos);
  }
  
  containsC = false;
  
  if (pattern.size() > 0) {
    for (int i = 0; i < pattern.size(); i++){
      if(pattern.get(i) == circlPos){
        containsC = true;
      }
    }
    if (!containsC && circlPos != -1){
      pattern.add(circlPos);
    }
  }
  
  if (pattern.size() >= 2 && pattern.size() < 7){
    for (int i = 1; i <= pattern.size()-1; i++){
       prevCX = circls.get(pattern.get(i-1)).x;
       prevCY = circls.get(pattern.get(i-1)).y;
       actualCX = circls.get(pattern.get(i)).x;
       actualCY = circls.get(pattern.get(i)).y;
       fill(0);
       line(prevCX, prevCY, actualCX, actualCY);            
    }
  }
  
  if (pattern.size() >= 6) {
    countPat = 0;
    circlPos = -1;
    stMillisLine = 0;
    stMillisPat = crMillisPat;
    
    newPattern();
  }
}

void newPattern(){
  correctPat = true;
  for(int mat = 0; mat <6; mat++){
    if (pattern.get(mat) != initialPat[mat]){
      correctPat = false;
    }
  }
  pattern = new ArrayList<Integer>();
      
  if (correctPat){    
    passed = true;
    
    circls.set(0, new drawCirc(1, 20, 20));
    circls.set(1, new drawCirc(2, 20, 20));
    circls.set(2, new drawCirc(3, 20, 20));
    circls.set(3, new drawCirc(4, 20, 20));
    circls.set(4, new drawCirc(5, 20, 20));
    circls.set(5, new drawCirc(6, 20, 20));
        
    int cc = 0;
    for (int i = 0; i < 6; i++){
      initialPat[i] = -1;
    }
    while (cc < 6){        
      posi = int(random(0,6));
      notContains = true;
      for (int com = 0; com < 6; com++){
        if (initialPat[com] == posi){
          notContains = false;
        }
      }
      if (notContains){
        initialPat[cc] = posi;
        cc += 1;
      }
    }
  }
  
  textTime = crMillisPat;
}
