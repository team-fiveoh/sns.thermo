ArrayList agents = new ArrayList();
/* @pjs preload="./data/choppedfloorplan.jpg"; */
PImage backgroundImg; 

void setup() {
  size(545, 700);
  frameRate(36);
  backgroundImg=loadImage("./data/choppedfloorplan.jpg");
  intialiseAgents();
  smooth();
}

void draw() {
    setTemps(); 
  background(255);    // Setting the background to white
text("Polar Bear Habitat Suitability Monitoring Application", 0, 10);
  image(backgroundImg, 0, 50);     

  fill(0); 

 
  displayAgents();

  
}

void intialiseAgents() {
  String[] readings = loadStrings("./data/readings.txt");
  //  println(readings);
  for (int i=0; i < readings.length; i++) {

    String[] pieces = split(readings[i], ',');  
 
    int id = int(pieces[0]);
    int xCoord;
    int yCoord;

    xCoord = workOutXCoord(id);
    yCoord= workOutYCoord(id);

    agents.add( new Agent(xCoord, yCoord));
  }
}

void checkAgentAdditions(String[] pAgents) {
  //  println("pAgents.length:" + pAgents.length);
  //  println("agents.length:" + agents.size());
  if (pAgents.length > agents.size()) {
    println("Adding agent");
    addAgent(pAgents);
  }
  else if (pAgents.length < agents.size()) {
    // remove agent
  }
}


void addAgent(String[] pAgents) {
  String[] pieces = split(pAgents[pAgents.length-1], ',');  
  int id = int(pieces[0]);

  int xCoord = workOutXCoord(id);
  int yCoord =workOutYCoord(id);

  agents.add( new Agent(xCoord, yCoord));
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
  for (int i=0; i < agents.size(); i++) {
    ((Agent)agents.get(i)).display();
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
    //    ellipseMode(CENTER);
    //    ellipse(xpos, ypos, 20, 20);
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


    //    println(red +":"+"0:"+blue);
    c = color(red, 0, blue);
  }
}

