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

void setup() {
  size(displayWidth, displayHeight);
  background(0);
  frame.setResizable(true); 
  minim = new Minim(this);
  in = minim.getLineIn();
  player = minim.loadFile("Konec - Aztek_audio.mp3");
  out = minim.getLineOut();
  prevSec = second();
}

void draw() {
  background(0);
  
  //create clock transparency control
  strokeWeight(6);
  stroke(125,249,255,127.5);
  line(width - 430, 20, width - 430, 120); 
  noStroke();
  fill(125, 249, 255);
  ellipse(width - 430, map(clkFill, 255, 0, 20, 120), 6, 6);
  if (mouseX >= width - 440 && mouseX <= width - 420 && mouseY >= 20 && mouseY <= 120 && mousePressed == true){
    clkFill = map(mouseY, 120, 20, 0, 255);
  }
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
  if (dist(width/2, height/2, mouseX, mouseY) <= 40 && mousePressed == true || keyPressed == true && key == ' ') { 
    fill(125, 249, 255);
  } else {
    fill(62.5, 124.5, 127.5);
  }
  noStroke();
  rect(0, height/2 - 5, width/2 - 30, 10);
  rect(width/2 + 30, height/2 - 5, width/2 - 30, 10);
  if (dist(width/2, height/2, mouseX, mouseY) <= 40 || keyPressed == true && key == ' ') { 
    fill(125, 249, 255);
  } else {
    fill(62.5, 124.5, 127.5);
  }
  ellipse(width/2, height/2, 80, 80);
  fill(0);
  ellipse(width/2, height/2, 60, 60);
  fill(125, 249, 255);
  if (play == false) {
    triangle(width/2 + cos(radians(0))*20, height/2 + sin(radians(0))*20, width/2 + cos(radians(120))*20, height/2 + sin(radians(120))*20, width/2 + cos(radians(240))*20, height/2 + sin(radians(240))*20);
  }
  if (play == true) {
    rect(width/2 - 15, height/2 - 15, 11, 30);
    rect(width/2 + 4, height/2 - 15, 11, 30);
  }
  
  if (play == false) {
  //Draw the audio visualizer
    for(int i = 0; i < in.bufferSize() - 1; i++) {
      float x1 = map( i, 0, in.bufferSize(), 0, width);
      float x2 = map( i+1, 0, in.bufferSize(), 0, width);
      stroke(125,249,255);
      strokeWeight(2);
      line(x1, height/2 - 125 - in.left.get(i)*75, x2, height/2 - 125 - in.left.get(i+1)*75);
      line(x1, height/2 + 125 + in.right.get(i)*75, x2, height/2 + 125 + in.right.get(i+1)*75);
    }
  } else if (play == true) {
    for(int i = 0; i < player.bufferSize() - 1; i++) {
      float x1 = map( i, 0, player.bufferSize(), 0, width);
      float x2 = map( i+1, 0, player.bufferSize(), 0, width);
      stroke(125,249,255);
      strokeWeight(2);
      line(x1, height/2 - 125 - player.left.get(i)*75, x2, height/2 - 125 - player.left.get(i+1)*75 );
      line(x1, height/2 + 125 + player.right.get(i)*75, x2, height/2 + 125 + player.right.get(i+1)*75 );
    }
    if (player.isPlaying() == false) {
      play = false;
      player.rewind();
    }
  }
  
  //draw progress meter
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
