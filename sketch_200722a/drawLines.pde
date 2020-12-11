void drawLines(){
  int kn = -1;
  for(int i=0;i<total;i++){
    cell c = points.get(i);
    stroke(255);
    if(c.noPaths)stroke(0);
    //strokeWeight(10);
    //point(c.x,c.y);
    for(int j=0;j<lines.get(c).size();j++){
      cell c1 = lines.get(c).get(j);
      
      stroke(c.col);
      stroke(255);
      strokeWeight(1);
      line(c.x,c.y,c1.x,c1.y);
      
      //if(check_lineP(c,c1,mouse)){
      //  fill(255);
      //  text(dist(c.x,c.y,c1.x,c1.y),mouse.x,mouse.y);
      //}
    }
  //c.draw();
  if(c.pos()){
    
    if(mousePressed){
      if(mouseButton == RIGHT){
        textSize(50);
        fill(255);
        text(i,c.x,c.y);
        for(int j=0;j<c.neighbours.size();j++){
          cell c1 = c.neighbours.get(j);
        //for(int j=0;j<c.failed.size();j++){
        //  cell c1 = c.failed.get(j);
          stroke(0);
          strokeWeight(5);
          line(c.x,c.y,c1.x,c1.y);
          strokeWeight(1);
          fill(0);
          text(j,c1.x+10,c1.y);
        }
        
        //for(int j=0;j<c.tconnections.size();j++){
        //  cell c1 = c.tconnections.get(j);
        ////for(int j=0;j<c.failed.size();j++){
        ////  cell c1 = c.failed.get(j);
        //  stroke(0,255,0);
        //  strokeWeight(5);
        //  line(c.x,c.y,c1.x,c1.y);
        //  strokeWeight(1);
        //  fill(0);
        //  text(j,c1.x+10,c1.y);
        //}
        
        //for(int j=0;j<c.sconnections.size();j++){
        //  cell c1 = c.sconnections.get(j);
        //  cell c2 = null;
        //  if(j<c.sconnections.size()-1)c2 = c.sconnections.get(j+1);
        //  else c2 = c.sconnections.get(0);
        ////for(int j=0;j<c.failed.size();j++){
        ////  cell c1 = c.failed.get(j);
        //  stroke(0);
        //  strokeWeight(5);
        //  line(c2.x,c2.y,c1.x,c1.y);
        //  strokeWeight(1);
          
        //  //text(j,c1.x+10,c1.y);
        //}
        for(int j=0;j<c.neighbourGrid.size();j++){
          Quad q = c.neighbourGrid.get(j);
          q.fillc();
        } 
        textSize(12);
        }
      else if(mouseButton == LEFT){
        kn = i;
        
        //for(int k=0;k<c.tconnections.size();k++){
        //  cell c1 = c.tconnections.get(k);
        //  for(int j=0;j<c1.sconnections.size();j++){
        //    cell c2 = c1.sconnections.get(j);
        //    if(c2!=c){
        //      stroke(255,0,0);
        //      strokeWeight(2);
        //      line(c2.x,c2.y,c1.x,c1.y);
        //    }
        //    //q.fillC();
        //  }
        //}
        for(int j=0;j<c.radiusN.size();j++){
          cell c1 = c.radiusN.get(j);
        //for(int j=0;j<c.neighboursD.size();j++){
        //  cell c1 = c.neighboursD.get(j);
          stroke(255,0,0);
          strokeWeight(5);
          line(c.x,c.y,c1.x,c1.y);
          Line a = new Line(c,c1);
          for(int k=0;k<c.tconnections.size();k++){
            cell c2 = c.tconnections.get(k);
            
            for(int l=0;l<c2.tconnections.size();l++){
              cell c3 = c2.tconnections.get(l);
              Line b = new Line(c3,c2);
              
              if(c3!=c){
                fill(0);
                noStroke();
                ellipse(c3.x,c3.y,20,20);
                checkIntersect(a,b);
                //stroke(255,0,255);
                //strokeWeight(2);
                //line(c2.x,c2.y,c3.x,c3.y);
              }
            }
          }
          
          //for(int j=0;j<c1.sconnections.size();j++){
          //  cell c2 = c1.sconnections.get(j);
          //  if(c2!=c){
          //    stroke(255,0,0);
          //    strokeWeight(2);
          //    line(c2.x,c2.y,c1.x,c1.y);
          //  }
          //  //q.fillC();
          //}
        }
      //for(int j=0;j<c.tradiusN.size();j++){
      //    cell c1 = c.tradiusN.get(j);
      //    stroke(0);
      //    strokeWeight(5);
      //    line(c.x,c.y,c1.x,c1.y);
      //    strokeWeight(1);
      //    text(j,c1.x+10,c1.y);
      //  }
    }}else{
        //c.test();
        //for(int j=0;j<c.connections.size();j++){
        //  cell c1 = c.connections.get(j);
        for(int j=0;j<c.tconnections.size();j++){
          cell c1 = c.tconnections.get(j);
          cell c2 = null;
          if(i<c.tconnections.size()-1)c2 = c.tconnections.get(i+1);
          else c2 = c.tconnections.get(0);
          
          stroke(0);
          strokeWeight(5);
          line(c.x,c.y,c1.x,c1.y);
          strokeWeight(1);
          fill(255,0,0);
          if(c.tconnections.contains(c1)){
            fill(255,0,255);
          }
          
          text(j,c1.x,c1.y+10);
        }
  }}
  //text(c.neighbours.size(),c.x,c.y+10);
  //c.drawClosest();
  fill(0);
  
  
  //text(c.radiusN.size(),c.x+20,c.y);
}
  
  
  if(kn>-1){
    
    cell c = points.get(kn);
    fill(255,0,0);
    //text(c.tconnections.size(),c.x+10,c.y);
    textSize(50);
    text(c.radiusN.size()+" "+c.r1+" " + c.neighboursD.size(),c.x+10,c.y);
    textSize(12);
    //for(int j=0;j<c.neighbourGrid.size();j++){
    //  Quad q = c.neighbourGrid.get(j);
    //  //q.fillC();
    //} 
    
  }
};
