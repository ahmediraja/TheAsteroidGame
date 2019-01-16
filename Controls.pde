void keyPressed() {
  //ship1 movement
  if (keyCode == LEFT) {
    player1.leftBool = true;
  }
  if (keyCode == RIGHT) {
    player1.rightBool = true;
  }
  if (keyCode == UP) {
    player1.thrustBool = true;
  }

  //ship2 movement
  if (multiplayer) {
    if (key == 'a') {
      player2.leftBool = true;
    }
    if (key == 'd') {
      player2.rightBool = true;
    }
    if (key == 'w') {
      player2.thrustBool = true;
    }
  }

  //shooting bullets
  //player1 shooting
  if (key == ',') {
    player1.shoot();
  }

  //player2 shooting
  if (multiplayer) {
    if (key == 'q') {
      player2.shoot();
    }
  }

  //startScreen control
  if (keyCode == ENTER && gameState == 0) {
    gameState = 1;
  }

  //pause controls
  if (key == 'p') {
    if (gameState == 1) {
      gameState = 3;
    } else if (gameState == 3) {
      gameState = 1;
    }
  }

  //instructions menu control
  if (key == 'i') {
    if (gameState == 0) {
      gameState = 4;
    } else if (gameState == 4) {
      gameState = 0;
    }
  }

  //pause controls
  if (key == 'b') {
    if (gameState == 1) {
      gameState = 2;
    } else if (gameState == 2) {
      gameState = 1;
    }
  }
}

void keyReleased() { //Better control for ship (multiple keys at once without confusing keys for others)
  //ship1 movement
  if (keyCode == LEFT) {
    player1.leftBool = false;
  }
  if (keyCode == RIGHT) {
    player1.rightBool = false;
  }
  if (keyCode == UP) {
    player1.thrustBool = false;
  }

  if (multiplayer) {
    //ship2 movement
    if (key == 'a') {
      player2.leftBool = false;
    }
    if (key == 'd') {
      player2.rightBool = false;
    }
    if (key == 'w') {
      player2.thrustBool = false;
    }
  }
}


void mousePressed() {



  //for testing purposes
  if (mouseButton == LEFT) {
    if (gameState == 0) {
      if () {
        
        
      }
    } else if (gameState == 1) {
      PVector mouse = new PVector(mouseX, mouseY, 0);
      new Asteroid(main, mouse);
    }
  }
}
