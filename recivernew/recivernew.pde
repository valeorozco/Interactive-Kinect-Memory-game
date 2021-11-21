import oscP5.*;
import netP5.*;
import de.voidplus.leapmotion.*;

NetAddress dest;

LeapMotion leap;

float class_ = 0, prevClas = 0, posX, posY, prevPosX, prevPosY;
float startMillis, startMillis1, startMillis2;
float currentMillis, currentMillis1;
color a = color(255, 204, 0);  
color b = color(127,200,0);
color c = color(220,250,0);


int period = 1200, pat = 1, period1 = 8000, step = 20;
int period2 = 1500, count_ = 0;
int posi;
int currentCircle; //Circle hovered by mouse

boolean correctPat = true, notContains = true;

int[] initialPat = {0, 1, 2, 3, 4, 5};
ArrayList<drawCirc> circls = new ArrayList<drawCirc>();
ArrayList<Integer> pattern = new ArrayList<Integer>();

void setup() {  
  size(600,400);
  background(0);
 
  circls.add(new drawCirc(1, 20, 20));
  circls.add(new drawCirc(2, 20, 20));
  circls.add(new drawCirc(3, 20, 20));
  circls.add(new drawCirc(4, 20, 20));
  circls.add(new drawCirc(5, 20, 20));
  circls.add(new drawCirc(6, 20, 20));
  
  leap = new LeapMotion(this);

}

void draw(){
  background(255);
  /*line(0, height/2, width, height/2);
  line(width/3, 0, width/3, height);
  line(width*2/3, 0, width*2/3, height);*/
    
  for (int i = 0; i < circls.size(); i++){
    circls.get(i).displayCirc(); 
  }
  drawPattern();
  patternToDo();
  currentCircle = eachpointDistance();  
  addpattern();
  
  
}

void addpattern(){
  
 //To fill the array the person does the point can't be repeated, nor it can be equal to.
  if (currentCircle !=-1 && !pattern.contains(currentCircle)){
        pattern.add(currentCircle);
  
 }

}

void patternToDo(){
  currentMillis1 = millis();  
  if (currentMillis1 - startMillis1 < period1) {
    for (int inP = 0; inP < 6; inP++){
      step += 20;
      text(String.valueOf(initialPat[inP]), step, 50);     
    }
    for (int intP1 = 0; intP1 < count_; intP1++){
        prevPosX = circls.get(initialPat[intP1]).getX();
        prevPosY = circls.get(initialPat[intP1]).getY();
        posX = circls.get(initialPat[intP1+1]).getX();
        posY = circls.get(initialPat[intP1+1]).getY();
        fill(0);
        line(prevPosX, prevPosY, posX, posY);
      }
    if (currentMillis1 - startMillis2 >= period2){
      startMillis2 = currentMillis1;
      count_ += 1;
    }    
  }
  step = 20;

}

void drawPattern(){
  if (pattern.size() >= 2 && pattern.size() < 7){
    for (int i = 1; i <= pattern.size()-1; i++){
       prevPosX = circls.get(pattern.get(i-1)).getX();
       prevPosY = circls.get(pattern.get(i-1)).getY();
       posX = circls.get(pattern.get(i)).getX();
       posY = circls.get(pattern.get(i)).getY();
       fill(0);
       line(prevPosX, prevPosY, posX, posY);            
    }
  } 
}

float distance(float x1, float y1, float x2, float y2){
  float distance = sqrt( (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1) );
  return distance;

 }
 
int eachpointDistance(){ 
 int i;
 
  int countFingers = 0;
  float handX = 0;
  float handY = 0;
  for (Hand hand : leap.getHands ()) {
    PVector handPosition       = hand.getPosition();
    handX = handPosition.x;
    handY = handPosition.y;
    hand.draw();
  }
  
  fill(153);
  circle(handX, handY, 5);

 
 for (i = 0; i<=5;i++){
   
   float x1= circls.get(initialPat[i]).getX();
   float y1= circls.get(initialPat[i]).getY();
   float x2= handX;
   float y2= handY;
   float d = distance(x1,y1,x2,y2);
  
   if(d<50) {
       return i;      
   }
  }
  // -1 means im not in any point
  return -1;
 }
 
