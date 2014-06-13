import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioOutput out;
int speakerSize = 400;

void setup() {
  size(displayWidth, displayHeight, P3D);
  minim = new Minim(this);
  player = minim.loadFile("[Drumstep] - Muzzy & Day One - Black Magic [Monstercat Release]_audio.mp3");
  out = minim.getLineOut();
  player.play();
  noCursor();
}

void draw() {
  background(0);
  for(int i = speakerSize; i > 0; i-=5) {
    strokeWeight(5);
    noFill();
    stroke(map(player.left.get(floor(map(i,speakerSize,0,0,player.bufferSize()))),-1,1,0,255),map(i,0,speakerSize,255,0));
    ellipse(width/2 - speakerSize/2,height/2,i,i);
    stroke(map(player.right.get(floor(map(i,speakerSize,0,0,player.bufferSize()))),-1,1,0,255),map(i,0,speakerSize,255,0));
    ellipse(width/2 + speakerSize/2,height/2,i,i);
  }
}
