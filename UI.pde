boolean buttonHit(float rBorder, float lBorder, float tBorder, float bBorder) {
  if (mouseX < rBorder && mouseX > lBorder && mouseY < bBorder && mouseY > tBorder) {
    //println("yepper");
    return true;
  } else {
    //println(mouseX + "........" + mouseY);
    //println(rBorder + "....." + lBorder + "....." + bBorder + "....." + tBorder);
    return false;
  }
}

void startScreenUI() {
  cam.beginHUD();
  background(0, 100, 100);
  fill(0, 255, 255);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Press the ENTER key to begin", width/2, height*0.3);
  text("Press the \"i\" key to see the instructions.", width/2, height*0.75);
  image(startScreenAsteroid, width/2, height/2);
  rectMode(CENTER);
  noStroke();



  //key controls for this is in the controls tab
  if (buttonHit(500, 300, 390, 340)) {
    //mouseX > 500 && mouseX < 300 && mouseY > 390 && mouseY < 340
    fill(b_unselectedColor);
    b_singlePlayerHit = true; //single player
    b_multiPlayerHit = false;
    //println("hit a");
  } else if (buttonHit(500, 300, 490, 440)) {
    fill(b_unselectedColor);
    b_singlePlayerHit = false; //multi-player
    b_multiPlayerHit = true;
    //println("hit b");
  } else {
    fill(b_unselectedColor);
    //println("nah");
  }

  rect(width/2, height*0.45, singlePlayerButtonWidth, singlePlayerButtonHeight, 10);
  //ellipse((width/2)+(singlePlayerButtonWidth/2), height*0.45, singlePlayerButtonHeight, singlePlayerButtonHeight);
  //ellipse((width/2)-(singlePlayerButtonWidth/2), height*0.45, singlePlayerButtonHeight, singlePlayerButtonHeight);

  rect(width/2, height*0.55, singlePlayerButtonWidth, singlePlayerButtonHeight, 10);

  //ellipse((width/2)+(singlePlayerButtonWidth/2), height*0.55, singlePlayerButtonHeight, singlePlayerButtonHeight);
  //ellipse((width/2)-(singlePlayerButtonWidth/2), height*0.55, singlePlayerButtonHeight, singlePlayerButtonHeight);

  fill(0);
  textSize(20);
  text("Single Player", width/2, (height*0.45)-4);
  text("CO-OP / Duos", width/2, (height*0.55)-4);


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
  fill(0, 0, 255);
  rect(0, height-12, player2.health, 12);
  fill(100, 100, 100);
  rect(0, 12, 600, topBannerHeight);
  ellipse(600, 12+(topBannerHeight/2), topBannerHeight, topBannerHeight);
  fill(255);
  textSize(20);
  textAlign(CENTER, CORNER);
  text("FPS: ", 30, 40);
  text(frameRate, 90, 40);
  text("Score: " + currentScore, 200, 40);

  //money display
  textAlign(RIGHT);
  text("Money: $" + (int)currentMoney, 600, 40);




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
  text("To RESUME: Press the 'b' key again", width/2, height*0.9);
  textSize(20);
  text("Press the number that corresponds to the item you'd like to buy", width/2, height*0.2);
  //items list
  textAlign(LEFT);
  text("1:", width*0.15, height*0.3);
  text("2:", width*0.15, height*0.4);
  text("3:", width*0.15, height*0.5);
  text("4:", width*0.15, height*0.6);

  text("Stim Shot (Increases health by 100HP) [$20]", width*0.2, height*0.3);
  text("Bigger Bullets (Doubles the size of each bullet) [$27]", width*0.2, height*0.4);
  text("3 Way Shot (Shoots 3 bullets in different directions) [$30]", width*0.2, height*0.5);
  text("Shield (Places a shield over the ship for 15 secs) [$40]", width*0.2, height*0.6);
  cam.endHUD();
}

void updateScores() {
  //scores = sort(scores);
  boolean highEnough = false;
  for (int score : scores) {
    if (currentScore>score) {
      if (!highEnough) {
        println(currentScore +">"+ score);
        scores[scores.length-1]=currentScore;
        highEnough = true;
      } else {
        break;
      }
    }
  }

  //if score is larger than smallest score in array overwrite it
  //if (scores[0] < currentScore && !checkScore) {
  //  scores[0] = currentScore;
  //  scores = sort(scores);
  //  checkScore = true;
  //}
  scores = sort(scores);
  scores = reverse(scores);

  print("Scores: ");
  for (int score : scores) {
    print (score);
    print(", ");
  }
  println("");
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
    player2.health = width;
    player2.resetShip();
    currentScore = 0;
    for (int i = 1; i < asteroids.size(); i++) {
      asteroids.remove(i);
    }
    gameOver = false;
    gameState = 1;
  }

  for (int i = 0; i < scores.length; i++) {
    text("Highest Score #" + (i+1) + ": " + scores[i], width/2, (height/4)*3+i*40);
  }
  //print(scores.toString);

  cam.endHUD();
}
