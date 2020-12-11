float k = 1000, ik = 1370/k, jk = floor(760/k);
int W = 1200,H = 600,toggle = 0,toggle2 = 0;
int M = 1;
float R = 20;

float gh =  H/(R*M),gw = W/(R*M);
float gW = (W)/(gw), gH = H/(gh);
float Max = sqrt(gW * gW + gH * gH);
ArrayList<Quad> qgrid  = new ArrayList<Quad>();
ArrayList<Quad> qgridUp  = new ArrayList<Quad>();
