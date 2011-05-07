HashMap agents = new HashMap();
/* @pjs preload="./data/choppedfloorplan.jpg"; */
PImage backgroundImg; 

void setup() {
  size(545, 700);
  frameRate(36);
  backgroundImg=loadImage("./data/choppedfloorplan.jpg");
  //  intialiseAgents();
  smooth();
}

void draw() {
//  println("draw() 1");
  setTemps(); 
//  println("draw() 2");
  background(255);    // Setting the background to white
//  println("draw() 3");
  text("Polar Bear Habitat Suitability Monitoring Application", 0, 10);
//  println("draw() 4");
  image(backgroundImg, 0, 50);     
//println("draw() 5");
  fill(0); 
//println("draw() 6");

  displayAgents();
//  println("draw() finish");
}

void checkAgentAdditions(String[] pAgents) {
    addAgents(pAgents);
    removeAgents(pAgents);
}

void removeAgents(String[] pAgents) {
  ArrayList presentIds = new ArrayList();
  for (int i=0; i < pAgents.length; i++) {
    String[] pieces = split(pAgents[i], ',');  
    presentIds.add(int(pieces[0]));
  }


  Iterator i = agents.keySet().iterator();

  while (i.hasNext ()) {
    if (!presentIds.contains(i.next())) {
      println("Removing agent id "+ i);
      i.remove();
    }
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
      println("Adding agent id "+ id);
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
  println("readings.length "+ readings.length);
  for (int i=0; i < readings.length; i++) {
        println("id" + i);
//println("1");
    String[] pieces = split(readings[i], ',');  
//println("2");
    int id = int(pieces[0]);
//    println("3");

//    println("4");
    float temp = float(pieces[1]);
//println("5");
    ( (Agent)agents.get(id)).setTemp(temp);
//    println("6");
  }
}

void displayAgents() {
//  println("displayAgents");
  Iterator i = agents.entrySet().iterator();
println("i.hasNext () " + i.hasNext());
  while (i.hasNext ()) {
//    println("displayAgents()");
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

