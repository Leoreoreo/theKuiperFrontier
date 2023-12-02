// Functions

void mousePressed() {
  switch (mouseButton) {
    case LEFT:
      if (gameStarted) player.shoot(mouseX, mouseY);
      break;
    default:
      break;
  }
}

void keyPressed() {
  switch (key) {
    case 'w':
      player.move(0, -1);
      break;
    case 'a':
      player.move(-1, 0);
      break;
    case 's':
      player.move(0, 1);
      break;
    case 'd':
      player.move(1, 0);
      break;
    case ENTER:
      gameStarted = true;
      if (end) setup();
      break;
    default:
      break;
  }
}

void displayMouse() {
  fill(255);
  stroke(50, 150, 255);
  strokeWeight(3);
  if (mousePressed) circle(mouseX, mouseY, 20);
  else circle(mouseX, mouseY, 10);
}

void displayStartPage() {
  image(pic, 0, 0, width, height);
  fill(100, 200, 255);
  textSize(60);
  textAlign(CENTER);
  text("The Kuiper Frontier", width/2 + 5, height/2 - 25);  
  fill(255);
  text("The Kuiper Frontier", width/2, height/2 - 30);
  textSize(25);
  text("Best Score:", width/2, height/2 + 40);
  textSize(25 + sin(t / PI / 50));
  text("Press ENTER to Start", width/2, height/2 + 80);
  textSize(15);
  textAlign(LEFT);
  text("Press WASD to move around.", width/6, height*0.9);
  text("Left click to shoot in the mouse direction.", width/6, height*0.94);
  fill(255, 200, 150);
  textAlign(CENTER);
  textSize(30 + 3 * sin(t / PI / 50));
  text(maxScore, width/2 + 150, height/2 + 43);
  
  PShape spaceship = loadSpaceshipShape();
  shape(spaceship, width*0.1, height*0.9);
}

void displayScore() {
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("Score :   " + score, 30, 30);
}

void displayHealth() {
  int h = player.health;
  textAlign(LEFT);
  fill(255);
  textSize(20);
  text("HP :   " + h, 30, 60);
  fill(255);
  stroke(255 - h * 2, abs(10 - h * 2), 10 + h * 2);
  strokeWeight(5);
  rect(30, 70, 1.5 * h, 10);
}

void displayEndPage() {
  image(pic, 0, 0, width, height);
  fill(255, 0, 0);
  textSize(80);
  textAlign(CENTER);
  text("Game Over!", width/2 + 5, height/2 - 5);
  fill(255, 150, 100);
  text("Game Over!", width/2, height/2);
  textSize(30);
  textAlign(LEFT);
  text("Score :", width*0.7 - 150, height*0.7 + 50);
  maxScore = Math.max(maxScore, score);
  text("Best Score :", width*0.7 - 150, height*0.7 + 100); 
  if (maxScore == score) {
    textSize(30 + 2 * sin(t / PI / 50));
    fill(255, 200, 100); 
  } else {
    textSize(30);
    fill(255);
  }
  textAlign(CENTER);
  text(score, width*0.7 + 150, height*0.7 + 48);
  text(maxScore, width*0.7 + 150, height*0.7 + 98);
  textSize(20 + sin(t / PI / 50)); 
  fill(255, 200, 100); 
  text("Press ENTER to Continue.", width*0.7, height*0.7 + 128);
}
