void buildLines(){
  int max = 20;
  while(rounds<max){
      rounds++;
      if(mousePressed)println(rounds);
      int min = 100000;
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
          int count = 0;
          boolean k = c.radiusN.size()==0;
        //while(c.tconnections.size()<rounds&&c.r1<300&&!c.noPaths){
        while(!c.noPaths&&c.r1<500&&c.radiusN.size()<rounds){
        //if(c.radiusN.size()<rounds){
          if(c.radiusN.size()==0)c.r1++;
          c.getNeighbours(c.r1);
          //if(c.tconnections.size()>3)
          c.sortNearest(0);
          //c.sortconnections();
          //if(!c.noPaths)
          c.getN();
          //c.sortConnectionsTheta();
          c.findMidPoint();
          c.sortConnectionsTheta();
        }
        
        if(c.pos()){
          //c.debugNeighbours(c.r1);
          //c.sortNearest(0);
          //c.sortconnections();
        }
        
      }
    }
    
    if(rounds==max){
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
        c.connectStragglers();
        if(c.straggler)c.sortConnectionsTheta();
      }
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
        if(c.straggler){
          c.connectStragglers();
        }
        if(c.stragglerC||c.straggler)c.sortConnectionsTheta();
      }
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
        if(c.straggler||c.stragglerC){
          c.connectStragglers();
          
        }
        if(c.stragglerC||c.straggler)c.sortConnectionsTheta();
        c.convertToTriangle();
      }
      for(int i=0;i<total;i++){
        
        cell c = points.get(i);
        c.convertToTriangle();
      }
      rounds ++;
      println(max,rounds);
    }
};
