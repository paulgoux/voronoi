class cell{
  
  float x,y,r = 10,max = Max;
  int id,S1,range,gid,xpos, ypos,round,count,r1;
  color col =  color(random(255),random(255),random(255));
  ArrayList<cell> closestN = new ArrayList<cell>();
  ArrayList<cell> radiusN = new ArrayList<cell>();
  ArrayList<cell> radiusND = new ArrayList<cell>();
  ArrayList<cell> tradiusN = new ArrayList<cell>();
  ArrayList<cell>connections = new ArrayList<cell>();
  ArrayList<cell>sconnections = new ArrayList<cell>();
  ArrayList<cell>failed = new ArrayList<cell>();
  ArrayList<cell>tconnections = new ArrayList<cell>();
  ArrayList<Quad>neighbourGrid = new ArrayList<Quad>();
  ArrayList<cell>neighbours = new ArrayList<cell>();
  ArrayList<cell>neighbours2 = new ArrayList<cell>();
  ArrayList<cell>neighboursD = new ArrayList<cell>();
  ArrayList<cell>history = new ArrayList<cell>();
  ArrayList<cell>temp = new ArrayList<cell>();
  boolean step1,step2,noPaths;
  HashMap<cell,Boolean> countedBy = new HashMap<cell,Boolean>();
  
  cell(int id_,float x_,float y_){
    x = x_;
    y = y_;
    id = id_;
    getPos();
  };
  
  //void pop
  
  PVector getPos(){
    
    if(x>W)x = 1;
    if(x<0)x = W-1;
    if(y>H)y = 1;
    if(y<0)y = H-1;
    
    xpos = floor(x/gW);
    ypos = floor(y/gH);
    int pos = int(xpos + ypos * (gw));
    if(pos<qgrid.size()){
      gid = pos;
      if(!qgrid.get(pos).children.contains(this))qgrid.get(pos).children.add(this);
    }
    PVector a = new PVector(xpos,ypos);
    return a;
  };
  
  void sortNearestPoint(){
    //while(radiusN.size()<rounds){
      //println("r",radiusN.size(),rounds);
      for(int i=0;i<points.size();i++){
        cell c = points.get(i);
        if(c!=this){
          //float d = dist(c.x,c.y,x,y);
          if(!radiusN.contains(c)){
              radiusN.add(c);
              tradiusN.add(c);
              c.countedBy.put(this,true);
      }}}max += 50;
    //} 
  };
  
  void sortNearest(int k){
    boolean k1 = false;
    radiusN = new ArrayList<cell>();
    while(neighbours.size()>0&&radiusN.size()<rounds){
      
      
      cell c1 = neighbours.get(0);
      for(int i=1;i<neighbours.size();i++){
        cell c = neighbours.get(i);
        
        float d = dist(c.x,c.y,x,y);
        float d1 = dist(c1.x,c1.y,x,y);
        //float t = atan2(y-c.y,x-c.x);
        //float t1 = atan2(y-c1.y,x-c1.x);
          
        //if(t<t1)c1 = c;
        if(d<d1)c1 = c;
      }
        radiusN.add(neighbours.remove(neighbours.indexOf(c1)));
        
    }
    if(radiusN.size()>=rounds){
      if(neighbours.size()>0)radiusN.add(neighbours.remove(0));
    }else{
      radiusN = new ArrayList<cell>();
    }
    //println("rsize",radiusN.size());
  };
  
  void sortNearestTheta(int k){
    boolean k1 = false;
    radiusN = new ArrayList<cell>();
    while(neighbours.size()>0&&radiusN.size()<rounds){
      
      
      cell c1 = neighbours.get(0);
      for(int i=1;i<neighbours.size();i++){
        cell c = neighbours.get(i);
        float t = atan2(y-c.y,x-c.x);
        float t1 = atan2(y-c1.y,x-c1.x);
          
        if(t<t1)c1 = c;
      }
        radiusN.add(neighbours.remove(neighbours.indexOf(c1)));
        
    }
    if(radiusN.size()>=rounds){
      if(neighbours.size()>0)radiusN.add(neighbours.remove(0));
    }else{
      radiusN = new ArrayList<cell>();
    }
  };
  
  void sortconnections(){
    temp = new ArrayList<cell>();
    sconnections = new ArrayList<cell>();
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      temp.add(c);
    }
    //maxX = 0;
    while(temp.size()>1){
      cell c = temp.get(0);
      for(int i=1;i<temp.size();i++){
        cell c1 = temp.get(i);
        
        float d = dist(c.x,c.y,x,y);
        float d1 = dist(c1.x,c1.y,x,y);
        if(d1<d){
          c = c1;
        }
      }
    
      //if(temp.indexOf(c)>-1){
        //println(sconnections.contains(temp.get(temp.indexOf(c))));
      if(!sconnections.contains(temp.get(temp.indexOf(c))))sconnections.add(temp.remove(temp.indexOf(c)));
      else temp.remove(temp.indexOf(c));
      //}
    }
    if(sconnections.size()>0&&!sconnections.contains(temp.get(0)))sconnections.add(temp.remove(0));
    int counter = 0;
    boolean k;
    if(sconnections.size()>1){
      cell c = sconnections.get(0);
      cell c1 = sconnections.get(sconnections.size()-1);
      float t1 = atan2(y-c.y,x-c.x)+PI;
      float t2 = atan2(y-c1.y,x-c1.x)+PI;
      float d1 = abs(t1-t2);
      //if(sconnections.size()>1&&counter >= sconnections.size()&&d1>PI/4)noPaths=true;;
    }
  };
  
  void sortconnectionsTheta(){
    temp = new ArrayList<cell>();
    sconnections = new ArrayList<cell>();
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      temp.add(c);
    }
    //maxX = 0;
    while(temp.size()>1){
      cell c = temp.get(0);
      for(int i=1;i<temp.size();i++){
        cell c1 = temp.get(i);
        
        float d = atan2(y-c.y,x-c.x)+PI;
        float d1 = atan2(y-c1.y,x-c1.x)+PI;
        if(d1<d){
          c = c1;
        }
      }
    
      if(!sconnections.contains(temp.get(temp.indexOf(c))))sconnections.add(temp.remove(temp.indexOf(c)));
      else temp.remove(temp.indexOf(c));
      //}
    }
    if(sconnections.size()>0&&!sconnections.contains(temp.get(0)))sconnections.add(temp.remove(0));
    int counter = 0;
    boolean k;
    if(sconnections.size()>1){
      cell c = sconnections.get(0);
      cell c1 = sconnections.get(sconnections.size()-1);
      float t1 = atan2(y-c.y,x-c.x)+PI;
      float t2 = atan2(y-c1.y,x-c1.x)+PI;
      float d1 = abs(t1-t2);
      //if(sconnections.size()>1&&counter >= sconnections.size()&&d1>PI/4)noPaths=true;;
    }
  };
  
  void getN(){
    
    int count = 0;
    //println("count1",radiusN.size());
    for(int j=0;j<radiusN.size();j++){
      boolean k1 = false,k2 = false,k3 = false;
          cell c = radiusN.get(j);
        //for(int j=0;j<c.neighboursD.size();j++){
        //  cell c1 = c.neighboursD.get(j);
          Line a = new Line(c,this);
          for(int k=0;k<c.sconnections.size();k++){
            cell c1 = c.sconnections.get(k);
            
            for(int l=0;l<c1.tconnections.size();l++){
              cell c2 = c1.tconnections.get(l);
              Line b = new Line(c1,c2);
              
              if(c2!=this){
                PVector p = checkIntersect(a,b);
                if(p!=null){
                  
                  k1 = true;
                  break;
                }
              }
            }
            if(k1)break;
            //save("pic.tif");
          }
          
          //for(int k=0;k<sconnections.size();k++){
          //  cell c1 = sconnections.get(k);
          //  Line b = new Line(c1,c);
          //  if(c1!=this){
          //      PVector p = checkIntersect(a,b);
          //      if(p!=null){
          //        k1 = true;
          //        break;
          //      }
          //    }
          //}
          for(int i= 0;i<tconnections.size();i++){
            cell c1 = tconnections.get(i);
            for(int k=0;k<c1.tconnections.size();k++){
              cell c2 = c1.tconnections.get(k);
              Line b = new Line(c2,c1);
              PVector p = checkIntersect(a,b);
              if(p!=null){
                //if(!failed.contains(d))failed.add(d);
                  k2 = true;
                  
                  
                  break;
              //}
            }}
            if(k2){
              count ++;
              break;
            }
          }
      
            //println("tsize",tconnections.size(),rounds,k1,k2);
            if(!k2&&!k1){
              count++;
              //println("cp",connections.size(),rounds,connections.size()<rounds,id);
              //closestN.add(d);
              //if(!linePair[d.id].contains(this))linePair[d.id].add(this);
              //if(!linePair[id].contains(d))linePair[id].add(d);
              if(!tconnections.contains(c)){
                connections.add(c);
                tconnections.add(c);
                
              }
              if(!c.tconnections.contains(this)){
                c.tconnections.add(this);
                //c.sortconnections();
                if(c.tconnections.size()>rounds){
                  //rounds++;
                  //c.r1++;
                  
                }
                //c.connections.add(this);
              }
              if(!lines.get(c).contains(this)&&!lines.get(this).contains(c))lines.get(this).add(c);
            }
            
        }
    if(count==radiusN.size()&&r1>5)noPaths = true;
    //println("count",count,radiusN.size());
  };
  
  void trim(){
    frameRate(1);
    for(int j=tconnections.size()-1;j>-1;j--){
          cell c = tconnections.get(j);
          boolean k1 = false;
        //for(int j=0;j<c.neighboursD.size();j++){
        //  cell c1 = c.neighboursD.get(j);
          Line a = new Line(c,this);
          for(int k=0;k<tconnections.size();k++){
            cell c1 = tconnections.get(k);
            
            for(int l=0;l<c1.tconnections.size();l++){
              cell c2 = c1.tconnections.get(l);
              Line b = new Line(c1,c2);
              
              if(c2!=this){
                PVector p = checkIntersect(a,b);
                if(p!=null){
                  
                  k1 = true;
                  break;
                }
              }
            }
            if(k1)break;
            //save("pic.tif");
          }
          if(k1){
            tconnections.remove(c);
            int pos = c.tconnections.indexOf(this);
            c.tconnections.remove(pos);
          }
          
        }
        frameRate(60);
  };
  
  
  ArrayList<cell> getNeighbours2(int k){
    if(radiusN.size()<rounds){
      //r1 +=1;
      max = r1*Max;
      //println("getN");
      range = r1;
      int r1 = range - (range - 4);
      int pos = gid;
      int k1 = 5;
      ArrayList<Quad> n = new ArrayList<Quad>();
      Quad myTile = qgrid.get(pos);
      
        for(int i=floor(xpos-range);i<=xpos+ range;i++){
          int t = floor(360/(range*range+1));
          for(int j=floor(ypos-range);j<=ypos+ range;j++){
            
            if(int(i+j*gw)<qgrid.size()&&int(i+j*gw)>0){
              
              Quad q = qgrid.get(int(i+j*gw));
              float d = dist(xpos,ypos,q.xpos,q.ypos);
              //float d2 = dist(xpos,ypos,q.xpos,q.ypos);
                //if((d<k&&((i<xpos-r1*sin(range-r1)||i>xpos+r1*sin(range+r1)||(j<ypos-r1*sin(range-r1)||j>ypos+r1*sin(range+r1)))))){
                  //if((d<k&&((j<xpos-(r1-i*sin(range-i))||i>xpos+(r1+i*sin(range+i))&&(j<ypos-(r1-j*cos(range-j))||j>ypos+(r1+j*cos(range+j))))))){
                  //if(d<k&&floor(i*1/cos((k+t*j)))%k1!=0&&floor(j*1/sin((k+t*i)))%k1!=0){
                  //if(d<k&&(i<xpos-r1||i>xpos+r1)||(j<ypos-r1||j>ypos+r1)){
                    //if(d<k&&d>(r1)){
                      if(d<=k){
                if(!neighbourGrid.contains(q))neighbourGrid.add(q);
              }
            }
      }}
      
      neighbours = new ArrayList<cell>();
      //println("n",neighbours.size(),rounds);
      //if(neighbours.size()<rounds)
      for(int i=0;i<neighbourGrid.size();i++){
        Quad a = neighbourGrid.get(i);
        for(int j=0;j<a.children.size();j++){
          cell c = a.children.get(j);
          
          if(c!=null&&c!=this){
            //float d = dist(x,y,c.x,c.y); 
            if(!tconnections.contains(c)){
              //tradiusN.add(c);
              neighbours.add(c);
              
            }
          }
          //if(c!=null&&c!=this&&!n1.contains(c))n1.add(c);
          
      }}
      //neighbours = n1;
    //}
    }
      
      //println("count0",neighbours.size());
      if(neighbours.size()>0)neighbours2 = neighbours;
      return neighbours;
   
  };
  
  ArrayList<cell> debugNeighbours(int k){
    if(true){
      //r1 +=1;
      max = r1*Max;
      //println("getN");
      range = r1;
      int r1 = range - (range - 4);
      int pos = gid;
      int k1 = 5;
      ArrayList<Quad> n = new ArrayList<Quad>();
      Quad myTile = qgrid.get(pos);
      
        for(int i=floor(xpos-range);i<=xpos+ range;i++){
          int t = floor(360/(range*range+1));
          for(int j=floor(ypos-range);j<=ypos+ range;j++){
            
            if(int(i+j*gw)<qgrid.size()&&int(i+j*gw)>0){
              
              Quad q = qgrid.get(int(i+j*gw));
              float d = dist(xpos,ypos,q.xpos,q.ypos);
              //float d2 = dist(xpos,ypos,q.xpos,q.ypos);
                //if((d<k&&((i<xpos-r1*sin(range-r1)||i>xpos+r1*sin(range+r1)||(j<ypos-r1*sin(range-r1)||j>ypos+r1*sin(range+r1)))))){
                  //if((d<k&&((j<xpos-(r1-i*sin(range-i))||i>xpos+(r1+i*sin(range+i))&&(j<ypos-(r1-j*cos(range-j))||j>ypos+(r1+j*cos(range+j))))))){
                  //if(d<k&&floor(i*1/cos((k+t*j)))%k1!=0&&floor(j*1/sin((k+t*i)))%k1!=0){
                  //if(d<k&&(i<xpos-r1||i>xpos+r1)||(j<ypos-r1||j>ypos+r1)){
                    //if(d<k&&d>(r1)){
                      if(d<=k){
                if(!neighbourGrid.contains(q))neighbourGrid.add(q);
              }
            }
      }}
      
      neighboursD = new ArrayList<cell>();
      //println("n",neighbours.size(),rounds);
      //if(neighbours.size()<rounds)
      for(int i=0;i<neighbourGrid.size();i++){
        Quad a = neighbourGrid.get(i);
        for(int j=0;j<a.children.size();j++){
          cell c = a.children.get(j);
          
          if(c!=null&&c!=this){
            //float d = dist(x,y,c.x,c.y); 
            if(!neighboursD.contains(c)&&!tconnections.contains(c)){
              //tradiusN.add(c);
              neighboursD.add(c);
              
            }
          }
          //if(c!=null&&c!=this&&!n1.contains(c))n1.add(c);
          
      }}
      //neighbours = n1;
    //}
    }
      
      //println("count0",neighboursD.size());
      return neighboursD;
   
  };
  
  void debugN(){
    //for(int i=0;i<neighbours2.size();i++){
    //  cell c = a.children.get(j);
    //}
  };
  
  void checkIsClosed(){
    int tcount = 0;
    for (int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      int counter = 0;
      for(int j=0;j<c.tconnections.size();j++){
        cell c1 = c.tconnections.get(j);
        if(c1!=this&&c1.tconnections.contains(this)){
         counter ++; 
        }
        
        if(counter>=3){
          tcount++;
          break;
          
        }
      }
      text(tcount,x+20,y+10*i);
    }
    
    if(tcount==tconnections.size()-1&&tconnections.size()-1>0){
     noPaths = true; 
    }
  };
  
  void checkI(){
    
  };
  
  void close(){
    //for(int i=0;i<sconnections.size();i++){
    //  cell c = sconnections.get(i);
    //}
    if(sconnections.size()>=2){
      cell c1 = sconnections.get(0);
      cell c2 = sconnections.get(sconnections.size()-1);
      
      c1.tconnections.add(c2);
      c1.tconnections.add(c1);
    }
  };
  
  void test(){
    for(int i=0;i<closestN.size();i++){
      cell c = closestN.get(i);
      Line a = new Line (this,c);
      stroke(0);
      strokeWeight(4);
      line(x,y,c.x,c.y);
      fill(c.col);
      ellipse(c.x,c.y,10,10);
      for(int j=0;j<c.tradiusN.size();j++){
        cell c1 = c.tradiusN.get(j);
        if(c1!=this){
        stroke(255);
        strokeWeight(4);
        line(c1.x,c1.y,c.x,c.y);
        Line b = new Line (c,c);
        checkIntersect(a,b);
      }}
    };
  };
  
  //cell getNearest(ArrayList<cell>()){
  //  cell k = 
  //};
  
  void draw(){
    
    fill(col);
    //ellipse(x,y,r,r);
    stroke(col);
    strokeWeight(r/2);
    point(x,y);
    strokeWeight(1);
  };
  
  void drawClosest(){
    
    //text(radiusN.size(),x+20,y);
    //text(", "+tradiusN.size(),x+30,y);
    text(closestN.size(),x+20,y+10);
    
    for(int i=0;i<closestN.size();i++){
      cell c = closestN.get(i); 
      stroke(col);
      if(pos())
      stroke(0);
      strokeWeight(2);
      line(x,y,c.x,c.y);
    }
    
    for(int i=0;i<tradiusN.size();i++){
      cell c = tradiusN.get(i); 
      
      if(pos())
      stroke(col);
      strokeWeight(2);
      line(x,y,c.x,c.y);
    }
    
    //for(int i=0;i<connections.size();i++){
    //  cell c = connections.get(i); 
    //  stroke(0);
    //  strokeWeight(1);
    //  line(x,y,c.x,c.y);
    //}
  };
  
  boolean pos(){
    return dist(mouseX,mouseY,x,y)<=r;
  };
  
  void verify(){
    for(int k=0;k<neighbours.size();k++){
      cell c1 = neighbours.get(k);
      
      if(!tconnections.contains(c1)){
        boolean k1 = false;
        Line A = new Line(this,c1);
        for(int i= 0;i<tconnections.size();i++){
        cell c2 = tconnections.get(i);
          for(int j=0;j<c2.tconnections.size();j++){
            cell c3 = c2.tconnections.get(j);
            Line B = new Line(c1,c3);
            PVector a = checkIntersect(A,B);
            if(a!=null){
              //float d1 = dist(a.x,a.y,d.x,d.y);
              //float d2 = dist(a.x,a.y,x,y);
              //if(!failed.contains(d))failed.add(d);
              //if(d1>200&&d2>200){
                k1 = true;
                count ++;
                
                //break;
            //}
          }}
        }
        if(!k1){
          
          closestN.add(c1);
          if(!linePair[c1.id].contains(this))linePair[c1.id].add(this);
          if(!linePair[id].contains(c1))linePair[id].add(c1);
          if(!connections.contains(c1)){
            connections.add(c1);
            tconnections.add(c1);
            
          }
          if(!c1.tconnections.contains(this)){
            c1.tconnections.add(this);
            //d.connections.add(this);
          }
          if(!lines.get(c1).contains(this)&&!lines.get(this).contains(c1))lines.get(this).add(c1);
        }
      }
      
    }
  };
  
  
  void verify2(){
    
    for(int k=0;k<neighbours.size();k++){
      cell d = neighbours.get(k);
      if(!tconnections.contains(d)){
      boolean k1 = false;
      Line A = new Line(this,d);
       count = 0;
      for(int i= 0;i<tconnections.size();i++){
        cell c = tconnections.get(i);
        for(int j=0;j<c.tconnections.size();j++){
          cell c1 = c.tconnections.get(j);
          Line B = new Line(c,c1);
          PVector a = checkIntersect(A,B);
          if(a!=null){
            float d1 = dist(a.x,a.y,d.x,d.y);
            float d2 = dist(a.x,a.y,x,y);
            if(!failed.contains(d))failed.add(d);
            //if(d1>200&&d2>200){
              k1 = true;
              count ++;
              
              //break;
          //}
        }}
      }
        if(!k1){
          
          closestN.add(d);
          if(!linePair[d.id].contains(this))linePair[d.id].add(this);
          if(!linePair[id].contains(d))linePair[id].add(d);
          if(!connections.contains(d)){
            connections.add(d);
            tconnections.add(d);
            
          }
          if(!d.tconnections.contains(this)){
            d.tconnections.add(this);
            //d.connections.add(this);
          }
          if(!lines.get(d).contains(this)&&!lines.get(this).contains(d))lines.get(this).add(d);
        }else d = null;
        //println(count,radiusN.size());
      if (count >= radiusN.size()-1){
        noPaths = true;
      }
      }
    }
    //if(closestN.size()<2
    //while(radiusN.size()==0&&neighbours.size()>0&&radiusN.contains(){
    //  for(int i=0;i<neighbours.size();i++){
        
    //    if(tradiusN.contains(neighbours.get(i))){
    //       tradiusN.contains(neighbours.get(i));
    //    }
    //}}
  };
  
  
  
};
