//-------------------------------------------------------------------------------

void pop(){
 
 for (int j=0;j<gh;j++){
    for (int i=0;i<gw;i++){
      int id = i+j*(int)gw;
      PVector p = new PVector(i*gW,j*gH);
      qgrid.add(new Quad(p,id,i,j));
    }}
};
