// Player class

class Player {
  float x, y;
  float acceleration = 1.0f, friction = 0.02f;
  int r, speed, health;
  float velocityX = 0, velocityY = 0;
  float angle = atan2(mouseY - y, mouseX - x) + PI/2;
  PShape spaceship;

  Player(float x, float y, int r, int speed, int health) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.speed = speed;
    this.health = health;
  }

  void display() {
    
    pushMatrix();
    translate(x, y); // Translate to the player's position
    
    // Rotate the spaceship to face the mouse direction
    angle = atan2(mouseY - y, mouseX - x) + PI/2;
    rotate(angle);
    
    // Draw the spaceship shape
    spaceship = loadSpaceshipShape();
    shape(spaceship, 0, 0);
    if (health > 100) {
      stroke(150, 200, 255);
      strokeWeight(2);
      fill(255, 255, 255, 100);
      circle(0, 0, r * 4);
    }
    popMatrix();
    

  }

  void move(float dx, float dy) {
    // Update the velocity based on acceleration and direction
    velocityX += dx * acceleration;
    velocityY += dy * acceleration;
    
    // Limit the velocity to the maximum speed
    velocityX = constrain(velocityX, -speed, speed);
    velocityY = constrain(velocityY, -speed, speed);
    
    // Apply friction to gradually reduce velocity
    velocityX *= (1 - friction);
    velocityY *= (1 - friction);
    
    // Update the player's position based on velocity
    x += velocityX;
    y += velocityY;
    
    if (x < r) {
      x = r;
      velocityX = 0;
    } else if (x > width - r) {
      x = width - r;
      velocityX = 0;
    }
    if (y < r) {
      y = r;
      velocityY = 0;
    } else if (y > height - r) {
      y = height - r;
      velocityY = 0;
    }
  }

  void shoot(float targetX, float targetY) {
    // Calculate the direction from player to mouse
    float dx = targetX - x;
    float dy = targetY - y;
  
    // Normalize the direction vector
    float magnitude = sqrt(dx * dx + dy * dy);
    dx /= magnitude;
    dy /= magnitude;
  
    // Calculate the positions for each gun
    float gunX1 = x + r * cos(angle);
    float gunY1 = y + r * sin(angle);
  
    float gunX2 = x + r * cos(angle + PI);
    float gunY2 = y + r * sin(angle + PI);
  
    // Create bullets for each gun with the normalized direction
    playerBullet bullet1 = new playerBullet(gunX1, gunY1, dx, dy);
    playerBullet bullet2 = new playerBullet(gunX2, gunY2, dx, dy);
  
    // Add the bullets to the bullets list
    playerBullets.add(bullet1);
    playerBullets.add(bullet2);
  }
}
