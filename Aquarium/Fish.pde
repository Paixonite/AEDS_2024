class Fish {
  color cor;
  float vx, vy;
  float x, y;
  int counter;
  int shape;
  
  Fish(){
    this.counter = 0;
    this.x = random(width);
    this.y = random(height);
    this.shape = 1;
    this.cor = color((int)random(256),(int)random(256),(int)random(256));
  }
  
  void move(){
    if(counter % 600 == 0){
      vx = random(-3, 3);
      vy = random(-0.75, 0.75);
    }
    
    if(y <= 0 || y >= height){
      vy *= -1;
    }
    
    if(x <= 0 || x >= width){
      vx *= -1;
    }
    
      x += vx;
      y += vy;
      counter ++;
  }
  
  void drawsFish(){
    fill(cor);
    ellipse(x, y, 20, 15);
    if(vx > 0)
      triangle(x - 10, y, x - 25, y + 8, x - 25, y - 8);
    else
      triangle(x + 10, y, x + 25, y + 8, x + 25, y - 8);
  }
}

