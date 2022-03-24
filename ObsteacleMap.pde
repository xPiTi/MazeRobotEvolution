class ObsteacleMap {
  ArrayList<Obsteacle> obsteacles;
  ArrayList<Point> points;

  ObsteacleMap() {
    obsteacles = new ArrayList<>();
    points = new ArrayList<>();
  }

  void loadJSON(String file) {
    JSONObject data = loadJSONObject(file);
    
    JSONArray obsteaclesJSON = data.getJSONArray("obsteacles");
    obsteacles = new ArrayList<>();
    for (int i=0; i<obsteaclesJSON.size(); i++) {
      JSONObject o = obsteaclesJSON.getJSONObject(i);
      obsteacles.add(new Obsteacle(o));
    }
    
    JSONArray pointsJSON = data.getJSONArray("points");
    points = new ArrayList<>();
    for (int i=0; i<pointsJSON.size(); i++) {
      JSONObject p = pointsJSON.getJSONObject(i);
      points.add(new Point(p));
    }
  }

  void saveJSON(String file) {
    JSONArray obsteaclesJSON = new JSONArray();
    for (int i=0; i<obsteacles.size(); i++) {
      Obsteacle o = obsteacles.get(i);
      obsteaclesJSON.setJSONObject(i, o.getJSON());
    }

    JSONArray pointsJSON = new JSONArray();
    for (int i=0; i<points.size(); i++) {
      Point p = points.get(i);
      pointsJSON.setJSONObject(i, p.getJSON());
    }

    JSONObject data = new JSONObject();
    data.setJSONArray("obsteacles", obsteaclesJSON);
    data.setJSONArray("points", pointsJSON);

    saveJSONObject(data, file);
  }

  void update() {
    if (mouseButton == RIGHT && keyPressed == true && keyCode == CONTROL) {
      deleteObsteaclePos(toUnitX(mouseX), toUnitY(mouseY));
    }
    if (mouseButton == LEFT && keyPressed == true && keyCode == CONTROL) {
      addObsteacle(new Obsteacle( round( toUnitX(mouseX)*20 )/20.0, round( toUnitY(mouseY)*20 )/20.0 ));
    }

    if (mouseButton == RIGHT && keyPressed == true && keyCode == SHIFT) {
      deletePointPos(toUnitX(mouseX), toUnitY(mouseY));
    }
    
  }
  
  void mousePressed(){
    if (mouseButton == LEFT && keyPressed == true && keyCode == SHIFT) {
      addPoint(new Point( round( toUnitX(mouseX)*20 )/20.0, round( toUnitY(mouseY)*20 )/20.0 ));
    }
  }
  
  void mouseReleased(){
    
  }

  Obsteacle getClosestObsteacle(float x, float y) {
    Obsteacle ret = null;
    float bestDist = Float.MAX_VALUE;
    for (Obsteacle o : obsteacles) {
      if (o.getDist(x, y) < bestDist) {
        bestDist = o.getDist(x, y);
        ret = o;
      }
    }
    return ret;
  }


  Obsteacle getObsteacleByPos(float x, float y) {
    for (Obsteacle o : obsteacles) if (o.isOver(x, y)) return o;
    return null;
  }

  boolean obsteacleExists(float x, float y) {
    return getObsteacleByPos(x, y) != null;
  }

  void deleteObsteaclePos(float x, float y) {
    Obsteacle toBeRemoved = getObsteacleByPos(x, y);
    if (toBeRemoved != null) {
      obsteacles.remove(toBeRemoved);
    }
  }

  void addObsteacle(Obsteacle o) {
    if (!obsteacleExists(o.x, o.y)) {
      obsteacles.add(o);
    }
  }


  Point getPointByPos(float x, float y) {
    for (Point p : points) if (p.isOver(x, y)) return p;
    return null;
  }

  boolean pointExists(float x, float y) {
    return getPointByPos(x, y) != null;
  }

  void addPoint(Point p) {
    if (!pointExists(p.x, p.y)) {
      points.add(p);
      println("New point added at pos: " + p.x + " " + p.y);
    }
  }

  void deletePointPos(float x, float y) {
    Point toBeRemoved = getPointByPos(x, y);
    if (toBeRemoved != null) {
      points.remove(toBeRemoved);
    }
  }

  void display() {
    for (Obsteacle o : obsteacles) {
      o.display();
    }

    for (Point p : points) {
      p.display();
    }
  }
}
