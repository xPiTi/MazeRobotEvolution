class Robot{
  float x, y;
  float angle;
  PImage img;
  
  boolean goForward;
  boolean goBackward;
  boolean goLeft;
  boolean goRight;
  
  float speed = 0.005;
  float roatationSpeed = 0.02051;
  float sensorSpacing = 1;
  
  ArrayList<Point> points;
  int score;
  
  //auto drivew logic
  long stopTimeCounter;
  boolean stuckRotate;
  
  boolean auto = true;
  
  SonicSensor sensor1;
  SonicSensor sensor2;
  SonicSensor sensor3;
  
  Trail trail;
  
  
  
  Robot(float x, float y, float a, float ls, float rs, float ss){
    this.x = x; 
    this.y = y;
    this.angle = a;
    this.speed = ls;
    this.roatationSpeed = rs;
    this.sensorSpacing = ss;
    
    img = loadImage("data/robot.png");
    sensor1 = new SonicSensor();
    sensor2 = new SonicSensor();
    sensor3 = new SonicSensor();
    trail = new Trail();
    
    points = new ArrayList<>();
    for(Point p : map.points){
      points.add( new Point(p) );
    }
  }
  
  void autoUpdate(){
    goForward = false;
    goLeft = false;
    goRight = false;
    

    //if its safe go forward
    if(sensor1.getDist() > 0.2
        && sensor2.getDist() > 0.2
        && sensor3.getDist() > 0.2
    ){
      goForward = true;
    }else{
      //if its not safe to go forward chech best option
      
      if(sensor2.getDist() > 0.2){
        goForward = true;
      }
      
      if(stuckRotate){
        goRight = true;
      }else{
        if(sensor1.getDist() > sensor3.getDist()){
          goLeft = true;
        }else{
          goRight = true;
        }
      }
    }
      
    
    if(goForward == false){
      stopTimeCounter++;
      if(stopTimeCounter > 200){
        stuckRotate = true;
      }
    }else{
      stopTimeCounter = 0;
      stuckRotate = false;
    }
    
  }
  
  void update(){
    if(goForward != goBackward){
      if(goForward){
        x += cos(angle) * speed;
        y += sin(angle) * speed;
      }else if(goBackward){
        x -= cos(angle) * speed;
        y -= sin(angle) * speed;
      }
    }
    if(goLeft != goRight){
      if(goLeft){
        angle -= roatationSpeed;
      }else if(goRight){
        angle += roatationSpeed;
      }
    }
    
    if(auto){
      autoUpdate();
    }
    
    Obsteacle collisionCheck = map.getClosestObsteacle(x, y);
    if(collisionCheck != null){
      float dist = collisionCheck.getDist(x, y);
      if(dist < 0.08){
        float targetAngle = mod(atan2(collisionCheck.y - y, collisionCheck.x - x), TWO_PI);
        x -= cos(targetAngle)*dist/10;
        y -= sin(targetAngle)*dist/10;
      }
    }
    
    sensor1.setPos(x, y);
    sensor1.setAngle(angle-sensorSpacing);
    sensor1.getData();
    
    sensor2.setPos(x, y);
    sensor2.setAngle(angle);
    sensor2.getData();
    
    sensor3.setPos(x, y);
    sensor3.setAngle(angle+sensorSpacing);
    sensor3.getData();
    
    trail.drawTrail(x, y);
    
    for(Point p : points){
      if(p.active){
        if(p.isOver(x, y)){
          p.active = false;
          score ++;
        }
      }
    }
  }
  
  void display(){
    trail.display();
    
    sensor1.display();
    sensor2.display();
    sensor3.display();
    
    float screenX = toScreenX(x);
    float screenY = toScreenY(y);
    float size = toScreen(0.1); //10cm
    
    push();
    translate(screenX, screenY);
    rotate(angle);
    imageMode(CENTER);
    image(img, toScreen(-0.01), 0, size, size);
    pop();
    
    fill(255);
    textAlign(CENTER, BOTTOM);
    text("Score: " + score, screenX, screenY-toScreen(0.05));
  }
  
  void keyPressed(){
    if(keyCode == 'W' || keyCode == UP) goForward  = true;
    if(keyCode == 'A' || keyCode == LEFT) goLeft     = true;
    if(keyCode == 'S' || keyCode == DOWN) goBackward = true;
    if(keyCode == 'D' || keyCode == RIGHT) goRight    = true;
    
    if(keyCode == 'Q') {
      auto = !auto;
      goForward = false;
      goLeft = false;
      goRight = false;
      goBackward = false;
    }
  }
  
  void keyReleased(){
    if(keyCode == 'W' || keyCode == UP) goForward  = false;
    if(keyCode == 'A' || keyCode == LEFT) goLeft     = false;
    if(keyCode == 'S' || keyCode == DOWN) goBackward = false;
    if(keyCode == 'D' || keyCode == RIGHT) goRight    = false;
  }
}
