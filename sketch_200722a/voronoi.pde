void voronoi(){
  for(int i=0;i<total;i++){
    cell c = points.get(i);
    stroke(c.col);
    strokeWeight(5);
    point(c.x,c.y);
    if(c.sconnections.size()>0){
    cell c0 = c.sconnections.get(0);
    cell cn = c.sconnections.get(c.sconnections.size()-1);
    float t1 = atan2(c0.y-cn.y,c0.x-cn.x);
    //if(t1<PI/8)
    //for(int j=0;j<c.sconnections.size();j++){
          
    //      cell c1 = c.sconnections.get(j);;
          
    //      cell c2 = null;
    //      //if(c.pos()){
    //      if(true){
          
    //      if(j<c.sconnections.size()-1)c2 = c.sconnections.get(j+1);
    //      else c2 = c.sconnections.get(0);
    //      stroke(c.col);
    //      strokeWeight(1);
    //      if(c.pos())strokeWeight(10);
    //      line((c1.x+c.x)/2,(c1.y+c.y)/2,(c2.x+c.x)/2,(c2.y+c.y)/2);
    //      strokeWeight(1);
    //    }}
        
    //else {
      for(int j=0;j<c.sconnections.size();j++){
          
          cell c1 = c.sconnections.get(j);;
          
          cell c2 = null;
          //if(c.pos()){
          if(true){
          
          if(j<c.sconnections.size()-1)c2 = c.sconnections.get(j+1);
          else c2 = c.sconnections.get(0);
          stroke(c.col);
          strokeWeight(1);
          if(c.pos())strokeWeight(10);
          line((c1.x+c.x)/2,(c1.y+c.y)/2,(c2.x+c.x)/2,(c2.y+c.y)/2);
          strokeWeight(1);
        }}
    }
        
    //}
  }
  
};
