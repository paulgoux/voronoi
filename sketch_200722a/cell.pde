class cell{
  
  float x,y,r = 10,max = Max,minx = 1000000,miny = 1000000,maxx,maxy;
  int id,S1,range,gid,xpos, ypos,round,count,r1;
  color col =  color(random(255),random(255),random(255));
  ArrayList<cell> vertices = new ArrayList<cell>();
  ArrayList<Line> edges = new ArrayList<Line>();
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
  ArrayList<cell>countedBy = new ArrayList<cell>();
  boolean step1,step2,noPaths,topLeft,top,topRight,right,btmRight,btm,btmLeft,left,center,straggler,stragglerC;
  //HashMap<cell,Boolean> countedBy = new HashMap<cell,Boolean>();
  
  PVector midPoint,p1,p2,p3;
  
  cell(int id_,float x_,float y_){
    x = x_;
    y = y_;
    id = id_;
    getPos();
  };
  
  cell(int id_,PVector p){
    x = p.x;
    y = p.y;
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
              //c.countedBy.put(this,true);
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
  
  void findMidPoint(){
    
    midPoint = new PVector(0,0);
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      midPoint.add(new PVector(c.x,c.y));
      if(c.x<minx)minx=c.x;
      if(c.y<miny)miny=c.y;
      if(c.x>maxx)maxx=c.x;
      if(c.y>maxy)maxy=c.y;
    }
    
    midPoint.div(tconnections.size());
    
    if(x>minx&&x<maxx&&y>miny&&y<maxy)center = true;
    if(x<minx&&y<miny)topLeft = true;
    if(x>minx&&x<maxx&&y<miny)top = true;
    if(x>maxx&&y<miny)topRight = true;
    if(x>maxx&&y>miny&&y<maxy)right = true;
    if(x>maxx&&y<maxy)btmRight = true;
    if(x>minx&&x<maxx&&y>maxy)btm = true;
    if(x<minx&&y>maxy)btmLeft = true;
    if(x<minx&&y>miny&&y<maxy)left = true;
    
    if(center)
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      midPoint.add(new PVector(c.x,c.y));
      if(c.x<minx)minx=c.x;
      if(c.y<miny)miny=c.y;
      if(c.x>maxx)maxx=c.x;
      if(c.y>maxy)maxy=c.y;
      Line a = new Line(this,c);
      boolean k = false;
      //if(c
      for(int j=0;j<sconnections.size();j++){
        cell c1 = sconnections.get(j);
        cell c2 = null;
        
        if(j<sconnections.size()-1)c2 = sconnections.get(j+1);
        else c2 = sconnections.get(0);
        Line b = new Line(c1,c2);
        PVector p = checkIntersect(a,b);
        if(p!=null){
          center = false;
          k = true;
          break;
        }
      }
      if(k)break;
    }
  };
  
  void debugMidPoint(){
    
    midPoint = new PVector(0,0);
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      midPoint.add(new PVector(c.x,c.y));
      if(c.x<minx)minx=c.x;
      if(c.y<miny)miny=c.y;
      if(c.x>maxx)maxx=c.x;
      if(c.y>maxy)maxy=c.y;
    }
    
    midPoint.div(tconnections.size());
    
    if(x>minx&&x<maxx&&y>miny&&y<maxy)center = true;
    if(x<minx&&y<miny)topLeft = true;
    if(x>minx&&x<maxx&&y<miny)top = true;
    if(x>maxx&&y<miny)topRight = true;
    if(x>maxx&&y>miny&&y<maxy)right = true;
    if(x>maxx&&y<maxy)btmRight = true;
    if(x>minx&&x<maxx&&y>maxy)btm = true;
    if(x<minx&&y>maxy)btmLeft = true;
    if(x<minx&&y>miny&&y<maxy)left = true;
    
    //if(center)
    for(int i=0;i<sconnections.size();i++){
      cell c = sconnections.get(i);
      midPoint.add(new PVector(c.x,c.y));
      if(c.x<minx)minx=c.x;
      if(c.y<miny)miny=c.y;
      if(c.x>maxx)maxx=c.x;
      if(c.y>maxy)maxy=c.y;
      Line a = new Line(this,c);
      boolean k = false;
      //if(c
      for(int j=0;j<sconnections.size();j++){
        cell c1 = sconnections.get(j);
        cell c2 = null;
        
        if(j<sconnections.size()-1)c2 = sconnections.get(j+1);
        else c2 = sconnections.get(0);
        Line b = new Line(c1,c2);
        PVector p = checkIntersect2(a,b);
        if(p!=null){
          center = false;
          k = true;
          //break;
        }
      }
      //if(k)break;
    }
  };
  
  void sortConnections(){
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
  
  void sortConnectionsTheta(){
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

          
          for(int i= 0;i<tconnections.size();i++){
            cell c1 = tconnections.get(i);
            for(int k=0;k<c1.tconnections.size();k++){
              cell c2 = c1.tconnections.get(k);
              Line b = new Line(c2,c1);
              PVector p = checkIntersect(a,b);
              if(p!=null){
                  k2 = true;
                  break;
            }}
            if(k2){
              //count ++;
              
              break;
            }
          }
      
            //println("tsize",tconnections.size(),rounds,k1,k2);
            if(!k2&&!k1){
              count++;
              if(!tconnections.contains(c)){
                connections.add(c);
                tconnections.add(c);
                
              }
              if(!c.tconnections.contains(this)){
                c.tconnections.add(this);
              }
              if(!linePair[c.id].contains(this))linePair[c.id].add(this);
              if(!linePair[id].contains(c))linePair[id].add(c);
              if(!lines.get(c).contains(this)&&!lines.get(this).contains(c))lines.get(this).add(c);
            }else{
              if(!failed.contains(c))failed.add(c);
            }
            
        }
    if(count==0&&radiusN.size()>0)noPaths = true;
    //println("count",count,radiusN.size());
  };
  
  void connectStragglers(){
    for(int i=0;i<sconnections.size();i++){
      cell c = sconnections.get(i);
      cell c1 = null;
      if(i<sconnections.size()-1)c1 = sconnections.get(i+1);
      else c1 = sconnections.get(0);
      
      boolean k1 = false;
      Line a = new Line(c,c1);
      println("straglers",stragglers.size());
      if(!lines.get(c).contains(c1)&&!lines.get(c1).contains(c)){
        for(int j= 0;j<c.tconnections.size();j++){
            cell c2 = c.tconnections.get(j);
            for(int k=0;k<c2.tconnections.size();k++){
              cell c3 = c2.tconnections.get(k);
              Line b = new Line(c2,c3);
              PVector p = checkIntersect(a,b);
              if(p!=null){
                  k1 = true;
                  break;
            }}
            if(k1){
              break;
            }
          }
          if(!k1)
          for(int j= 0;j<c1.tconnections.size();j++){
            cell c2 = c1.tconnections.get(j);
            for(int k=0;k<c2.tconnections.size();k++){
              cell c3 = c2.tconnections.get(k);
              Line b = new Line(c2,c3);
              PVector p = checkIntersect(a,b);
              if(p!=null){
                  k1 = true;
                  break;
            }}
            if(k1){
              break;
            }
          }
          if(!k1)
        for(int j=0;j<stragglers.size();j++){
          Line b = stragglers.get(j);
          PVector p = checkIntersect(a,b);
          if(p!=null){
            k1 = true;
            break;
          }
          
        }
        if(!k1){
          if(!linePair[c.id].contains(c1))linePair[c.id].add(c1);
          if(!linePair[c1.id].contains(c))linePair[c1.id].add(c);
          
          if(!c.tconnections.contains(c1))c.tconnections.add(c1);
          if(!c1.tconnections.add(c))c1.tconnections.add(c);
          lines.get(c1).add(c);
          stragglers.add(a);
          straggler = true;
          c.stragglerC = true;
          c1.stragglerC = true;
        }
      }
    }
  };
  
  void convertToTriangle(){
    for(int i=0;i<tconnections.size();i++){
      cell c = tconnections.get(i);
      ArrayList<cell> temp = new ArrayList<cell>();
      for(int j=0;j<c.tconnections.size();j++){
        cell c1 = c.tconnections.get(j);
        
        if(c1.tconnections.contains(this)){
          temp.add(c1);
        }
      }
      
      if(temp.size()==2){
        PVector p1 = new PVector((x+c.x+temp.get(0).x)/3,(y+c.y+temp.get(0).y)/3);
        PVector p2 = new PVector((x+c.x+temp.get(1).x)/3,(y+c.y+temp.get(1).y)/3);
        
        cell c2 = new cell(1000000,p1.x,p1.y);
        cell c3 = new cell(1000000,p2.x,p2.y);
        
        c2.vertices.add(this);
        c2.vertices.add(c);
        c2.vertices.add(temp.get(1));
        
        c3.vertices.add(this);
        c3.vertices.add(c);
        c3.vertices.add(temp.get(0));
        
        if(!delaunySites.contains(c2))delaunySites.add(c2);
        if(!delaunySites.contains(c3))delaunySites.add(c3);
      }
    }
  };
  
  ArrayList<cell> getNeighbours(int k){
    if(radiusN.size()<rounds){
      //r1 +=1;
      max = r1*Max;
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
                      if(d<k){
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
            if(!tconnections.contains(c)&&!failed.contains(c)){
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
  
  
  void draw(){
    
    fill(col);
    //ellipse(x,y,r,r);
    stroke(col);
    strokeWeight(r/2);
    point(x,y);
    strokeWeight(1);
    noFill();
    if(pos())rect(minx,miny,maxx-minx,maxy-miny);
  };
  
  void drawVerticesD(){
    
    fill(col);
    //ellipse(x,y,r,r);
    stroke(col);
    strokeWeight(r/2);
    point(x,y);
    strokeWeight(1);
    noFill();
    if(p1==null){
      p1 = new PVector(vertices.get(0).x,vertices.get(0).y);
    }
    if(p2==null){
      p2 = new PVector(vertices.get(1).x,vertices.get(1).y);
    }
    if(p3==null){
      p3 = new PVector(vertices.get(2).x,vertices.get(2).y);
    }
    stroke(0);
    beginShape();
    //vertex(x,y);
    fill(col);
    
    if(mousePressed)noFill();
    //vertex(vertices.get(0).x,vertices.get(0).y);
    //vertex(vertices.get(1).x,vertices.get(1).y);
    //vertex(vertices.get(2).x,vertices.get(2).y);
    vertex(p1.x,p1.y);
    vertex(p2.x,p2.y);
    vertex(p3.x,p3.y);
    endShape(CLOSE);
  };
  
  void drawContour(){
    if(center);
    for(int i=0;i<sconnections.size();i++){
      cell c = sconnections.get(i);
      cell c1 = null;
      if(i<sconnections.size()-1)c1 = sconnections.get(i+1);
      else c1 = sconnections.get(0);
      stroke(0);
      if(straggler)stroke(0,0,255);
      strokeWeight(3);
      line(c.x,c.y,c1.x,c1.y);
      fill(0);
      text(i,c.x+10,c.y);
    }
  };
  
  void drawConnections(){
    if(center);
    for(int i=0;i<sconnections.size();i++){
      cell c = sconnections.get(i);
      stroke(255);
      
      strokeWeight(1);
      if(center&&pos()){
        stroke(255,0,0);
        strokeWeight(3);
      }
      line(c.x,c.y,x,y);
    }
  };
  
  boolean pos(){
    return dist(mouseX,mouseY,x,y)<=r;
  };
  
  
  
  
};
