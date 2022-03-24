class Trail{
  float[] x;
  float[] y;
  
  Trail(){
    x = new float[1000];
    y = new float[1000];
  }
  
  void drawTrail(float nx, float ny){
    if(dist(nx, ny, x[x.length-1], y[y.length-1]) > 0.05){
      for(int i=1; i<x.length; i++){
        x[i-1] = x[i];
        y[i-1] = y[i];
      }
      
      x[x.length-1] = nx;
      y[x.length-1] = ny;
    }
  }
  
  void display(){
    stroke(0, 150, 200);
    strokeWeight(1);
    for(int i=1; i<x.length; i++){
      line( toScreenX(x[i-1]), toScreenY(y[i-1]), toScreenX(x[i]), toScreenY(y[i]) );
    }
  }
}
