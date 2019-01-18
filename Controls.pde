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

  //shop controls
  if (gameState == 2) {
    if (keyCode == 49) { //'1' key
      powerUp = 1;
    } else if (keyCode == 50) { //'2' key
      println("2 has been pressed");
      powerUp = 2;
    } else if (keyCode == 51) { //'3' key
      powerUp = 3;
    } else if (keyCode == 52) { //'4' key
      powerUp = 4;
    } else {
      powerUp = 0;
    }
  }

  switch (powerUp) {
  case 0:
    if (key == ',') {
      player1.shoot();
    }
    if (key == 'q') {
      player2.shoot();
    }
    break;
  case 1:
    player1.stimShot();
    player2.stimShot();
    gameState = 1;
    break;
  case 2:
    player1.bigBullets();
    player2.bigBullets();
    gameState = 1;
    break;
  case 3:
    if (key == ',') {
      player1.tripleShoot();
    }
    if (key == 'q') {
      player2.tripleShoot();
    }
    gameState = 1;
    break;
  case 4:
    player1.shield();
    player2.shield();
    gameState = 1;
    break;
  }

  if (key == 'b') {
    if (gameState == 1) {
      gameState = 2;
    } else if (gameState == 2) {
      gameState = 1;
    }
  }

  //mute functionality
  if (key == 'm') {
    if (muted == false) {
      bulletSound.mute();
      muted = true;
    } else {
      bulletSound.unmute();
      muted = false;
    }
  }

  //cheat: ez money
  if (keyCode == 89) {
    currentMoney += 5;
    println("ez money");
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
    } else if (gameState == 1) {
      PVector mouse = new PVector(mouseX, mouseY, 0);
      new Asteroid(main, mouse);
    }
  }
}
