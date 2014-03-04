float max = displayWidth;
float spacing = 10;
float line_counter = 0;
float line_length = 300;
float offset = 0;
float offsetChange = .0001;
float high = 0;
float low = 0;
float prevhigh;
float prevlow;
int flip_counter;

void setup() {
  frameRate(60);
  size(displayWidth, displayHeight);
  noCursor();
  flip_counter = 1;
}

void draw() {
  if (flip_counter < 80) {
    background(0);
  } else {
    background(255);
  }
    while (line_counter * spacing < max) {
      prevhigh = high;
      prevlow = low;
      high = displayHeight/2 - (line_length / 2) + random(offset * -1, offset);
      low = displayHeight/2 + (line_length / 2) + random(offset * -1, offset);
      stroke(127 / sqrt((abs(line_counter * spacing - mouseX) + 1) / 100), 0,255 / sqrt((abs(line_counter * spacing - mouseX) + 1) / 100));
      strokeWeight(1);
      line(line_counter * spacing, high, line_counter * spacing, low);
      strokeWeight(2);
      stroke(0, 255 / sqrt((abs(line_counter * spacing - mouseX) + 1) / 100), 0);
      line((line_counter - 1) * spacing, prevhigh - 2, line_counter * spacing, high - 2);
      line((line_counter - 1) * spacing, prevlow + 2, line_counter * spacing, low + 2);
      line_counter = line_counter + 1;
      offset = offset + offsetChange;
    }
    max = max + spacing;
    line_counter = 0;
    //flip_counter = flip_counter * -1;
    //flip_counter = flip_counter + 1;
    flip_counter = flip_counter % 160;
}
