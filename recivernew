import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress dest;

float class_ = 0, prevClas = 0, posX, posY, prevPosX, prevPosY;
float startMillis, startMillis1, startMillis2;
float currentMillis, currentMillis1;
color a = color(255, 204, 0);  
color b = color(127,200,0);
color c = color(220,250,0);


int period = 1200, pat = 1, period1 = 8000, step = 20;
int period2 = 1500, count_ = 0;
int posi;
boolean correctPat = true, notContains = true;

int[] initialPat = {1, 3, 4, 2, 5, 6};
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
  
  oscP5 = new OscP5(this,12000); //listen for OSC messages on port 12000 (Wekinator default)
  dest = new NetAddress("127.0.0.1",6448); //send messages back to Wekinator on port 6448, localhost (this machine) (default)
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
}

void patternToDo(){
  currentMillis1 = millis();  
  if (currentMillis1 - startMillis1 < period1) {
    for (int inP = 0; inP < 6; inP++){
      step += 20;
      text(String.valueOf(initialPat[inP]), step, 50);     
    }
    for (int intP1 = 0; intP1 < count_; intP1++){
        prevPosX = circls.get(initialPat[intP1]-1).getX();
        prevPosY = circls.get(initialPat[intP1]-1).getY();
        posX = circls.get(initialPat[intP1+1]-1).getX();
        posY = circls.get(initialPat[intP1+1]-1).getY();
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
       prevPosX = circls.get(pattern.get(i-1)-1).getX();
       prevPosY = circls.get(pattern.get(i-1)-1).getY();
       posX = circls.get(pattern.get(i)-1).getX();
       posY = circls.get(pattern.get(i)-1).getY();
       fill(0);
       line(prevPosX, prevPosY, posX, posY);      
    }
  }
}
