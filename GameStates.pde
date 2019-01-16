
void runGame() {
  background(0);
  HUD();
  player1.update();
  player2.update();
  updateAsteroid();

  if (player1.health <= 0) {
    gameOver = true;
  }

  if (gameOver) {
    gameState = 5;
  }

  //explosion animation
  for (int i = 0; i < explosions.size(); i++) {
    explosions.get(i).draw(); //this is very important
  }
}

void gamePaused() {
  background(0);
  pauseScreen();
}

/*
gameState
 0 = start screen
 1 = SingPlay Game
 2 = shop
 3 = pause screen
 4 = instructions
 5 = end screen
 
 
 */



void currentGameState() {
  if (gameState == 0) {
    startScreenUI();
  } else if (gameState == 1) {
    runGame();
  } else if (gameState == 2) {
    shopScreen();
  } else if (gameState == 3) {
    pauseScreen();
  } else if (gameState == 4) {
    drawInstructions();
  } else if (gameState == 5) {
    endScreen();
  }
}
