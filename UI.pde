
void startScreenUI() {
  cam.beginHUD();
  background(0, 100, 100);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Press the ENTER key to begin", width/2, height*0.3);
  text("Press the \"i\" key to see the instructions.", width/2, height*0.75);
  image(startScreenAsteroid, width/2, height/2);
  rectMode(CENTER);
  noStroke();
  rect(width/2, height*0.45, singlePlayerButtonWidth, singlePlayerButtonHeight);
  //ellipse((width/2)+(singlePlayerButtonWidth/2), height*0.45, singlePlayerButtonHeight, singlePlayerButtonHeight);
  //ellipse((width/2)-(singlePlayerButtonWidth/2), height*0.45, singlePlayerButtonHeight, singlePlayerButtonHeight);
  if ((mouseX > (width/2)/) || (mouseX) || ()) {
    
  }
    rect(width/2, height*0.55, singlePlayerButtonWidth, singlePlayerButtonHeight);
  //ellipse((width/2)+(singlePlayerButtonWidth/2), height*0.55, singlePlayerButtonHeight, singlePlayerButtonHeight);
  //ellipse((width/2)-(singlePlayerButtonWidth/2), height*0.55, singlePlayerButtonHeight, singlePlayerButtonHeight);

  fill(0);
  text("Single Player", width/2, (height*0.45)-4);
  text("COOP - Duos", width/2, (height*0.55)-4);

  //key controls for this is in the controls tab
  cam.endHUD();
}

void drawInstructions() {
  cam.beginHUD();
  background(219, 112, 147);
  fill(30, 144, 255);
  textAlign(LEFT);
  //player 1 display controls
  textSize(40);
  text("Player 1: ", 50, 100);
  textSize(20);
  text("Use the arrow keys to move the rocket.", 70, 140);
  text("Use the \",\" (comma) key to shoot.", 70, 170);

  //player 2 display controls
  textSize(40);
  text("Player 2: ", 50, 250);
  textSize(20);
  text("Use the WASD keys to move the rocket.", 70, 290);
  text("Use the SPACE bar to shoot.", 70, 320);

  //what to do in the game
  textSize(40);
  text("The Objective:", 50, 450);
  textSize(20);
  text("Use your rocket to destroy the orbiting asteroids. As you destroy more \nasteroids, more spawn in, make the game harder and harder.", 70, 490);
  text("If you shoot the center asteroid, more asteroids will spawn, making it \nmore difficult.", 70, 570);
  text("If you choose to never shoot and just dodge, good luck getting score.", 70, 650);
  cam.endHUD();
}


void HUD() {
  float topBannerHeight = 40;

  cam.beginHUD();
  fill(255, 0, 0);
  rectMode(CORNER);
  rect(0, 0, player1.health, 12);
  fill(100, 100, 100);
  rect(0, 12, 600, topBannerHeight);
  ellipse(600, 12+(topBannerHeight/2), topBannerHeight, topBannerHeight);
  fill(255);
  textSize(20);
  text("FPS: ", 30, 40);
  text(frameRate, 90, 40);
  text("Score: " + currentScore, 200, 40);




  cam.endHUD();
}

void pauseScreen() {
  cam.beginHUD();
  background(0, 255, 0, 155);
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text("GAME PAUSED", width/2, height*0.3);
  text("Press the p key to resume", width/2, height*0.6);

  cam.endHUD();
}

void shopScreen() {
  cam.beginHUD();
  background(255, 215, 0, 240);
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text("Welcome to the International Space Station \nMobile Shop!", width/2, height*0.1);
  text("To RESUME: Pess the 'b' key again", width/2, height*0.9);

  cam.endHUD();
}

void endScreen() {
  cam.beginHUD();
  background(255, 0, 0, 200);
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text("GAME OVER!!!", width/2, height*0.3);
  text("currentScore: " + currentScore, width/2, height*0.45);
  text("Press the ENTER key to restart", width/2, height*0.6);

  if (keyPressed && keyCode == ENTER) {
    player1.health = width;
    player1.resetShip();
    player1.health = width;
    player1.resetShip();
    currentScore = 0;
    gameOver = false;
    gameState = 1;
  }

  cam.endHUD();
}
