void buildLines(){
  while(rounds<15){
      rounds++;
      if(mousePressed)println(rounds);
      int min = 100000;
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
          int count = 0;
          boolean k = c.radiusN.size()==0;
        //while(c.tconnections.size()<rounds&&c.r1<300&&!c.noPaths){
        while(c.radiusN.size()<rounds&&c.r1<20){
        //if(c.radiusN.size()<rounds){
          if(c.radiusN.size()==0)c.r1++;
          c.getNeighbours2(c.r1);
          c.sortNearest(0);
          //c.sortconnections();
          //if(!c.noPaths)
          frameRate(1);
          c.getN();
          //c.trim();
          frameRate(60);
          //c.sortconnections();
          //c.close();
          if(c.radiusN.size()<rounds)println("cSize",c.connections.size(),rounds,c.r1,i);
          //if(c.radiusN.size()==0)c.r1 =0;;
        }
        
        if(c.pos()){
          //c.debugNeighbours(c.r1);
          //c.sortNearest(0);
          //c.sortconnections();
        }
        
      }
      
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
        //c.checkIsClosed();
        
      }
    }
};
