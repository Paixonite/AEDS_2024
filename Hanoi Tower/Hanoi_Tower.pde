import java.util.Stack;

Stack<Disk>[] stack = new Stack[3];
Disk buffer;
int numDisks = 5;
int maxDisks = 15;
int minDisks = 3;
int pallete = 1;
int moves;
int lastRemoved;
boolean organized = false;
boolean click;
PImage button[] = new PImage[6];

void setup(){
  size(1000,600);
  strokeWeight(2);
 
  moves = 0;
  click = false;
  buffer = null;
 
  button[0] = loadImage("button1.png");
  button[1] = loadImage("button2.png");
  button[2] = loadImage("button3.png");
  button[3] = loadImage("button4.png");
  button[4] = loadImage("button5.png");
  button[5] = loadImage("button6.png");
 
  for(int i = 0; i < 3; i++)
    stack[i] = new Stack<>();
 
  Disk[] diskArray = new Disk[numDisks];
 
  for(int i = 0; i < numDisks; i++){
    color gradient = colorPallete(pallete, i);
    diskArray[i] = new Disk(numDisks - i, gradient);
  }
 
  if(organized)
    sort(diskArray);
  else
    shuffle(diskArray);

  for(int i = 0; i < numDisks; i++)
    stack[0].push(diskArray[i]);
 
  organized = false;
}

void draw(){
  background(#0279A2);
  showBase();
  showDisks();
  showMenu();
  showMoves();

  Integer s = stackClicked();
 
  if(s != null){
    if(buffer == null && !stack[s].empty()){
      buffer = stack[s].pop();
      lastRemoved = s;
    } else if(buffer != null && stack[s].empty()){
      stack[s].push(buffer);
      buffer = null;
      if(lastRemoved != s) moves++;
    } else if(buffer != null && !stack[s].empty() && buffer.size < stack[s].peek().size){
      stack[s].push(buffer);
      buffer = null;
      if(lastRemoved != s) moves++;
    }
  }
 
  if(buffer != null)
    buffer.showBuffer();
 
}

Integer stackClicked(){
  if(click && mouseY >= height/5 && mouseY <= 4 * height/5){
    click = false;
    if(mouseX > 1 * width/4 - width/8 && mouseX < 1 * width/4 + width/8)
      return 0;
    if(mouseX > 2 * width/4 - width/8 && mouseX < 2 * width/4 + width/8)
      return 1;
    if(mouseX > 3 * width/4 - width/8 && mouseX < 3 * width/4 + width/8)
      return 2;
  }
  click = false;
  return null;
}

void showBase(){
  fill(#9B5A00);
  rect(1 * width / 4 - width / 100, 1 * height / 5, width / 50, 3 * height / 5, 0);
  rect(2 * width / 4 - width / 100, 1 * height / 5, width / 50, 3 * height / 5, 0);
  rect(3 * width / 4 - width / 100, 1 * height / 5, width / 50, 3 * height / 5, 0);
  rect(width / 10, 4 * height / 5, width - width / 5, height / 20);
}

void showDisks(){
  for(int i = 0; i < 3; i++){
    int j = 0;
    for(Disk disk : stack[i]){
      disk.show(i, j);
      j++;
    }
  }
}

void showMoves(){
  int size = (height/15 + width/25)/2;
  fill(255);
  textSize(size);
  text("Moves: " + moves, width - textWidth("Moves: " + moves) - 8, size);
}

void showMenu(){
  int size = (height/12 + width/20)/2;
  for(int i = 0; i < 6; i++)
    image(button[i], i * size, 0, size, size);
 
  if(click && mouseY >= 0 && mouseY <= size){    
    if(mouseX > 0 * size && mouseX < 1 * size){
      exit();
    }
    if(mouseX > 1 * size && mouseX < 2 * size){
      setup();
    }
    if(mouseX > 2 * size && mouseX < 3 * size){
      if(pallete == 8)
        pallete = 0;
      pallete++;
      setup();
    }
    if(mouseX > 3 * size && mouseX < 4 * size){
      if(numDisks < maxDisks){
        numDisks++;
        setup();
      }
    }
    if(mouseX > 4 * size && mouseX < 5 * size){
      if(numDisks > minDisks){
        numDisks--;
        setup();
      }
    }
    if(mouseX > 5 * size && mouseX < 6 * size){
      organized = true;
      setup();
    }
  }
 
}

color colorPallete(int pallete, int i){
  float intensity = (i + 1) * 255 / numDisks;
  switch(pallete){
    case 1:
      return color(intensity, 0, 0);
    case 2:
      return color(0, intensity, 0);
    case 3:
      return color(0, 0, intensity);
    case 4:
      return color(intensity, intensity, 0);
    case 5:
      return color(intensity, 0, intensity);
    case 6:
      return color(0, intensity, intensity);
    case 7:
      return color(intensity, intensity, intensity);
    case 8:
      return color(random(255), random(255), random(255));
  }
  return 255;
}

void shuffle(Disk[] d){
  for (int i = numDisks - 1; i > 0; i--) {
      int j = int(random(i + 1));
      Disk temp = d[i];
      d[i] = d[j];
      d[j] = temp;
  }
}

void sort(Disk[] d){
  int n = numDisks;
  boolean swap;
  do {
    swap = false;
    for (int i = 0; i < n - 1; i++) {
      if (d[i].size < d[i + 1].size) {
        Disk temp = d[i];
        d[i] = d[i + 1];
        d[i + 1] = temp;
        swap = true;
      }
    }
    n--;
  } while (swap);
}
   
void mousePressed(){
  click = true;
}
