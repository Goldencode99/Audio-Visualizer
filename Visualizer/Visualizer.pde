import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioOutput out;

void setup() {
  size(displayWidth, displayHeight, P3D);
  minim = new Minim(this);
  player = minim.loadFile("Konec - Aztek_audio.mp3");
  out = minim.getLineOut();
  player.play();
  noCursor();
}

void draw() {
  background(0);
  stroke(255);
  text("Aztek - Konec", 5, 15);
  for(int i = 0; i < player.bufferSize() - 1; i++) {
    float x1 = map( i, 0, player.bufferSize(), 0, width);
    float x2 = map( i+1, 0, player.bufferSize(), 0, width);
    if(i % 10 == 0) {
      stroke(127, 0, 255);
      strokeWeight(1);
      line(x1, height/2, x1, height/2 - 100 - player.left.get(i) * 100);
      line(x1, height/2, x1, height/2 + 100 + player.right.get(i) * 100);
    }
    stroke(0, 255, 0);
    strokeWeight(2);
    line( x1, height/2 - 100 - player.left.get(i)*100, x2, height/2 - 100 - player.left.get(i+1)*100 );
    line( x1, height/2 + 100 + player.right.get(i)*100, x2, height/2 + 100 + player.right.get(i+1)*100 );
  }
}
