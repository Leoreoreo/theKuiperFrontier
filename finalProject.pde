import processing.sound.*;
// macros
Player player;
ArrayList<playerBullet> playerBullets;
ArrayList<Enemy> enemies;
boolean gameStarted, redFlash, end;
int difficulty, score, maxScore = 0, t, f;
PImage pic;
SoundFile bgm;

void setup() {
  size(800, 600);
  pic = loadImage("space.jpeg");
  bgm = new SoundFile(this, "bgm.mp3");
  bgm.loop();
  // Initialize
  playerBullets = new ArrayList<playerBullet>();
  enemies = new ArrayList<Enemy>();
  player = new Player(width/2, height - 50, 15, 5, 100);
  difficulty = 1;
  score = 0;
  gameStarted = false;
  redFlash = false;
  end = false;
  textFont(createFont("Orbitron-VariableFont_wght.ttf", 20));
}

void draw() {
  t = millis();
  f = frameCount;
  if (!gameStarted)
    displayStartPage();
  else if (end)
    displayEndPage();
  else {
    // Background
    tint(255, 100);
    image(pic, 0, 0, width, height);

    if (redFlash) {
      fill(abs(255 * sin(t / PI / 30)), 0, 0, 50 - player.health / 4);
      rect(0, 0, width, height);
    }
    
    // Display the player  
    player.move(0, 0);
    player.display();
    
    // Spwan enemies
    int spawn = 3 + 30 / difficulty;
    if (f % spawn == 0) {
      Enemy enemy = new Enemy(
        random(20, width - 20), -30,                            // x, y
        (int)random(10 + difficulty * 5, 20 + difficulty * 5),  // r
        random(0.3 * difficulty, 0.9 * difficulty),             // speed
        10 + difficulty * 2                                     // health
      );
      enemies.add(enemy);
    }
    
    // Update and display the enemies
    int tmpHealth = player.health;
    for (int i = enemies.size() - 1; i >= 0; i--) {
      Enemy enemy = enemies.get(i);
      enemy.move();
      enemy.display();
      // Hit player
      if (enemy.hitPlayer(player))
        if (--player.health <= 0) {
          end = true;
          bgm.stop();
        }
    }
    // Update background redFlash
    redFlash = tmpHealth > player.health;
    
    // Update and display the playerBullets
    for (int i = playerBullets.size() - 1; i >= 0; i--) {
      playerBullet bullet = playerBullets.get(i);
      bullet.move();
      bullet.display();
      // Remove bullets that are out of bounds
      if (bullet.x < 0 || bullet.y < 0 || bullet.x > width || bullet.y > height) {
        playerBullets.remove(i);
        continue;
      }
      // Hit enemies
      for (int j = enemies.size() - 1; j >= 0; j--) {
        Enemy enemy = enemies.get(j);
        if (bullet.hitEnemy(enemy)) {
          
          fill(255, 255, 155);
          circle(bullet.x, bullet.y, 15);
          
          if (--enemy.health <= 0) {
            score += enemy.r * 5;
            difficulty = (int) Math.max((Math.log(Math.max(score, 100) / 100) / Math.log(2)) + 1, 1);

            if (enemy.healthPacket) {
              player.health += 25;
              fill(50, 150, 255);
              textSize(30);
              text(25, enemy.x + 30, enemy.y + 30);
            }
            fill(255, 200, 150);
            textSize(30);
            text(enemy.r * 5, enemy.x, enemy.y);
            enemies.remove(j);
          }
          playerBullets.remove(i);
        }
      }
    }
    // Display information
    displayScore();
    displayHealth();
    displayMouse();
  }
}
