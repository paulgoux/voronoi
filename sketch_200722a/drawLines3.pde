void drawLines3(){
  int k = -1;
  for(int i=0;i<total;i++){
    cell c = points.get(i);
    stroke(255);
    if(c.noPaths)stroke(0);
    //strokeWeight(10);
    //point(c.x,c.y);
    if(c.pos())k = i;
    //for(int j=0;j<lines.get(c).size();j++){
    //  cell c1 = lines.get(c).get(j);
      
    //  stroke(c.col);
    //  stroke(255);
    //  strokeWeight(0.5);
    //  line(c.x,c.y,c1.x,c1.y);
      
    //  //if(check_lineP(c,c1,mouse)){
    //  //  fill(255);
    //  //  text(dist(c.x,c.y,c1.x,c1.y),mouse.x,mouse.y);
    //  //}
    //}
  }
  if(k>-1){
    cell c = points.get(k);
    c.drawContour();
    //c.debugMidPoint();
  }
  
  //for(int j=0;j<stragglers.size();j++){
  //  Line b = stragglers.get(j);
  //  b.draw();
  //}
  for(int j=0;j<delaunySites.size();j++){
    cell c = delaunySites.get(j);
    c.drawVerticesD();
  }
};
