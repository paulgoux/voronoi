ArrayList<cell> points = new ArrayList<cell>();
ArrayList<cell> agents = new ArrayList<cell>();
ArrayList<Line> stragglers = new ArrayList<Line>();
ArrayList<ArrayList<cell>> stack = new ArrayList<ArrayList<cell>>();
ArrayList<ArrayList<cell>> hist = new ArrayList<ArrayList<cell>>();
//ArrayList<cell> linePair = new ArrayList<cell>();
HashMap<cell,ArrayList<cell>> lines = new HashMap<cell,ArrayList<cell>>();
ArrayList<cell>[]linePair;
ArrayList<cell>delaunySites = new ArrayList<cell>();
//HashMap<cell,triangle,> 
//ArrayList<cell>lines;
int total = 50,rounds = 1;
int maxPoints = 30;
boolean mdown;
void setup(){
  size(1000,600,P2D);
  W = width;
  H = height;
  linePair = new ArrayList[total];
  pop();
  
  for(int i=0;i<total;i++){
    
    float x = random(width);
    float y = random(height);
    
    cell c = new cell(i,x,y);
    points.add(c);
    linePair[i] = new ArrayList<cell>();
    lines.put(c,new ArrayList<cell>());
  }
  buildLines();
};
PVector mouse;
float scalex = 1,scaley = 1;
void draw(){
  mouse = new PVector(mouseX,mouseY);
  background(50);
  
  fill(255);
  //frameRate(5);
  text(frameRate,10,10);
  //while(rounds<10){
    //rounds ++;
  //buildLines();
  //}
  //drawLines();
  //pushMatrix();
  //if(mousePressed&&scalex<2){
  //  scalex+= 0.01;
  //  scaley+= 0.01;
    
  //}
  //if(mousePressed)translate(-(width-mouseX)*scalex,-(height-mouseY)*scaley);
  //scale(scalex,scaley);
    
    
  
  drawLines3();
  //popMatrix();
  //if(!mousePressed){
  //  scalex= 1;
  //  scaley= 1;
  //}
  
  //voronoi();
  if(mousePressed&&!mdown&&mouseButton==RIGHT&&keyPressed){
    //println("h");
    //rounds++;
    mdown = true;
    //frameRate(1);
  }
  if(!mousePressed){
    mdown = false;
    loop();
    //frameRate(60);
  }
};
