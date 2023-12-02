// Enemy class

class Enemy {
  float x, y, speed;
  int r, health, maxHealth;
  boolean healthPacket = Math.random() < 0.05;
  PShape enemyShape;

  Enemy(float x, float y, int r, float speed, int health) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.speed = speed;
    this.health = health;
    this.maxHealth = health;
    this.enemyShape = createEnemyShape(r);
  }

  void display() {
    pushMatrix();
    translate(x, y); // Translate to the enemy's position
    
    rotate((float) t / 1000);
    shape(enemyShape, 0, 0);
    popMatrix();
    
    stroke(150, 0, 0);
    if (healthPacket) {
      fill(150, 200, 255);
    } else {
      fill(255, 150, 100);
    }
    strokeWeight(5);
    circle(x, y, r * 2);
    displayHealthBar();
  }

  void move() {
    y += speed;
  }

  void shoot() {
    playerBullet bullet = new playerBullet(x, y + r, 0, 1);
    playerBullets.add(bullet);
  }

  void displayHealthBar() {
    fill(0, 255, 0);
    stroke(100, 0, 0);
    strokeWeight(1);
    rect(x - r, y + r + 10, 60 * health / maxHealth, 5);
  }
  
  boolean hitPlayer(Player p) {
    return Math.pow((p.x - x), 2) + Math.pow((p.y - y), 2) <= Math.pow((p.r + r), 2);
  }
}
