//--------------------------------------------------------------------------------

class Quad{
  int id,iid,xpos,ypos;
  float x,y;
  PVector p;
  ArrayList<cell> children = new ArrayList<cell>();
  ArrayList<Quad> links = new ArrayList<Quad>();
  ArrayList<Quad> linksb = new ArrayList<Quad>();
  
  Quad(PVector P,int ID){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
  };
  
  Quad(PVector P,int ID,int i,int j){
    p = P;
    id = ID;
    x = p.x;
    y = p.y;
    xpos = i;
    ypos = j;
    links.add(this);
    linksb.add(this);
  };

  void draw(){
    strokeWeight(1);
    stroke(255);
    noFill();
    rect(p.x,p.y,gW,gH);
    
  };
  
  void fillc(){
    stroke(255);
    fill(255);
    rect(p.x,p.y,gW,gH);
    
  };
  
  void fillC(){
    fill(255);
    for(int i=0;i<children.size();i++){
        cell c = children.get(i);
        stroke(255,0,0);
        strokeWeight(10);
        point(c.x,c.y);
      }
    
  };
  
  void fill2(){
    fill(0);
    rect(p.x,p.y,gW,gH);
    println(id);
  };
  
  void clearLinks(){
    //links = new ArrayList<Quad>();
    //links.add(this);
    while(links.size()>1)links.remove(links.size()-1);
    children = new ArrayList<cell>();
  };
  
  boolean pos(){
    return mouseX>p.x&&mouseX<p.x+gW&&mouseY>p.y&&mouseY<p.y+gH;
  };
  
  void debug(){
    fill(255);
    //text(xpos+" "+ypos,p.x + 10,p.y + gH/2);
    text(links.size() + " " + children.size(),p.x + 10,p.y + gH/2);
    if(pos()){
      for(int i=0;i<links.size();i++){
        Quad q = links.get(i);
        q.fillc();
      }
    }
  };
};
