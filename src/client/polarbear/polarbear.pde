import processing.opengl.*;

HashMap agents = new HashMap();
/* @pjs preload="./data/choppedfloorplan.jpg"; */
PImage backgroundImg; 

void setup() {
  size(545, 655);
  frameRate(36);
  backgroundImg = loadImage("./data/choppedfloorplan.jpg");
  smooth();
  String[] readings = loadStrings("./data/readings.txt");
}

void draw() {
  setTemps(); 
  background(255); 
  fill(0, 0, 0);
  image(backgroundImg, 0, 0); 

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

  for (int i = 0; i < agentDetails.length; i++) {
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
  Iterator itr3 = agents.entrySet().iterator();
  while (itr3.hasNext ()) {
    Map.Entry me = (Map.Entry)itr3.next();
    Agent agent = (Agent)me.getValue();
    agent.display();
  }
}




