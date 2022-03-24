class SonicSensor{
  float x, y;
  float pointAngle;
  float sensAngle;
  float distance;
  
  SonicSensor(){
    sensAngle = 0.6; //0.7
  }
  
  void setPos(float x, float y){
    this.x = x;
    this.y = y;
  }
  
  void setAngle(float a){
    pointAngle = mod(a, TWO_PI);
  }
  
  float getDist(){
    return distance;
  }
  
  void getData(){
    distance = 10;
    for(Obsteacle o : map.obsteacles){
      float targetAngle = mod(atan2(o.y - y, o.x - x), TWO_PI);
      // https://stackoverflow.com/questions/12234574/calculating-if-an-angle-is-between-two-angles
      float anglediff = (pointAngle - targetAngle + PI + TWO_PI) % TWO_PI - PI;
      if(anglediff <= sensAngle/2 && anglediff >= -sensAngle/2){
        float distToTarget = o.getDist(x,y)-o.s/2;
        if(distance > distToTarget){
          distance = distToTarget;
        }
      }
    }
  }
  
  void display(){
    if(distance < 0.2){
      fill(255, 0, 0, 50);
    }else if(distance < 0.5){
      fill(255, 255, 0, 50);
    }else{
      fill(0, 255, 0, 50);
    }
    noStroke();
    arc(toScreenX(x), toScreenY(y), toScreen(distance*2), toScreen(distance*2), pointAngle - sensAngle/2, pointAngle + sensAngle/2, PIE);
    
    //drawCross(x, y);
    
    //fill(255);
    //textAlign(LEFT, TOP);
    //text("Sensor Dist: " + int(distance*1000) + "mm", toScreenX(x), toScreenY(y));
  }
  
}
