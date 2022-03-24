class Obsteacle{
  float x, y;
  float s;
  
  Obsteacle(){
    x = random(5);
    y = random(5);
    s = 0.05;
  }
  
  Obsteacle(float x, float y){
    this.x = x;
    this.y = y;
    s = 0.05;
  }
  
  Obsteacle(JSONObject in){
    this.x = in.getFloat("x");
    this.y = in.getFloat("y");;
    this.s = in.getFloat("s");;
  }
  
  JSONObject getJSON(){
    JSONObject ret = new JSONObject();
    ret.put("x", x);
    ret.put("y", y);
    ret.put("s", s);
    return ret;
  }
  
  float getDist(float x, float y){
    return dist(this.x, this.y, x, y);
  }
  
  boolean isOver(float x, float y){
    return dist(this.x, this.y, x, y) < s/2;
  }
  
  void display(){
    fill(255, 80);
    noStroke();
    float ts = toScreen(s);
    rect(toScreenX(x)-ts/2, toScreenY(y)-ts/2, ts, ts);
  }
}
