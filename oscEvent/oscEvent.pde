void oscEvent(OscMessage theOscMessage) {
  currentMillis = millis();  
  if (currentMillis - startMillis >= period)  
  { 
    if (pattern.size() >= 6){
      correctPat = true;
      for(int mat = 0; mat <6; mat++){
        if (pattern.get(mat) != initialPat[mat]){
          correctPat = false;

        }
      }      
      pattern = new ArrayList<Integer>();
      
      if (correctPat){ 
        printArray(initialPat);
        circls.set(0, new drawCirc(1, 20, 20));
        circls.set(1, new drawCirc(2, 20, 20));
        circls.set(2, new drawCirc(3, 20, 20));
        circls.set(3, new drawCirc(4, 20, 20));
        circls.set(4, new drawCirc(5, 20, 20));
        circls.set(5, new drawCirc(6, 20, 20));
        
        int cc = 0;
        for (int ini = 0; ini < 6; ini++){
          initialPat[ini] = 0;
        }
        printArray(initialPat);
        while (cc < 6){        
          posi = int(random(1,7));
          notContains = true;
          for (int com = 0; com < 6; com++){
            if (initialPat[com] == posi){
              notContains = false;
            }
          }
          println("TTTT");
          if (notContains){
            initialPat[cc] = posi;
            cc += 1;
          }
        }
        printArray(initialPat);
        startMillis1 = currentMillis1;  
        startMillis2 = currentMillis1;
        count_ = 0;
      }
    }

    class_ = theOscMessage.get(0).floatValue();
    boolean contains = false;
  
    for (int a = 0; a < pattern.size(); ++a)
    {
       if (pattern.get(a) == int(class_)) {
         contains = true;
         break;
       }
    }
    
    if (!contains) {
        pattern.add(int(class_));
        //printArray(pattern);
    }
    startMillis = currentMillis;
  }
}
