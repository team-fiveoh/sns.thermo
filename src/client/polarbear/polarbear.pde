import processing.opengl.*;

HashMap agents = new HashMap();
/* @pjs preload="./data/choppedfloorplan.jpg"; */
PImage backgroundImg; 

void setup() {
  size(545, 700);
  frameRate(36);
  backgroundImg=loadImage("./data/choppedfloorplan.jpg");
  smooth();
  String[] readings = loadStrings("./data/readings.txt");
}

void draw() {
  setTemps(); 
  background(255); 
  fill(0, 0, 0);
  text("Polar Bear Habitat Suitability Monitoring Application", 0, 10);
  image(backgroundImg, 0, 50); 

  fill(0); 

  displayAgents();
}

void removeAgents(String[] agentReadings) {
  ArrayList presentIds = new ArrayList();
  for (int i=0; i < agentReadings.length; i++) {
    String[] pieces = split(agentReadings[i], ',');  
    presentIds.add(int(pieces[0]));
  }

  Iterator itr1 = agents.keySet().iterator();
  ArrayList toRemove = new ArrayList();
  while (itr1.hasNext ()) {

    Integer key = (Integer)itr1.next();
    if (!presentIds.contains(key)) {
      toRemove.add(key);
    }
  }

  Iterator itr2 = toRemove.iterator();
  while (itr2.hasNext ()) {
    agents.remove(itr2.next());
  }
}

void addAgent(String[] agentReadings) {
  String[] agentDetails = loadStrings("./data/agentdetails.txt");

  String agentId = agentReadings[0];

  for (int i= 0; i < agentDetails.length; i++) {
    String[] agentDetail = agentDetails[i].split(",");
    if (agentDetail[0].equals(agentId)) {
      int xCoord = int(agentDetail[1]);
      int yCoord = int(agentDetail[2]);
      agents.put(int(agentId), new Agent(xCoord, yCoord));
    }
  }
}

void setTemps() {
  String[] readings = loadStrings("./data/readings.txt");

  for (int i=0; i < readings.length; i++) {
    String[] pieces = split(readings[i], ',');
    int id = int(pieces[0]);

    float temp = float(pieces[1]);
    Agent agent = ((Agent)agents.get(id));
    if (agent != null) {
      agent.setTemp(temp);
    }    
    else {
      addAgent(pieces);
    }
  }
  removeAgents(readings);
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

    drawTempBox();
  }

  void drawTempBox() {
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

