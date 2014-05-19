import ddf.minim.*;
Minim minim;
AudioInput in;

void setup() {
  size(displayWidth, displayHeight, P3D);
  minim = new Minim(this);
  in = minim.getLineIn();
  noCursor();
}

void draw() {
  background(0);
  stroke(255);
  for(int i = 0; i < in.bufferSize() - 1; i++) {
    float x1 = map( i, 0, in.bufferSize(), 0, width);
    float x2 = map( i+1, 0, in.bufferSize(), 0, width);
    if(i % 10 == 0) {
      stroke(127, 0, 255);
      strokeWeight(1);
      line(x1, height/2, x1, height/2 - 100 - in.left.get(i) * 100);
      line(x1, height/2, x1, height/2 + 100 + in.right.get(i) * 100);
    }
    stroke(0, 255, 0);
    strokeWeight(2);
    line( x1, height/2 - 100 - in.left.get(i)*100, x2, height/2 - 100 - in.left.get(i+1)*100 );
    line( x1, height/2 + 100 + in.right.get(i)*100, x2, height/2 + 100 + in.right.get(i+1)*100 );
  }
}
