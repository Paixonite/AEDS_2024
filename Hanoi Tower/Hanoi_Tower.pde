import java.util.Stack;

Stack<Disk>[] stack = new Stack[3];
Disk buffer;
int numDisks = 5;
int pallete = 1; 
int moves;
int lastRemoved;
boolean click;
PImage button[] = new PImage[5];

void setup(){
  size(1000, 600);
  strokeWeight(2);
  
  moves = 0;
  click = false;
  buffer = null;
  
  button[0] = loadImage("button1.png");
  button[1] = loadImage("button2.png");
  button[2] = loadImage("button3.png");
  button[3] = loadImage("button4.png");
  button[4] = loadImage("button5.png");
  
  for(int i = 0; i < 3; i++)
    stack[i] = new Stack<>();
  
  //fills first stack
  for(int i = 0; i < numDisks; i++){
    color gradient = colorPallete(pallete, i);
    stack[0].push(new Disk(numDisks - i, gradient));
  }
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
      //if (pallete == 8) pallete = 0;
      //pallete++;
      //setup();
      return 2;
  }
  click = false;
  return null;
}

void showBase(){
  fill(#9B5A00);
  rect(1 * width / 4 - 10, 1 * height / 5, 20, 3 * height / 5 + 10, 0);
  rect(2 * width / 4 - 10, 1 * height / 5, 20, 3 * height / 5 + 10, 0);
  rect(3 * width / 4 - 10, 1 * height / 5, 20, 3 * height / 5 + 10, 0);
  rect(width / 10, 4 * height / 5, width - width / 5, 30);
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
  int size = height/15;
  fill(255);
  textSize(size);
  text("Moves: " + moves, width - textWidth("Moves: " + moves) - 8, size);
}

void showMenu(){
  int size = height/15;
  for(int i = 0; i < 5; i++) 
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
      if(numDisks < 10)
        numDisks++;
      setup();
    }
    if(mouseX > 4 * size && mouseX < 5 * size){
      if(numDisks > 3)
        numDisks--;
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

void mousePressed(){
  click = true;
}
