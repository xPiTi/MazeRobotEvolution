float mod(float n, float m){
  float a = n % m;
  if(a < 0) a += m;
  return a;
}

void drawCross(float x, float y){
  stroke(50, 255, 150);
  strokeWeight(1);
  line(toScreenX(x)-10, toScreenY(y), toScreenX(x)+10, toScreenY(y));
  line(toScreenX(x), toScreenY(y)-10, toScreenX(x), toScreenY(y)+10);
}

float toScreen(float x){ return x * scale; }
float toScreenX(float x){ return (x * scale)+panX; }
float toScreenY(float y){ return (y * scale)+panY; }

float toUnit(float x){ return x / scale; }
float toUnitX(float x){ return (x-panX) / scale; }
float toUnitY(float y){ return (y-panY) / scale; }

void drawGrid(){
  float spacing = 0.1; // 100mm
  strokeWeight(1);
  
  for(int x=0; x<=50; x++){
    if(x%5==0) stroke(0, 255, 0, 150); else stroke(0, 255, 0, 50);
    line(toScreenX(spacing*x), toScreenY(0), toScreenX(spacing*x), toScreenY(5));
  }
  for(int y=0; y<=50; y++){
    if(y%5==0) stroke(0, 255, 0, 150); else stroke(0, 255, 0, 50);
    line(toScreenX(0), toScreenY(spacing*y), toScreenX(5), toScreenY(spacing*y));
  }
}

void drawScaleGauge(){
  fill(255);
  textAlign(LEFT, BOTTOM);
  text("Scale 1m = " + int(scale) + "px", 10, height-35);
  text("0mm", 10, height-25);
  textAlign(CENTER, BOTTOM);
  text("500mm", 10+toScreen(0.5), height-25);
  textAlign(RIGHT, BOTTOM);
  text("1000mm", 10+toScreen(1), height-25);
  
  stroke(255);
  strokeWeight(1);
  fill(200);
  rect(10, height-20, toScreen(0.1), 10);
  noFill();
  for(int i=1; i<10; i++){
    rect(10+toScreen(0.1)*i, height-20, toScreen(0.1), 10);
  }
}
