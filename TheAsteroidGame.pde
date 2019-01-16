import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import peasy.*;

PeasyCam cam;
Minim minim;
PImage startScreenAsteroid;

boolean multiplayer = true;
Ship player1;
Ship player2;
PVector player1InitPos = new PVector(600, 600, 0);
PVector player2InitPos = new PVector(200, 200, 0);

//sound variables
AudioSample bulletSound;

//Asteroids
Asteroid main;
ArrayList <Asteroid> asteroids = new ArrayList<Asteroid>();
PShape model;
PImage texture;
PVector center;

int gameState = 0;
int currentScore = 0;
boolean gameOver = false;

float shipToMainDistance;
//float ship2ToMainDistance;


ArrayList<Explosion> explosions = new ArrayList<Explosion>(); //need this to hold all explosions
PImage[] explosionImages = new PImage[8]; //holds the images of the explosion
PVector exSize = new PVector(60, 60); //how big of an explosion

void setup() {
  size(800, 800, P3D);
  frameRate(80);
  smooth(8);

  init();
}

void init() {
  center = new PVector(width/2, height/2, 0);
  player1 = new Ship(255, 0, 0, player1InitPos, 38, 39, 37, 188);
  if (multiplayer) {
    player2 = new Ship(0, 0, 255, player2InitPos, 87, 68, 65, 81);
  }
  cam = new PeasyCam(this, player1.midPoint.x, player1.midPoint.y, 0, 500);

  initSound();
  initAsteroids();
  initStars();
  initExplosion();
  player1.initShip();
  if (multiplayer) {
    player2.initShip();
  }
  imageMode(CENTER);
  startScreenAsteroid = loadImage("asteroid-icon.png");
}

void initSound() {
  minim = new Minim(this);
  bulletSound = minim.loadSample("Laser_Bullet_Sound.mov", 512);
}

void initCam() {
  cam.setMinimumDistance(50);
  cam.setMaximumDistance(500);
  cam.lookAt(width/2, height/2, 0, 500);
  //cam.setActive(false);
}

void initAsteroids() {
  //cam = new PeasyCam(this, width, height, 0, 600);
  center = new PVector(width/2, height/2);
  texture = loadImage("texture3.jpg");
  model = loadShape("asteroid_1_2.obj");
  model.setTexture(texture);

  main = new Asteroid(asteroids, 15, model, center, new PVector(), false);
}

void initExplosion() {
  //loading images   
  for (int i = 0; i < explosionImages.length; i ++) {
    explosionImages[i] = loadImage("explosion"+i+".png");
  }
}

void updateAsteroid() {
  for (int i = 0; i < asteroids.size(); i++) {
    asteroids.get(i).update();
  }
}

/*
void cameraZoom() {
 ship1ToMainDistance = PVector.dist(player1.sPos, main.pos);
 ship2ToMainDistance = PVector.dist(player2.sPos, main.pos);
 println(ship1ToMainDistance);
 if (ship1ToMainDistance < 300 || ship2ToMainDistance < 300) {
 //println(frameCount);
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 600, 50);
 } else if (ship1ToMainDistance > 700 || ship2ToMainDistance > 700) {
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 1400, 50);
 println(frameCount);
 
 } else {
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, ship1ToMainDistance*2, 50);
 }
/*
 if (ship1ToMainDistance < 300) {
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 600, 50);
 } else if (ship1ToMainDistance > 700) {
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, 1400, 50);
 } else {
 cam.lookAt(main.pos.x, main.pos.y, main.pos.z, ship1ToMainDistance*2, 50);
 }
 }
 */


void draw() {
  currentGameState();

  starBackground(); //stars should exist on start and end screen as well

  //println(player1.sPos); //show ship position
}
