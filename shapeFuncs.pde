// PShapes

// Player
PShape loadSpaceshipShape() {
  
  PShape spaceship = createShape(GROUP);

  // main body
  PShape body = createShape();
  body.beginShape();
  // body.fill(200, 200, 255);
  body.fill(170, 170, 240);
  body.noStroke();
  float bodySize = 50;
  body.vertex(0, -bodySize / 2);                  // front
  body.vertex(-bodySize * 0.125, -bodySize * 0.3);
  body.vertex(-bodySize * 0.125, -bodySize * 0.15);
  body.vertex(-bodySize * 0.5, bodySize * 0.5);   // bottom left
  body.vertex(-bodySize * 0.2, bodySize * 0.5);
  body.vertex(-bodySize * 0.15, bodySize * 0.4);
  body.vertex(bodySize * 0.15, bodySize * 0.4);
  body.vertex(bodySize * 0.2, bodySize * 0.5);
  body.vertex(bodySize * 0.5, bodySize * 0.5);    // bottom right
  body.vertex(bodySize * 0.125, -bodySize * 0.15);  
  body.vertex(bodySize * 0.125, -bodySize * 0.3);

  body.endShape(CLOSE);

  // center
  PShape center = createShape();
  center.beginShape();
  
  // center.fill(170, 170, 240);
  center.fill(200, 200, 255);
  center.noStroke();
  float centerSize = 50;
  center.vertex(0, -centerSize / 2);                  // front
  center.vertex(-centerSize * 0.125, -centerSize * 0.3);
  center.vertex(-centerSize * 0.125, -centerSize * 0.15);
  center.vertex(-centerSize * 0.15, centerSize * 0.4);
  center.vertex(centerSize * 0.15, centerSize * 0.4);
  center.vertex(centerSize * 0.125, -centerSize * 0.15);  
  center.vertex(centerSize * 0.125, -centerSize * 0.3);

  center.endShape(CLOSE);
  
  // guns
  PShape guns = createShape();
  float gunLen = 10;
  guns.beginShape();
  guns.fill(100, 100, 255);
  guns.noStroke();
  
  guns.vertex(-bodySize / 4, gunLen);
  guns.vertex(-bodySize / 4, 0);
  guns.vertex(-bodySize / 4 - 5, 0);
  guns.vertex(-bodySize / 4 - 5, gunLen);
  
  guns.vertex(bodySize / 4, gunLen);
  guns.vertex(bodySize / 4, 0);
  guns.vertex(bodySize / 4 + 5, 0);
  guns.vertex(bodySize / 4 + 5, gunLen);
  guns.endShape(CLOSE);
  
  // cockpit
  PShape cockpit = createShape();
  cockpit.beginShape();
  cockpit.fill(100, 100, 255);
  cockpit.noStroke();
  
  cockpit.vertex(0, -bodySize / 2 + 5);
  cockpit.vertex(-5, -bodySize / 2 + 13);
  cockpit.vertex(0, -bodySize / 2 + 20);  
  cockpit.vertex(5, -bodySize / 2 + 13);
  cockpit.endShape(CLOSE);
  
  // engine fire
  PShape engineFire = createShape();
  engineFire.beginShape();
  engineFire.fill(255);
  engineFire.stroke(50, 150, 255);
  engineFire.strokeWeight(random(1, 6));
  engineFire.vertex(-5, bodySize / 2);
  engineFire.vertex(5, bodySize / 2);
  engineFire.vertex(0, bodySize);
  engineFire.endShape(CLOSE);
  
  // Add the sub-shapes
  spaceship.addChild(guns);
  spaceship.addChild(body);
  spaceship.addChild(center);
  spaceship.addChild(cockpit);
  if (keyPressed || !gameStarted) spaceship.addChild(engineFire);
  
  return spaceship;
}

// Enemy
PShape createEnemyShape(int r) {
  PShape enemy = createShape();
  float size = r / 3 * 8;
  
  enemy.beginShape();
  enemy.fill(150, 0, 0);
  enemy.stroke(100, 0, 0);
  enemy.strokeWeight(1);
  enemy.vertex(-size * 0.35, -size * 0.35);
  enemy.vertex(size * 0.35, -size * 0.35);
  enemy.vertex(size * 0.35, size * 0.35);
  enemy.vertex(-size * 0.35, size * 0.35);
  enemy.endShape(CLOSE);
  
  return enemy;
}

// PlayerBullet
PShape createPlayerBulletShape(float angle) {
  PShape playerBullet = createShape();
  float size = 25;
  
  pushMatrix();
  rotate(angle);
  playerBullet.beginShape();
  playerBullet.fill(255);
  playerBullet.stroke(50, 20 * difficulty, 40 * difficulty);
  playerBullet.strokeWeight(2);
  
  playerBullet.vertex(-5, 0);
  playerBullet.vertex(5, 0);
  playerBullet.vertex(0, size);
  playerBullet.endShape(CLOSE);
  popMatrix();
  
  return playerBullet;
}
