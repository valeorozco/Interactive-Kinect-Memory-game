 float stMillisPat = 0, stMillisLine = 0, crMillisPat;
float prevCX, prevCY, actualCX, actualCY, distMC, textTime = 0;

ArrayList<Integer> initialPat = new ArrayList<Integer>();

int periodPat = 5000, periodLine = 800, countPat = 0, circlPos = -1;
int posi, lvl_ = 6;

boolean containsC = false, correctPat = true, notContains = true, passed = false;

drawCircles circPat;

ArrayList<PVector> circles = new ArrayList<PVector>();
ArrayList<Integer> pattern = new ArrayList<Integer>();

PVector handPosition = new PVector();

import de.voidplus.leapmotion.*;
LeapMotion leap;

void setup() {  
  size(1000,600);
  background(0);
  
  initialPat.add(0); initialPat.add(1); initialPat.add(2); initialPat.add(3);
  initialPat.add(4); initialPat.add(5);
  
  leap = new LeapMotion(this); 
  // We start by adding 6 circles at RANDOM positions in an ARRAYLIST called circls.
  circPat = new drawCircles(6);
  circles = circPat.getC_Array();
}

void draw(){
  background(255);
  
  // To DISPLAY the circles on canvas.
  for (int i = 0; i < circles.size(); i++){
    fill(0);
    ellipse(circles.get(i).x, circles.get(i).y, 20, 20); 
  }

  patternToDo(); // This function draws the pattern that helps the user to redraw it.
  
  if (crMillisPat - stMillisPat > periodPat) { // Check if the PATTERNTODO has been made.
    drawPattern(); // Gets the input from Leap Motion to draw the pattern by the user.
  }
  
  if (passed){ // If the user has drawn the Pattern correctly.
    textSize(50);
    fill (0);
    text("WELL DONE!", 100, 100);
    if (crMillisPat - textTime > 2000){
      passed =  false;
    }
  }
  
  else if (!correctPat){ // Incorrectly drawn.
    textSize(50);
    fill (0);
    text("TRY AGAIN!", 100, 100);
    if (crMillisPat - textTime > 2000){
      correctPat =  true;
    }
  }
}

void patternToDo(){
  crMillisPat = millis(); // 5 seconds to draw the whole Pattern by computer. 
  if (crMillisPat - stMillisPat < periodPat) {
    for (int intP1 = 0; intP1 < countPat -1; intP1++){ // To get the 2 points used to make a LINE in between.
        prevCX = circles.get(initialPat.get(intP1)).x;
        prevCY = circles.get(initialPat.get(intP1)).y;
        actualCX = circles.get(initialPat.get(intP1+1)).x;
        actualCY = circles.get(initialPat.get(intP1+1)).y;
        fill(0);
        line(prevCX, prevCY, actualCX, actualCY);
      } 
      
    if (crMillisPat - stMillisLine >= periodLine){ // Each line is made ~0.9 sec.
      stMillisLine = crMillisPat;
      countPat += 1; // Helps to advance the previous FOR LOOP EACH ~0.9 sec.
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
  
  for (int i = 0; i < circles.size(); i++){ // To get the DISTANCE between imput coordinates and nearest circle.
    distMC = circles.get(i).dist(handPosition);
    if (distMC < 50){ // Threshold for drawing the lines.
      circlPos = i; // Save circle's position.
    }
  }
  
  if (pattern.size() == 0 && circlPos != -1){ // Initializing Arraylist called "pattern" (saves pattern drawn by the user) 
    pattern.add(circlPos);
  }
  
  containsC = false;
  
  if (pattern.size() > 0) { // Check if the Circle is already in "pattern".
    for (int i = 0; i < pattern.size(); i++){
      if(pattern.get(i) == circlPos){
        containsC = true;
      }
    }
    if (!containsC && circlPos != -1){ // If not in "pattern", add it.
      pattern.add(circlPos);
    }
  }
  
  if (pattern.size() >= 2 && pattern.size() < lvl_+1){ // Start drawing if "pattern" has at least 2 values.
    for (int i = 1; i <= pattern.size()-1; i++){
       prevCX = circles.get(pattern.get(i-1)).x;
       prevCY = circles.get(pattern.get(i-1)).y;
       actualCX = circles.get(pattern.get(i)).x;
       actualCY = circles.get(pattern.get(i)).y;
       fill(0);
       line(prevCX, prevCY, actualCX, actualCY);            
    }
  }
  
  if (pattern.size() >= lvl_) { // Initialize the timer and other variables to start a new pattern.
    countPat = 0;
    circlPos = -1;
    stMillisLine = 0;
    stMillisPat = crMillisPat;
    
    newPattern(); // F(x) to create a new RANDOM pattern by computer.
  }
}

void newPattern(){
  correctPat = true;
  printArray(pattern);
  printArray(initialPat);
  for(int mat = 0; mat < pattern.size(); mat++){ // Check if user has made the pattern correctly.
    if (pattern.get(mat) != initialPat.get(mat)){
      correctPat = false;
    }
  }
  
  pattern.clear();
      
  if (correctPat){ // If correct pattern, prepare a new one (afterwards drawn in F(x) "patternToDo".
    passed = true;
    lvl_ += 1;
    
    initialPat.clear();
    
    while (initialPat.size() < lvl_){ // Add new pattern to be made in "initialPat".
      posi = int(random(0, lvl_));
      notContains = true;
      
      if (initialPat.size() == 0){
        initialPat.add(posi);
      } else {     
          for (int com = 0; com < initialPat.size(); com++){
            if (initialPat.get(com) == posi){
              notContains = false;
            }
          }
          if (notContains){
            initialPat.add(posi);
          }
      }
    }
  }
  
  circPat = new drawCircles(lvl_);
  circles = circPat.getC_Array();
  periodPat = (lvl_ - 1) * 1000;
  periodLine = (periodPat/(lvl_-1)) - 100;
  textTime = crMillisPat;
}
