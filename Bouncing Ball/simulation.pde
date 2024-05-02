import java.util.LinkedList;

LinkedList<ball> balls = new LinkedList<ball>();
int ground = 150;
int radius = 40;
boolean click;
int numStars = 300;
int[][] star = new int[numStars][2];



void setup(){
  //fullScreen();
  size(1000, 1000);
  
  //sets stars
  for(int i = 0; i < numStars; i++){
    star[i][0] = (int)random(width);
    star[i][1] = (int)random(height);
  }
}



void draw(){
  background(#00013B);
  noStroke();
   
  //stars
  fill(255);
  for(int i = 0; i < numStars; i++)
    ellipse(star[i][0], star[i][1], 3, 3);
   
  //moon
  fill(#F8FF3E);
  ellipse(150, 150, 100, 100);
  fill(#00013B);
  ellipse(165, 135, 75, 75);
  
  //ground
  fill(#003B04);
  rect(0, height - ground + radius, width, ground);
  
  //spawns ball
  if(click && mouseButton == LEFT){
    balls.add(new ball(mouseX, mouseY, radius));
    click = false;
  }
  
  //removes balls
  if(click && mouseButton == RIGHT)
    for(int i = 0; i < balls.size(); i++)
      balls.remove(i);
  
  //draws balls
  for(int i = 0; i < balls.size(); i++){
    balls.get(i).update();
    balls.get(i).show();
  }
}



void mousePressed(){
  click = true;
}
