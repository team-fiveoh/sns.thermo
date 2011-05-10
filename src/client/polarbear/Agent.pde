class Agent {
  VentSystem ps;
  float temp;
  color c;
  float xpos;
  float ypos;

  Agent(float pxpos, float pypos) {
    c = color(225, 225, 255);
    xpos=pxpos;
    ypos=pypos;
    ps = new VentSystem();
  }

  void setTemp(float pTemp) {
    temp = pTemp;
  }

  void display() {
    stroke(0);
    ps.run();
    workOutColor();
    ps.addVent(xpos, ypos, c);

    drawTempBox();
  }

  void drawTempBox() {
    fill(0, 0, 0);
//    rect(xpos+42, ypos-27, 56, 34);
//    fill(255, 255, 255);
//    rect(xpos+45, ypos-25, 50, 30);


roundRect(xpos+43, ypos-20, 50f, 30f);
fill(255, 255, 200);
roundRect(xpos+45, ypos-18, 46f, 26f);

    fill(c);
    String tTemp;
    if (temp > 9.99) {
      tTemp = nf(temp, 2, 1);
    }
    else {
      tTemp = nf(temp, 1, 1);
    }

    text(tTemp + "°C", xpos+48, ypos);
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
  
  void roundRect(float x, float y, float w, float h) {
    float corner = w/10.0;
    float midDisp = w/20.0;

    beginShape();  
    curveVertex(x+corner, y);
    curveVertex(x+w-corner, y);
    curveVertex(x+w+midDisp, y+h/2.0);
    curveVertex(x+w-corner, y+h);
    curveVertex(x+corner, y+h);
    curveVertex(x-midDisp, y+h/2.0);

    curveVertex(x+corner, y);
    curveVertex(x+w-corner, y);
    curveVertex(x+w+midDisp, y+h/2.0);
    endShape();
  }
}

