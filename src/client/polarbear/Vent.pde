// A simple Particle class

class Vent {
  PVector loc;
  PVector vel;

  float r;
  float timer = 60.0;
  color c;

  // Another constructor (the one we are using here)
 Vent(PVector l) {
    vel = new PVector(random(-1, 1), random(-2, 0), 0);
    loc = l.get();
    r = 10.0;
  }

  Vent(PVector l, color pColor) {
    vel = new PVector(random(-1.5, 1.5), random(-1.5, 1.5), 0);
    loc = l.get();
    r = 10.0;
    c = pColor;
  }

  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    loc.add(vel);
    timer -= 1.0;
  }

  // Method to display
  void render() {

    ellipseMode(CENTER);
    stroke(255, timer);
    fill(c, timer*2);
    ellipse(loc.x, loc.y, r, r);
  }

  // Is the particle still useful?
  boolean dead() {
    if (timer <= 0.0) {
      return true;
    } 
    else {
      return false;
    }
  }
}

