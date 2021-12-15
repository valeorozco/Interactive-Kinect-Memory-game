PImage img;
//img = loadImage("universe.jpg");
import g4p_controls.*;
import java.awt.Font;
GButton btn;
Foo clase;
String estado;

void setup() {
  size(400, 400);
  fill(255);
  textSize(60);
  // Create object to handle events from the button
  clase = new Foo();
  btn = new GButton(this, 150, 100, 100, 100);
  btn.setText("PLAY");
  btn.setFont(new Font("Arial", Font.BOLD, 30));
  btn.addEventHandler(clase, "buttonClick"); 
}
void draw(){
  
  background(32);
  if(estado== "play"){
    
  }
}

public static class Foo{
  
  public Foo() {
  }
  
  public void buttonClick(GButton button, GEvent event){
    estado = "play";
  }
  
}
 
