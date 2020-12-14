class Line {

  //PVector a,b;
  float x1, x2, y1, y2;
  cell a, b;
  Line(cell cell1, cell cell2) {
    x1 = cell1.x;
    y1 = cell1.y;

    x2 = cell2.x;
    y2 = cell2.y;
  };

  void checkMouse() {
  };
  
  void draw(){
    stroke(0);
    strokeWeight(2);
    line(x1,y1,x2,y2);
  };
};

PVector checkIntersect(Line a, Line b) {

  float a1 = a.y2 - a.y1;
  float b1 = a.x1 - a.x2;
  float c1 = a1 * a.x1 + b1 * a.y1;
  float a2 = b.y2 - b.y1;
  float b2 = b.x1 - b.x2;
  float c2 = a2 * b.x1 + b2 * b.y1;
  float denom = a1 * b2 - a2 * b1;
  //stroke(0,0,255);
  //strokeWeight(2);
  //line(a.x1,a.y1,a.x2,a.y2);
  //stroke(0,255,255);
  //strokeWeight(2);
  //line(b.x1,b.y1,b.x2,b.y2);
  if ((a.x1==b.x1||a.x2==b.x2)&&(a.y1==b.y1||a.y2==b.y2)) {
    
    return null;
  } else {

    Float X = (b2 *c1 - b1 * c2) / denom;
    Float Y = (a1 *c2 - a2 * c1) / denom;
    
    PVector p = new PVector(X, Y);   
    boolean Linea = ((p.x<a.x1&&p.x>a.x2)||(p.x>a.x1&&p.x<a.x2))&&((p.y<a.y1&&p.y>a.y2)||(p.y>a.y1&&p.y<a.y2));
    boolean Lineb = ((p.x<b.x1&&p.x>b.x2)||(p.x>b.x1&&p.x<b.x2))&&((p.y<b.y1&&p.y>b.y2)||(p.y>b.y1&&p.y<b.y2));
    boolean Linec = (p.x!=a.x1||p.x!=a.x2)&&(p.y!=a.y1||p.y!=a.y2);

    //Boolean Linec = (dist(p.x,p.y,a.x1,a.y1)>0.5&&dist(p.x,p.y,a.x1,a.y1)>0.5);
    float d = dist(p.x,p.y,a.x1,a.y1);
    float d1 = dist(p.x,p.y,a.x2,a.y2);
    float d2 = dist(p.x,p.y,b.x1,b.y1);
    float d3 = dist(p.x,p.y,b.x2,b.y2);
    //Boolean Linec = (dist(p.x,p.y,a.x1,a.y1)>0.5&&dist(p.x,p.y,a.x1,a.y1)>0.5);
    
    float n = 0.001;
    if (Linea&&Lineb&&d>n&&d1>n&&d2>n&&d3>n) {
    
    //if (Linea&&Lineb) {
      //strokeWeight(10);
      //stroke(255,255,0);
      //point(p.x,p.y);
      //strokeWeight(1);
      return p;
    } else {
      return null;
    }
  }
};

PVector checkIntersect2(Line a, Line b) {

  float a1 = a.y2 - a.y1;
  float b1 = a.x1 - a.x2;
  float c1 = a1 * a.x1 + b1 * a.y1;
  float a2 = b.y2 - b.y1;
  float b2 = b.x1 - b.x2;
  float c2 = a2 * b.x1 + b2 * b.y1;
  float denom = a1 * b2 - a2 * b1;
  stroke(0,0,255);
  strokeWeight(2);
  line(a.x1,a.y1,a.x2,a.y2);
  stroke(0,255,255);
  strokeWeight(2);
  line(b.x1,b.y1,b.x2,b.y2);
  if ((a.x1==b.x1||a.x2==b.x2)&&(a.y1==b.y1||a.y2==b.y2)) {
    
    return null;
  } else {

    Float X = (b2 *c1 - b1 * c2) / denom;
    Float Y = (a1 *c2 - a2 * c1) / denom;
    
    PVector p = new PVector(X, Y);   
    boolean Linea = ((p.x<a.x1&&p.x>a.x2)||(p.x>a.x1&&p.x<a.x2))&&((p.y<a.y1&&p.y>a.y2)||(p.y>a.y1&&p.y<a.y2));
    boolean Lineb = ((p.x<b.x1&&p.x>b.x2)||(p.x>b.x1&&p.x<b.x2))&&((p.y<b.y1&&p.y>b.y2)||(p.y>b.y1&&p.y<b.y2));
    boolean Linec = (p.x!=a.x1||p.x!=a.x2)&&(p.y!=a.y1||p.y!=a.y2);
    float d = dist(p.x,p.y,a.x1,a.y1);
    float d1 = dist(p.x,p.y,a.x2,a.y2);
    float d2 = dist(p.x,p.y,b.x1,b.y1);
    float d3 = dist(p.x,p.y,b.x2,b.y2);
    //Boolean Linec = (dist(p.x,p.y,a.x1,a.y1)>0.5&&dist(p.x,p.y,a.x1,a.y1)>0.5);
    
    int n = 1;
    if (Linea&&Lineb&&d>n&&d1>n&&d2>n&&d3>n) {
    //if (Linea&&Lineb&&Linec) {
      strokeWeight(10);
      stroke(255,255,0);
      point(p.x,p.y);
      strokeWeight(1);
      //text(p.x,p.y,a.x,a.y,b.x,b.y,p.x+10,p.y);
      return p;
    } else {
      return null;
    }
  }
};

boolean check_lineP(cell a, cell b, PVector c) {

  boolean k = false;
  float d1 = dist(a.x, a.y, b.x, b.y);
  float d2 = dist(a.x, a.y, c.x, c.y);
  float d3 = dist(b.x, b.y, c.x, c.y);
  float d4 = d2 + d3;

  if (d4 <= d1 + 0.05f && d4 >= d1 - 0.05f)k = true;

  return k;
};
