// A class to describe a group of Vents
// An ArrayList is used to manage the list of Vents 

class VentSystem {

  ArrayList vents;    // An arraylist for all the vents
  PVector origin;        // An origin point for where vents are born

  VentSystem() {
    vents = new ArrayList();
  }

  void run() {
    // Cycle through the ArrayList backwards b/c we are deleting
    for (int i = vents.size()-1; i >= 0; i--) {
      Vent p = (Vent) vents.get(i);
      p.run();
      if (p.dead()) {
        vents.remove(i);
      }
    }
  }

  void addVent() {
    vents.add(new Vent(origin));
  }
  
    void addVent(float x, float y) {
    vents.add(new Vent(new PVector(x,y)));
  }
  
 void addVent(float x, float y, color c) {
    vents.add(new Vent(new PVector(x,y), c));
  }

  void addVent(Vent p) {
    vents.add(p);
  }

  // A method to test if the vent system still has vents
  boolean dead() {
    if (vents.isEmpty()) {
      return true;
    } else {
      return false;
    }
  }

}

