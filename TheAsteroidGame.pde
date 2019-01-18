import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import peasy.*;

PeasyCam cam; //declaring camera
Minim minim;
PImage startScreenAsteroid; // home page image (for looks)
PImage moneyImg; //money pickup item symbol

boolean multiplayer = true; //always true
Ship player1; //declare player 1 ship
Ship player2; //declare player 2 ship

//sound variables
AudioSample bulletSound; //the audio
boolean muted = false; // used for mute functionality

//Asteroids
Asteroid main;
ArrayList <Asteroid> asteroids = new ArrayList<Asteroid>();
PShape model;
PImage texture;
PVector center;

int gameState = 0; //determines the screen displayed
int currentScore = 0; //score in current run of the game
int scores[] = {0, 0, 0, 0, 0}; //stores top 5 scores
boolean checkScore = false;
boolean gameOver = false; // tells everything that the game is over

float currentMoney = 0; //money

float shipToMainDistance;
//float ship2ToMainDistance;
PVector player1InitPos = new PVector(200, 200);
PVector player2InitPos = new PVector(600, 600);

ArrayList<Explosion> explosions = new ArrayList<Explosion>(); //need this to hold all explosions
PImage[] explosionImages = new PImage[8]; //holds the images of the explosion
PVector exSize = new PVector(60, 60); //how big of an explosion

//for UI
boolean b_singlePlayerHit = false;
boolean b_multiPlayerHit = false;
color b_unselectedColor = color(0, 255, 255);
color b_selectedColor = color(255, 215, 0);

//for pickup items
PickupItem money;
PVector moneyPos = new PVector(random(-200, 1000), random(-200, 1000));

int powerUp = 0;

long startTimer;

void setup() {
  size(800, 800, P3D);
  frameRate(80);
  smooth(8);

  init();
}

void init() {
  center = new PVector(width/2, height/2, 0);
  player1 = new Ship(255, 0, 0, player1InitPos);
  if (multiplayer) {
    player2 = new Ship(0, 0, 255, player2InitPos);
  }
  cam = new PeasyCam(this, player1.midPoint.x, player1.midPoint.y, 0, 500);

  initSound();
  initAsteroids();
  initStars();
  initExplosion();
  initPickupItems();
  player1.initShip();
  if (multiplayer) {
    player2.initShip();
  }
  imageMode(CENTER);
  startScreenAsteroid = loadImage("asteroid-icon.png");
  
  
}

void initPickupItems() {
  moneyImg = loadImage("dollar.png");
  money = new PickupItem(moneyPos, 20, moneyImg);
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

//does not work for unknown reason
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
  
  //used for testing:
  //println(muted);
  //println(player1.health + ".........." + player2.health);
  //println(player1.sPos); //show ship position
}
