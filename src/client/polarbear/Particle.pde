// A simple Particle class

class Particle {
  PVector loc;
  PVector vel;
  PVector acc;
  float r;
  float timer = 60.0;
  color c;

  // Another constructor (the one we are using here)
 Particle(PVector l) {
    acc = new PVector(0, 0.05, 0);
    vel = new PVector(random(-1, 1), random(-2, 0), 0);
    loc = l.get();
    r = 10.0;
// timer = 100.0;
  }

  Particle(PVector l, color pColor) {
    acc = new PVector(0, 0.05, 0);
    vel = new PVector(random(-1, 1), random(-2, 0), 0);
    loc = l.get();
    r = 10.0;
// timer = 100.0;
    c = pColor;
  }

  void run() {
    update();
    render();
  }

  // Method to update location
  void update() {
    vel.add(acc);
    loc.add(vel);
    timer -= 1.0;
  }

  // Method to display
  void render() {
//    color c = color(197, 135, 352);

    ellipseMode(CENTER);
    stroke(255, timer);
    fill(c, timer*2);
    ellipse(loc.x, loc.y, r, r);
    displayVector(vel, loc.x, loc.y, 10);
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

  void displayVector(PVector v, float x, float y, float scayl) {
    pushMatrix();
    float arrowsize = 4;
    // Translate to location to render vector
    translate(x, y);
    stroke(255);
    // Call vector heading function to get direction (note that pointing up is a heading of 0) and rotate
    rotate(v.heading2D());
    // Calculate length of vector & scale it to be bigger or smaller if necessary
    float len = v.mag()*scayl;
    // Draw three lines to make an arrow (draw pointing up since we've rotate to the proper direction)
    //    line(0,0,len,0);
    //    line(len,0,len-arrowsize,+arrowsize/2);
    //    line(len,0,len-arrowsize,-arrowsize/2);
    popMatrix();
  }
}

