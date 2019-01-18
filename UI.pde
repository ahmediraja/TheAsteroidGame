
void startScreenUI() {
  cam.beginHUD();
  background(0, 100, 100);
  fill(0, 255, 255);
  textAlign(CENTER, CENTER);
  textSize(30);
  text("Press the ENTER key to begin!", width/2, height*0.75);
  text("Press the \"i\" key to see the instructions.", width/2, height*0.3);
  image(startScreenAsteroid, width/2, height/2);
  rectMode(CENTER);
  noStroke();



  //key controls for this is in the controls tab


  cam.endHUD();
}

void drawInstructions() {
  cam.beginHUD();
  background(219, 112, 147);
  fill(30, 144, 255);
  textAlign(LEFT);
  //player 1 display controls
  textSize(35);
  text("Player 1: ", 50, 100);
  textSize(15);
  text("Use the ARROW KEYS to MOVE the rocket.", 70, 135);
  text("Use the \",\" (COMMA) key to SHOOT.", 70, 165);

  //player 2 display controls
  textSize(35);
  text("Player 2: ", 50, 220);
  textSize(15);
  text("Use the WASD keys to MOVE the rocket.", 70, 255);
  text("Use the \"q\" key to SHOOT.", 70, 290);
  
  //display shop controls
  textSize(35);
  text("Shop Interaction:", 450, 100);
  textSize(15);
  text("Use the \"b\" key to toggle the shop.", 470, 135);
  text("Further instructions are in the shop menu.", 470, 165);
  
  //display mute controls
  textSize(35);
  text("To mute SFX: ", 450, 220);
  textSize(15);
  text("Use the \"m\" key to toggle the muting.", 470, 255);
  
  //what to do in the game
  textSize(40);
  text("The Objective:", 50, 350);
  textSize(20);
  text("When you are in the game, to begin, shoot the center asteroid!", 70, 400);
  text("Use your rocket to destroy the orbiting asteroids. As you destroy more \nasteroids, more spawn in, make the game harder and harder!", 70, 450);
  text("If you shoot the center asteroid, more asteroids will spawn, making it \nmore difficult for you!", 70, 520);
  text("If you choose to never shoot and just dodge, good luck getting score!", 70, 590);
  text("Keep in mind, when you first start, the ships are on top of one another!", 70, 630);
  textSize(30);
  text("REMEMBER: YOU ARE A TEAM!", 100, 690);
  textSize(20);
  text("Press the \"i\" key again to return to the home screen!", 70, 740);
  textSize(10);
  text("To make the game harder, only the BLUE ship allows you to zoom out.", 70, 770);
  text("CHEAT: Pressing the \"y\" key give you free money!", 70, 790);
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

  if (muted) {
    fill(255, 0, 0);
    text("MUTED", 100, 100);
  }


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
  text("{BROKEN} Bigger Bullets (Doubles the size of each bullet) [$27]", width*0.2, height*0.4);
  text("{BROKEN} 3 Way Shot (Shoots 3 bullets in different directions) [$30]", width*0.2, height*0.5);
  text("{BROKEN} Shield (Places a shield over the ship for 15 secs) [$40]", width*0.2, height*0.6);
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

  scores = sort(scores);
  scores = reverse(scores);
  
  //for testing
  /*
  print("Scores: ");
  for (int score : scores) {
    print (score);
    print(", ");
  }
  println("");
  */
}

void endScreen() { //show the end screen ui
  cam.beginHUD();
  background(255, 0, 0, 200);
  textAlign(CENTER);
  textSize(30);
  fill(0);
  text("GAME OVER!!!", width/2, height*0.3);
  text("currentScore: " + currentScore, width/2, height*0.45);
  text("Press the ENTER key to restart", width/2, height*0.6);

  if (keyPressed && keyCode == ENTER) { //restart game
    player1.health = width;
    player1.resetShip();
    player2.health = width;
    player2.resetShip();
    currentScore = 0;
    currentMoney = 0;
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
