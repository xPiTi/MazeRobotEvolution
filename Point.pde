class Point {
  float x;
  float y;
  float w;
  float h;
  boolean active;

  Point(float x, float y) {
    this.x = x-0.1;
    this.y = y-0.1;
    this.w = 0.2;
    this.h = 0.2;
    this.active = true;
  }

  Point(Point p) {
    this.x = p.x;
    this.y = p.y;
    this.w = p.w;
    this.h = p.h;
    this.active = true;
  }

  Point(JSONObject in) {
    this.x = in.getFloat("x");
    this.y = in.getFloat("y");
    this.w = in.getFloat("w");
    this.h = in.getFloat("h");
    this.active = true;
  }

  JSONObject getJSON() {
    JSONObject ret = new JSONObject();
    ret.put("x", x);
    ret.put("y", y);
    ret.put("w", w);
    ret.put("h", h);
    return ret;
  }

  float getDist(float x, float y) {
    return dist(this.x, this.y, x, y);
  }

  boolean isOver(float x, float y) {
    return x > this.x && x < this.x+this.w && y > this.y && y < this.y+this.h;
  }

  void display() {
    if(active){
      float screenX = toScreenX(x);
      float screenY = toScreenY(y);
      float screenW = toScreen(w);
      float screenH = toScreen(h);
      if(isOver(toUnitX(mouseX), toUnitY(mouseY))){
        fill(255, 0, 255, 100);
      }else{
        fill(255, 0, 255, 50);
      }
  
      noStroke();
      rect(screenX, screenY, screenW, screenH);
    }
  }
}
