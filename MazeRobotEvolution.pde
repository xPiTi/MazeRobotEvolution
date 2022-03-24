float scale = 300;
float scaleG = 300;
float panX = 0;
float panY = 0;
float panXG = 0;
float panYG = 0;
float panStartX = 0;
float panStartY = 0;
boolean grabSpaceToMouse = false;
boolean centerOnRobot = true;
boolean showMap = true;
boolean showGrid = false;
int updateSpeed = 1;
ArrayList<Robot> robots = new ArrayList<>();

ObsteacleMap map;

void setup() {
  //size(910, 540, P2D);
  //surface.setLocation(100, 100);
  fullScreen(P2D, 2);
  smooth(8);

  map = new ObsteacleMap();
  map.loadJSON("data.json");
  
  //x, y, a, ls, rs, ss;
  robots.add(new Robot(0.25, 0.25, 0, 0.005, 0.02051, 1));
  for (int i=0; i<3; i++) {
    robots.add(new Robot(0.25, 0.25, 0, random(0.001, 0.01), random(0.03, 0.05), random(0.4, 1.2)));
  }
}

void draw() {
  background(0);

  if (showGrid) drawGrid();
  map.update();
  if (showMap) map.display();
  
  for (int i=0; i<updateSpeed; i++) {
    for (Robot r : robots) {
      r.update();
    }
  }

  for (Robot r : robots) {
    r.display();
  }

  drawScaleGauge();

  if (grabSpaceToMouse) {
    panXG = mouseX - panStartX;
    panYG = mouseY - panStartY;
  }

  if (centerOnRobot) {
    panXG = toScreen(-robots.get(0).x)+width/2;
    panYG = toScreen(-robots.get(0).y)+height/2;
  }

  drawCross( round( toUnitX(mouseX)*20 )/20.0, round( toUnitY(mouseY)*20 )/20.0 );

  scale += (scaleG-scale)/10;
  panX += (panXG-panX)/10;
  panY += (panYG-panY)/10;
}

void keyPressed() {
  for (Robot r : robots) {
    r.keyPressed();
  }
  
  if (keyCode == 'F') centerOnRobot = !centerOnRobot;
  if (keyCode == 'P') map.saveJSON("data.json");
  if (keyCode == 'R') map.loadJSON("data.json");
  if (keyCode == 'M') showMap = !showMap;
  if (keyCode == 'G') showGrid = !showGrid;
  if (keyCode == ' ') updateSpeed = 10;
  // Q = auto drive
}

void keyReleased() {
  for (Robot r : robots) {
    r.keyReleased();
  }
  
  if (keyCode == ' ') updateSpeed = 1;
}

void mousePressed() {
  if (mouseButton == RIGHT && keyPressed == false) {
    grabSpaceToMouse = true;
    panStartX = mouseX - panXG;
    panStartY = mouseY - panYG;
  }
  map.mousePressed();
}

void mouseReleased() {
  grabSpaceToMouse = false;
  map.mouseReleased();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scaleG += e*50;
  if (scaleG < 100) {
    scaleG = 100;
  }
  if (scaleG > 5000) {
    scaleG = 5000;
  }
}
