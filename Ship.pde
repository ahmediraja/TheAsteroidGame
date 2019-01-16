/*
Ahmed Raja
 Ship class
 includes ship driving, thrust animation
 */


class Ship {
  final int maxSize = 50;

  //variables for the ship
  PVector sPos = new PVector(500, 500, 0); //position of the ship
  PVector sVel = new PVector(); //velocity of the ship
  PVector sAcc = new PVector(); //acceleration of the ship
  PVector sDir = new PVector(0, 1, 0); //direction of the ship
  float shipSizeW = 30; //length of ship
  float shipSizeH = 10; //width of ship
  float shipSizeD = 10; //depth of ship
  float speedLimit = 4; //maximum speed for the ship
  boolean leftBool, rightBool, thrustBool; 
  float health = width;
  float sColR, sColG, sColB;
  PVector initPos;
  int thrustKey;
  int rightKey;
  int leftKey;
  int shootKey;

  //variables for the tracers(animation)
  float startSize = 30; // this is the tracers starting size
  PVector[] tPos = new PVector[maxSize];
  PVector[] tVel = new PVector[maxSize];
  PVector[] tAcc = new PVector[maxSize];
  float [] tSizes = new float[maxSize];
  float shrinkscale = 0.99;
  float velscale = 2;


  float dir = 0;     // Angle of ship
  float speed = 0;   // Speed of ship

  //variables of bullets
  ArrayList <PVector> bPos = new ArrayList <PVector>();
  ArrayList <PVector> bVel = new ArrayList <PVector>();
  float bulletSpeed = 5;
  float bulletSize = 5;

  PVector midPoint = new PVector(width/2, height/2, 0); //For PeasyCam

  Ship(float _r, float _g, float _b, PVector _initPos, int _thrustKey, int _rightKey, int _leftKey, int _shootKey) {
    sColR = _r;
    sColG = _g;
    sColB = _b;
    initPos = _initPos;
    thrustKey = _thrustKey;
    rightKey = _rightKey;
    leftKey = _leftKey;
    shootKey = _shootKey;
  }

  void initShip() {
    for (int i = 0; i < maxSize; i++) {
      tPos[i] = new PVector(-1000, -1000);
      tVel[i] = PVector.random2D();
      tVel[i].mult(velscale);
      tAcc[i] = new PVector(0, 0);

      tSizes[i] = startSize;
    }

    new Asteroid(main, new PVector(random(300, 500), random(300, 500)));
  }

  boolean detect(PVector pos1, PVector pos2, float rad) {
    boolean isFar =  PVector.dist(pos1, pos2) > rad;
    return isFar;
  }

  PVector p;
  PVector v;

  void bulletControl() {
    try {
      for (int i = 0; i < bPos.size(); i++) {

        p = bPos.get(i);
        v = bVel.get(i);
        p.add(v);
        noStroke();
        pushMatrix();
        fill(255, 0, 0);
        translate(p.x, p.y, p.z);
        sphere(bulletSize);
        popMatrix();
        //detects if the bullet is outside the screen
        if (detect(p, new PVector(width/2, height/2), width)) {
          bPos.remove(p);
          bVel.remove(v);
        }
      }

      if (detectHit(asteroids.get(0).pos, p, asteroids.get(0).mass*2, bulletSize)) {
        //println("Hit");
        bPos.remove(p); 
        bVel.remove(v);
        PVector randomLocation = new PVector(random(200, 600), random(200, 600));
        new Asteroid(main, randomLocation);
      }
    } 
    catch(Exception e) {
      e.getStackTrace();
    }
  }


  boolean detectHit(PVector pos1, PVector pos2, float rad1, float rad2) {
    boolean isHit = PVector.dist(pos1, pos2) < (rad1 + rad2);
    return isHit;
  }

  void resetShip() {
    initShip();
    sPos.set(initPos);
    sVel = new PVector(); //velocity of the ship
    sAcc = new PVector(); //acceleration of the ship
    sDir = new PVector(0, 1, 0); //direction of the ship
  }

  void asteroidHitDetection() {
    for (int i = 0; i < bPos.size(); i++) {
      for (int j = 1; j < asteroids.size(); j++) {
        if (detectHit(asteroids.get(j).pos, bPos.get(i), asteroids.get(j).siz*0.66, bulletSize)) {
          explosions.add(new Explosion(bPos.get(i), exSize, explosions, explosionImages, 4));
          asteroids.remove(j);
          bPos.remove(i);
          bVel.remove(i);
          currentScore += 5;
          new Asteroid(main, new PVector(random(0, 1500), random(0, 1500)));
          break;
        }
      }
    }
  }

  void shipHitDetection() {
    for (int i = 0; i < asteroids.size(); i++) {
      if (detectHit(asteroids.get(i).pos, sPos, asteroids.get(i).siz*0.7, shipSizeW)) {
        health -= (width/5);
        resetShip();
        print(health);
        break;
      }
    }
  }

  void tracers() {
    noStroke();

    for (int i = maxSize -1; i > 0; i--) { //Move each tracer back in array
      tPos[i] = tPos[i-1];
      tSizes[i] = tSizes[i-1]*shrinkscale;  //Shrink tracer as moving through array
      tVel[i] = tVel[i-1];
    }

    if (thrustBool) {
      tPos[0] = new PVector(sPos.x, sPos.y);
      tVel[0] = PVector.random2D();
      tVel[0].mult(velscale);
      tSizes[0] = startSize;
    } else { // If not pressing thrust, Then spawn Tracers out of screen
      tPos[0] = new PVector(-1000, -1000);
    }

    for (int i = 0; i < maxSize; i++) {
      tPos[i].add(tVel[i]);
      fill(255, 100 - (float)i/maxSize*254., 0, 255. - (float)i/15*254.);
      pushMatrix();
      translate(cos(dir)*speed, sin(dir)*speed);
      ellipse(tPos[i].x, tPos[i].y, tSizes[i]/3, tSizes[i]/3);
      popMatrix();
    }
  }

  void shipDriving() {
    sVel.add(sAcc);
    sPos.add(sVel);
    sAcc.set(0, 0, 0);

    fill(sColR, sColG, sColB);
    pushMatrix();
    translate(sPos.x, sPos.y);
    rotate(sDir.heading());
    stroke(1);
    box(shipSizeW, shipSizeH, shipSizeD);
    popMatrix();

    if (leftBool) { //add to rotation
      sDir.rotate(-0.03);
      //dir -= .05;
    }
    if (rightBool) {
      sDir.rotate(0.03);
      // dir += .05;
    } 

    if (thrustBool) { //Increase Speed
      //speed += .1;
      sAcc = sDir.copy().mult(0.05);
    } else { //Decrease Speed
      sVel.mult(0.98);
      //speed *= 0.99;
    }
    sVel.limit(speedLimit);
    //  speed = constrain(speed, 0, 4); //speedlimit
  }

  void shoot() {
    bulletSound.trigger();
    //position where the bullet starts
    bPos.add(new PVector(sPos.x, sPos.y, sPos.z));
    //speed and direction of bullet
    // bVel.add(new PVector(sDir.x, sDir.y, sDir.z).mult(bulletSpeed)); 
    PVector tempv = new PVector(sDir.x, sDir.y, sDir.z).mult(bulletSpeed);
    //tempv.rotate(random(-PI/4., PI/4));
    bVel.add(tempv);
  }

  void cameraZoom() {
    shipToMainDistance = PVector.dist(sPos, main.pos);
    //ship2ToMainDistance = PVector.dist(player2.sPos, main.pos);
    println(shipToMainDistance);
    if (shipToMainDistance < 300) {
      //println(frameCount);
      cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 600, 50);
    } else if (shipToMainDistance > 700) {
      cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 1400, 50);
      println(frameCount);
    } else {
      cam.lookAt(main.pos.x, main.pos.y, main.pos.z, shipToMainDistance*2, 50);
    }
  }

  void offEdge() {
    if (sPos.x > 1200) {
      sPos.x = -400;
    } else if (sPos.x < -400) {
      sPos.x = 1200;
    } else if (sPos.y > 1200) {
      sPos.y = -400;
    } else if (sPos.y < -400) {
      sPos.y = 1200;
    }
  }

  void controls() {
    /*
    if (keyPressed && keyCode == leftKey) {
      leftBool = true;
    } else {
      leftBool = false;
    }
    if (keyPressed && keyCode == rightKey) {
      rightBool = true;
    } else {
      rightBool = false;
    }
    if (keyPressed && keyCode == thrustKey) {
      thrustBool = true;
    } else {
      thrustBool = false;
    }
    if (keyPressed && keyCode == shootKey) {
      shoot();
    }
    */
    
    if (keyPressed && keyCode == leftKey) {
      leftBool = true;
    } else if (keyPressed && keyCode == rightKey) {
      rightBool = true;
    } else if (keyPressed && keyCode == thrustKey) {
      thrustBool = true;
    } else {
      thrustBool = false;
      rightBool = false;
      leftBool = false;
    }
    if (keyPressed && keyCode == shootKey) {
      shoot();
    }
  }

  void update() {
    shipDriving();
    tracers();
    bulletControl();
    offEdge();
    cameraZoom();
    asteroidHitDetection();
    shipHitDetection();
    //controls();
  }
}
