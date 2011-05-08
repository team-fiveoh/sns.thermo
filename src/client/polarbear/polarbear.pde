import processing.opengl.*;

HashMap agents = new HashMap();
/* @pjs preload="./data/choppedfloorplan.jpg"; */
PImage backgroundImg; 

void setup() {
  size(545, 700);
  frameRate(36);
  backgroundImg=loadImage("./data/choppedfloorplan.jpg");
  smooth();
}

void draw() {
  setTemps(); 
  background(255); 
  text("Polar Bear Habitat Suitability Monitoring Application", 0, 10);
  image(backgroundImg, 0, 50); 
  
  fill(0); 

  displayAgents();
  
}

void checkAgentAdditions(String[] pAgents) {

  addAgents(pAgents); 
  removeAgents(pAgents); 
}
void removeAgents(String[] pAgents) {
  ArrayList presentIds = new ArrayList();println("removeAgents1");
  for (int i=0; i < pAgents.length; i++) {
    String[] pieces = split(pAgents[i], ',');  println("removeAgents2");
    presentIds.add(int(pieces[0]));println("removeAgents3");
  }

  Iterator itr1 = agents.keySet().iterator();println("removeAgents4");
  ArrayList toRemove = new ArrayList();println("removeAgents5");
  while (itr1.hasNext ()) {println("removeAgents6.1");

    Integer key = (Integer)itr1.next();println("removeAgents6");
    if (!presentIds.contains(key)) {
      toRemove.add(key);println("removeAgents7");
    }
  }

  Iterator itr2 = toRemove.iterator();println("removeAgents8");
  while (itr2.hasNext ()) {
    agents.remove(itr2.next());println("removeAgents9");
  }
}

void addAgents(String[] pAgents) {
  for (int i=0; i < pAgents.length; i++) {
    String[] pieces = split(pAgents[i], ',');  

    int id = int(pieces[0]);
    if (agents.get(id) == null) {

      int xCoord;
      int yCoord;
      xCoord = workOutXCoord(id);
      yCoord= workOutYCoord(id);
      agents.put(id, new Agent(xCoord, yCoord));
    }
  }
}

int workOutXCoord(int id) {
  if (id == 0) {
    return 175;
  }
  else if (id == 1) {
    return 175;
  }
  else if (id == 2) {
    return 175;
  }
  else if (id == 3) {
    return 400;
  }
  else if (id == 4) {
    return 270;
  }

  return 500;
}

int workOutYCoord(int id) {
  if (id == 0) {
    return 100;
  }
  else if (id == 1) {
    return 300;
  }
  else if (id == 2) {
    return 600;
  }
  else if (id == 3) {
    return 300;
  }
  else if (id == 4) {
    return 480;
  }

  return 500;
}


void setTemps() {
  String[] readings = loadStrings("./data/readings.txt");
  checkAgentAdditions(readings);
  for (int i=0; i < readings.length; i++) {
    String[] pieces = split(readings[i], ',');
    int id = int(pieces[0]);

    float temp = float(pieces[1]);
    ( (Agent)agents.get(id)).setTemp(temp);
  }
}

void displayAgents() {
  Iterator i = agents.entrySet().iterator();
  while (i.hasNext ()) {
    Map.Entry me = (Map.Entry)i.next();
    ((Agent)me.getValue()).display();
  }
}


class Agent {
  ParticleSystem ps;
  float temp;
  color c;
  float xpos;
  float ypos;

  Agent(float pxpos, float pypos) {
    c = color(31, 8, 255);
    xpos=pxpos;
    ypos=pypos;
    ps = new ParticleSystem(1, new PVector(width/2, height/2, 0));
  }

  void setTemp(float pTemp) {
    temp = pTemp;
  }

  void display() {
    stroke(0);
    ps.run();
    workOutColor();
    ps.addParticle(xpos, ypos, c);

    fill(0, 0, 0);
    rect(xpos+42, ypos-27, 56, 34);
    fill(255, 255, 255);
    rect(xpos+45, ypos-25, 50, 30);
    fill(c);

    text(temp + "°C", xpos+50, ypos);
  }

  void workOutColor() {
    float factor = temp - 18.0;
    factor = factor * 45.0;
    int blue = int(255.0-factor);
    int red = int(factor);
    if (blue < 0) {
      blue = 0;
    }    
    else if (blue > 255) {
      blue = 255;
    }
    if (red < 0) {
      red = 0;
    }    
    else if (red > 255) {
      red = 255;
    }
    c = color(red, 0, blue);
  }
}

