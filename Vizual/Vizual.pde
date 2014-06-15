import ddf.minim.*;
Minim minim;
AudioInput in;
AudioPlayer player;
AudioOutput out;

boolean init = false;
int prevSec;
int millisDiff;
boolean play = false;
float clkFill = 64;
boolean selectingSong = false;
boolean songSelected = false;
float afterGlow = 255;
float leftPeakAmp = 0;
float leftSumAmp = 0;
float leftAvgAmp = 0;
float rightPeakAmp = 0;
float rightSumAmp = 0;
float rightAvgAmp = 0;

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  frame.setResizable(true); 
  minim = new Minim(this);
  in = minim.getLineIn();
  out = minim.getLineOut();
  prevSec = second();
}

void draw() {
  
  //create afterglow control
  noStroke();
  fill(0);
  rect(0,0,width,height/2 - 200);
  rect(0,height/2 + 200,width,height/2 - 200);
  fill(0,0,0,afterGlow);
  rect(0,height/2 - 210,width,420);
  fill(125,249,255,127.5);
  strokeCap(ROUND);
  strokeWeight(6);
  stroke(125, 249, 255, 127.5);
  line(width - 480, 20, width - 480, 120);
  stroke(125, 249, 255);
  strokeWeight(8);
  if (mouseX >= width - 495 && mouseX <= width - 465 && mouseY >= 25 && mouseY <= 115 && mousePressed == true) {
    afterGlow = map(mouseY, 25, 115, 0, 255);
  }
  if (mouseX >= width - 495 && mouseX <= width - 465 && mouseY >= 20 && mouseY < 25 && mousePressed == true) {
    afterGlow = 0;
  }
  if (mouseX >= width - 495 && mouseX <= width - 465 && mouseY > 115 && mouseY <= 120 && mousePressed == true) {
    afterGlow = 255;
  }
  line(width - 490, map(afterGlow, 0, 255, 20, 120), width - 470, map(afterGlow, 0, 255, 20, 120));
  
  //create clock transparency control
  strokeCap(ROUND);
  strokeWeight(6);
  stroke(125, 249, 255, 127.5);
  line(width - 445, 20, width - 445, 120);
  stroke(125, 249, 255);
  strokeWeight(8);
  if (mouseX >= width - 460 && mouseX <= width - 430 && mouseY >= 25 && mouseY <= 115 && mousePressed == true) {
    clkFill = map(mouseY, 115, 25, 0, 255);
  }
  if (mouseX >= width - 460 && mouseX <= width - 430 && mouseY >= 20 && mouseY < 25 && mousePressed == true) {
    clkFill = 255;
  }
  if (mouseX >= width - 460 && mouseX <= width - 430 && mouseY > 115 && mouseY <= 120 && mousePressed == true) {
    clkFill = 0;
  }
  line(width - 455, map(clkFill, 255, 0, 20, 120), width - 435, map(clkFill, 255, 0, 20, 120));
  
  //Put milliseconds in real time
  if (init == true && second() != prevSec) {
    millisDiff = millis();
    prevSec = second();
  }
  if (init == false && second() != prevSec) {
    millisDiff = millis();
    prevSec = second();
    init = true;
  } else {
    //Draw the graphic clock
    if (mouseX >= width - 420 && mouseY <= 120 && mousePressed == false) {
      fill(125,249,255);
      noStroke();
      textSize(10);
      textAlign(CENTER,BOTTOM);
      text("second",width-60,20);
      rect(width - 100, 20, 80, (100 * (millis()-millisDiff)/1000)%100);
      text("minute",width-160,20);
      rect(width - 200, 20, 80, (100 * second()/60)%100);
      text("hour",width-260,20);
      rect(width - 300, 20, 80, (100 * minute()/60)%100);
      text("day",width-360,20);
      rect(width - 400, 20, 80, (100 * hour()/24)%100);
      stroke(125,249,255);
      strokeWeight(1);
      line(width - 420, 20, width - 420, 120);//verticle line
      line(width - 420, 20, width - 405, 20);//top line
      line(width - 420, 120, width - 405, 120);// bottom line
      line(width - 420, 70, width - 410, 70);// 1/2 line
      line(width - 420, 45, width - 413, 45);// 1/4 line
      line(width - 420, 95, width - 413, 95);// 3/4 line
      line(width - 420, 32.5, width - 415, 32.5);// 1/8 line
      line(width - 420, 57.5, width - 415, 57.5);// 3/8 line
      line(width - 420, 82.5, width - 415, 82.5);// 5/8 line
      line(width - 420, 107.5, width - 415, 107.5);// 7/8 line
    } else if (mouseX >= width - 420 && mouseY <= 120 && mousePressed == true) {
      fill(125,249,255);
      noStroke();
      textSize(40);
      textAlign(CENTER,CENTER);
      text(str(hour()) + ":" + str(minute()) + ":" + str(second()), width - 210, 60);
    } else {
      fill(125,249,255,clkFill);
      noStroke();
      rect(width - 100, 20, 80, (100 * (millis()-millisDiff)/1000)%100);
      rect(width - 200, 20, 80, (100 * second()/60)%100);
      rect(width - 300, 20, 80, (100 * minute()/60)%100);
      rect(width - 400, 20, 80, (100 * hour()/24)%100);
      stroke(125,249,255,clkFill);
      strokeWeight(1);
      line(width - 420, 20, width - 420, 120);//verticle line
      line(width - 420, 20, width - 405, 20);//top line
      line(width - 420, 120, width - 405, 120);// bottom line
      line(width - 420, 70, width - 410, 70);// 1/2 line
      line(width - 420, 45, width - 413, 45);// 1/4 line
      line(width - 420, 95, width - 413, 95);// 3/4 line
    }
  }
  
  //draw the play/pause bar
  if (dist(width/2, height/2, mouseX, mouseY) <= 40 && mousePressed == true || keyPressed == true && key == ' ' && songSelected == true) { 
    fill(125, 249, 255);
  } else {
    fill(62.5, 124.5, 127.5);
  }
  noStroke();
  rect(0, height/2 - 5, width/2 - 30, 10);
  rect(width/2 + 30, height/2 - 5, width/2 - 30, 10);
  if (dist(width/2, height/2, mouseX, mouseY) <= 40 || keyPressed == true && key == ' ' && songSelected == true) { 
    fill(125, 249, 255);
  } else {
    fill(62.5, 124.5, 127.5);
  }
  ellipse(width/2, height/2, 80, 80);
  fill(0);
  ellipse(width/2, height/2, 60, 60);
  fill(125, 249, 255);
  if (play == false || songSelected == false) {
    triangle(width/2 + cos(radians(0))*20, height/2 + sin(radians(0))*20, width/2 + cos(radians(120))*20, height/2 + sin(radians(120))*20, width/2 + cos(radians(240))*20, height/2 + sin(radians(240))*20);
  }
  if (play == true && songSelected == true) {
    rect(width/2 - 15, height/2 - 15, 11, 30);
    rect(width/2 + 4, height/2 - 15, 11, 30);
  }
  
  //Choose song
  if (selectingSong == false && songSelected == false) {
    selectingSong = true;
    selectInput("Load a new song:", "addNew");
  }
  
  //Draw the audio visualizer
  leftSumAmp = 0;
  rightSumAmp = 0;
  leftPeakAmp = 0;
  rightPeakAmp = 0;
  if (play == false) {
    for(int i = 0; i < in.bufferSize() - 1; i++) {
      float x1 = map( i, 0, in.bufferSize(), 0, width);
      float x2 = map( i+1, 0, in.bufferSize(), 0, width);
      stroke(125,249,255);
      strokeWeight(2);
      line(x1, height/2 - 125 - in.left.get(i)*75, x2, height/2 - 125 - in.left.get(i+1)*75);
      line(x1, height/2 + 125 + in.right.get(i)*75, x2, height/2 + 125 + in.right.get(i+1)*75);
      leftSumAmp += in.left.get(i);
      rightSumAmp += in.right.get(i);
      if (abs(in.left.get(i)) > leftPeakAmp) {
        leftPeakAmp = abs(in.left.get(i));
      }
      if (abs(in.right.get(i)) > rightPeakAmp) {
        rightPeakAmp = abs(in.right.get(i));
      }
    }
    leftAvgAmp = leftSumAmp/(in.bufferSize() - 1);
    rightAvgAmp = rightSumAmp/(in.bufferSize() - 1);
  } else if (play == true) {
    for(int i = 0; i < player.bufferSize() - 1; i++) {
      float x1 = map( i, 0, player.bufferSize(), 0, width);
      float x2 = map( i+1, 0, player.bufferSize(), 0, width);
      stroke(125,249,255);
      strokeWeight(2);
      line(x1, height/2 - 125 - player.left.get(i)*75, x2, height/2 - 125 - player.left.get(i+1)*75 );
      line(x1, height/2 + 125 + player.right.get(i)*75, x2, height/2 + 125 + player.right.get(i+1)*75 );
      leftSumAmp += player.left.get(i);
      rightSumAmp += player.right.get(i);
      if (abs(player.left.get(i)) > leftPeakAmp) {
        leftPeakAmp = abs(player.left.get(i));
      }
      if (abs(player.right.get(i)) > rightPeakAmp) {
        rightPeakAmp = abs(player.right.get(i));
      }
    }
    if (player.isPlaying() == false) {
      play = false;
      player.rewind();
    }
    leftAvgAmp = leftSumAmp/(player.bufferSize() - 1);
    rightAvgAmp = rightSumAmp/(player.bufferSize() - 1);
  }
  
  //draw amplitude indicators
  noStroke();
  fill(125, 249, 255, 127.5);
  rect(width - 650, 20, 20, 100);
  rect(width - 610, 20, 20, 100);
  rect(width - 570, 20, 20, 100);
  rect(width - 530, 20, 20, 100);
  fill(125, 249, 255);
  rect(width - 650, map(leftPeakAmp, 0, 1, 115, 25) - 5, 20, 10);
  rect(width - 610, map(leftAvgAmp, -.5, .5, 115, 25) - 5, 20, 10);
  rect(width - 570, map(rightPeakAmp, 0, 1, 115, 25) - 5, 20, 10);
  rect(width - 530, map(rightAvgAmp, -.5, .5, 115, 25) - 5, 20, 10);
  
  //draw progress meter
  if(songSelected == true) {
    if (mouseX >= 25 && mouseX <= width - 25 && mouseY >= height - 100 && mouseY <= height - 70) {
      strokeWeight(15);
    } else {
      strokeWeight(6);
    }
    stroke(125, 249, 255, 127.5);
    line(50, height - 85, width - 50, height - 85);
    fill(125, 249, 255);
    noStroke();
    if (mouseX >= 25 && mouseX <= width - 25 && mouseY >= height - 100 && mouseY <= height - 70) {
      ellipse(map(player.position(), 0, player.length(), 50, width - 50), height - 85, 6, 6 );
    } else {
      ellipse(map(player.position(), 0, player.length(), 50, width - 50), height - 85, 3, 3 );
    }
    noStroke();
    fill(125, 249, 255, 127.5);
    textAlign(CENTER,TOP);
    textSize(10);
    if (mouseX >= 25 && mouseX <= width - 25 && mouseY >= height - 100 && mouseY <= height - 70) {
      if (floor(player.position()/1000)%60 < 10) {
        text(str(floor(player.position()/60000)%60) + ":0" + str(floor(player.position()/1000)%60), 50, height - 73);
      } else {
        text(str(floor(player.position()/60000)%60) + ":" + str(floor(player.position()/1000)%60), 50, height - 73);
      }
      if (floor(player.length()/1000)%60 < 10) {
        text(str(floor(player.length()/60000)%60) + ":0" + str(floor(player.length()/1000)%60), width - 50, height - 73);
      } else {
        text(str(floor(player.length()/60000)%60) + ":" + str(floor(player.length()/1000)%60), width - 50, height - 73);
      }
    } else {
      if (floor(player.position()/1000)%60 < 10) {
        text(str(floor(player.position()/60000)%60) + ":0" + str(floor(player.position()/1000)%60), 50, height - 80);
      } else {
        text(str(floor(player.position()/60000)%60) + ":" + str(floor(player.position()/1000)%60), 50, height - 80);
      }
      if (floor(player.length()/1000)%60 < 10) {
        text(str(floor(player.length()/60000)%60) + ":0" + str(floor(player.length()/1000)%60), width - 50, height - 80);
      } else {
        text(str(floor(player.length()/60000)%60) + ":" + str(floor(player.length()/1000)%60), width - 50, height - 80);
      }
    }
    if (mouseX >= 50 && mouseX <= width - 50 && mouseY >= height - 100 && mouseY <= height - 70) {
      textAlign(CENTER,BOTTOM);
      textSize(11);
      if (floor(map(mouseX, 50, width - 50, 0, player.length())/1000)%60 < 10) {
        text(str(floor(map(mouseX, 50, width - 50, 0, player.length())/60000)%60) + ":0" + str(floor(map(mouseX, 50, width - 50, 0, player.length())/1000)%60), mouseX, height - 100);
      } else {
        text(str(floor(map(mouseX, 50, width - 50, 0, player.length())/60000)%60) + ":" + str(floor(map(mouseX, 50, width - 50, 0, player.length())/1000)%60), mouseX, height - 100);
      }
    }
  }
  
  //draw pressure wave visualizer
  noFill();
  strokeWeight(3);
  stroke(125,249,255);
  ellipse(width - 720, 70, 90, 90);
  ellipse(width - 840, 70, 90, 90);
  line(width - 840, 25, width - 720, 25);
  line(width - 840, 115, width - 720, 115);
  if (play == true) {
    for(int i = 100; i > 0; i-=2) {
      strokeWeight(2);
      noFill();
      stroke(map(player.left.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,125),map(player.left.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,249),map(player.left.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,225), map(i,100,0,0,255));
      ellipse(width - 720,70,i,i);
      stroke(map(player.right.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,125),map(player.right.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,249),map(player.right.get(floor(map(i,100,0,0,player.bufferSize()))),-1,1,0,225), map(i,100,0,0,255));
      ellipse(width - 840,70,i,i);
    }
  } else if (play == false) {
    for(int i = 100; i > 0; i-=2) {
      strokeWeight(2);
      noFill();
      stroke(map(in.left.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,125),map(in.left.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,249),map(in.left.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,225), map(i,100,0,0,255));
      ellipse(width - 720,70,i,i);
      stroke(map(in.right.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,125),map(in.right.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,249),map(in.right.get(floor(map(i,100,0,0,in.bufferSize()))),-1,1,0,225), map(i,100,0,0,255));
      ellipse(width - 840,70,i,i);
    }
  }
  
  //create load song button
    noStroke();
  if (mouseX >= 40 && mouseX <= 120 && mouseY >=0 && mouseY <= 80) {
    fill(125, 249, 255);
  } else {
    fill(125, 249, 255, 127.5);
  }
  rect(40, 0, 80, 80);
  fill(0);
  textSize(80);
  textAlign(CENTER,CENTER);
  text("+", 80, 25);
}

void mouseClicked() {
  if (play == false && dist(width/2, height/2, mouseX, mouseY) <= 40) {
    play = true;
    player.play();
  } else if (play == true && dist(width/2, height/2, mouseX, mouseY) <= 40) {
    play = false;
    player.pause();
  }
  if (mouseX >= 50 && mouseX <= width - 50 && mouseY >= height - 100 && mouseY <= height - 70) {
    player.skip(floor(map(mouseX, 50, width - 50, 0, player.length()) - player.position()));
  }
  if (mouseX >= 40 && mouseX <= 120 && mouseY >=0 && mouseY <= 80) {
    play = false;
    player.pause();
    selectingSong = true;
    selectInput("Load a new song:", "addNew");
  }
}

void keyTyped() {
  if (key == ' '){
    if (play == false) {
      play = true;
      player.play();
    } else if (play == true) {
      play = false;
      player.pause();
    }
  }
  if (key == 'm'){
    println(clkFill);
  }
}

void keyReleased() {
  if (key == CODED) {
    if (keyCode == RIGHT && player.position() + 5000 < player.length()) {
      player.skip(5000);
    } else if (keyCode == LEFT && player.position() - 5000 > 0) {
      player.skip(-5000);
    } else if (keyCode == RIGHT || keyCode == LEFT) {
      player.rewind();
    }
  }
}

void addNew(File selection) {
   if (selection == null) {
    println("Window was closed or the user hit cancel.");
    selectingSong = false;
  } else {
    println("User selected " + selection.getAbsolutePath());
    player = minim.loadFile(selection.getAbsolutePath());
    selectingSong = false;
    songSelected = true;
  }
}
