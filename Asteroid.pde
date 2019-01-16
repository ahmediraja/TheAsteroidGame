class Asteroid {

  static final float G = 0.0002;
  static final float LOW_MASS = 1;

  PImage img;

  PShape model;

  ArrayList <Asteroid> asteroids;

  PVector pos; 

  PVector vel = new PVector();

  PVector acc = new PVector();

  PVector spin = new PVector();

  float mass = 0.5;

  float siz = 1000;

  boolean dead = false;

  boolean gravity = true;



  //the general purpose constructor
  public Asteroid(ArrayList<Asteroid> a, float m, PShape s, PVector p, PVector v) {
    asteroids = a;
    asteroids.add(this);
    model = s;
    pos = p;
    vel = v;
    mass = m;
    spin = setSpin();
    siz = setSize();
  }

  //the general purpose constructor
  public Asteroid(ArrayList<Asteroid> a, float m, PShape s, PVector p, PVector v, boolean willItHaveGravity) {
    asteroids = a;
    asteroids.add(this);
    model = s;
    pos = p;
    vel = v;
    mass = m;
    spin = setSpin();
    siz = setSize();
    gravity = willItHaveGravity;
  }


  //constructor to make objects orbit about a central body
  public Asteroid(Asteroid parent, float m, PVector newVel) {
    asteroids = parent.asteroids;
    asteroids.add(this);
    model = parent.model;
    pos = parent.pos.copy().add(newVel);//clear it away from the parent and sibings 
    vel = parent.vel.copy().add(newVel);//give new velocity
    mass = m;
    parent.pos.sub(newVel);
    parent.vel.sub(newVel);
    parent.mass -= mass;
    parent.siz = parent.setSize();
    spin = setSpin();
    siz = setSize();
  }

  public Asteroid(Asteroid main, PVector p) {
    asteroids = main.asteroids;
    asteroids.add(this);
    model = main.model;
    pos = p; 
    spin = setSpin();
    vel = calcOrbitalVelocity(main);
    siz = setSize();
  }

  float setSize() {
    return 10.* pow(mass, 0.333);
  }

  PVector setSpin() {
    return new PVector(random(-PI/100., PI/100.), random(-PI/100., PI/100.), random(-PI/100., PI/100.));
  }

  void move() {
    if (gravity) {
      acc.add(calcForce());
      vel.add(acc.x, acc.y, 0);
    }
    pos.add(vel);
    acc.mult(0);
  }

  PVector calcForce() {
    PVector tempAcc = new PVector();
    for (int i = 0; i <  asteroids.size(); i++) {
      Asteroid other = asteroids.get(i);
      // println(tempAcc.mag());
      if (this == other ) {
        continue;
      }
      PVector r = PVector.sub(pos, other.pos);

      if (r.mag()>siz) {  
        r.normalize();
        PVector grav = PVector.mult(r, - G*other.mass/r.magSq());
        tempAcc.add(grav);
      } else if (r.mag() < siz*0.666) {// && mass / other.mass >= 5) {
        //lets have an inelastic collision
        vel.mult(mass).add(other.vel.mult(other.mass));
        vel.div(mass + other.mass);
        // spin.div(mass);
        // other.spin.div(other.mass);
        //spin.add(other.spin);
        mass += other.mass;
        //  spin.mult(mass);
        siz = setSize();
        gravity = gravity||other.gravity;
        //model = getShape();
        asteroids.remove(other);//change this to asteroids.other.dead = true;
      } else {
        //lets bounce them off each other
      }
    }
    return tempAcc;
  }

  void drawA() {

    pushMatrix();
    translate(pos.x, pos.y, pos.z );
    scale(siz);
    model.rotateX(spin.x);
    model.rotateY(spin.y);
    model.rotateZ(spin.z);
    shape(model, 0, 0 );

    popMatrix();
  }

  void checkPos(PVector center) {
    //periodic boundary conditions
    //was centered on the original location but now centered on the ship 
    if (pos.dist(center) > 10*width) {
      pos.mult(-1);
    }
  }

  void checkPos() {
    //periodic boundary conditions
    //was centered on the original location but now centered on the ship 
    if (pos.dist(center) > 10*width) {
      pos.mult(-1);
    }
  }

  //not sure this is used currently, but will be handy once we have bullets.
  void checkDestroy() {
    if (dead) {

      asteroids.remove(this);
    }
  }

  PVector calcOrbitalVelocity(Asteroid main) {
    //get a velocity based on how far away the asteroid is
    PVector temp = PVector.sub(pos, main.pos);
    float dist = temp.mag();
    float speed = sqrt(G*main.mass/dist);
    temp.normalize();
    temp.mult(speed*450);
    float randDir = random(50);

    if (randDir < 50) {
      randDir = PI*0.5;
    } else {
      randDir = -PI*0.5;
    }
    temp.rotate(randDir);
    //rotate it by either 90 or 270    
    return temp;
  }

  void update(PVector origin) {
    move();

    checkPos(origin);
    drawA();
    checkDestroy();//not really used
  }

  void update() {
    move();

    checkPos();
    drawA();
    checkDestroy(); //not really used
  }
}
