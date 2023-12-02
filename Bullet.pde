// Bullet class

class playerBullet {
  float x, y, dx, dy, angle;
  int r, speed;
  PShape playerBulletShape;
  
  playerBullet(float x, float y, float dx, float dy) {
    this.x = x;
    this.y = y;
    this.dx = dx;
    this.dy = dy;
    this.r = 5;
    this.speed = 10;
    this.angle = atan2(dy, dx) + PI/2;
    this.playerBulletShape = createPlayerBulletShape(angle);
  }

  void display() {
    fill(50, 20 * difficulty, 40 * difficulty);
    circle(x, y, r * 2);
    pushMatrix();
    translate(x, y); // Translate to the player's position
    rotate(angle);
    shape(playerBulletShape, 0, 0);
    popMatrix();
  }
  
  void move() {
    x += dx * speed;
    y += dy * speed;
  }
  
  boolean hitEnemy(Enemy e) {
    return Math.pow((e.x - x), 2) + Math.pow((e.y - y), 2) <= Math.pow((e.r + r), 2);
  }
}
