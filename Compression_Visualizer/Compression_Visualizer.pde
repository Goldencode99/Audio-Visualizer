import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioOutput out;

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
  for(int i = round(dist(width,0,width/2,height/2) - 1); i > 0; i-=5) {
    stroke(map(player.left.get(i),-1,1,0,255),map(player.left.get(i),-1,1,0,255),map(player.left.get(i),-1,1,0,255),map(i,0,dist(width,0,width/2,height/2) - 1,255,0));
    strokeWeight(5);
    noFill();
    ellipse(width/2,height/2,i,i);
  }
}
