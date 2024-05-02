class Ball{

  int radius;
  float x;
  float y;
  float vy = 0;
  float ay = 0.5;
 
  Ball(int x, int y, int radius){
    this.x = (float)x;
    this.y = (float)y;
    this.radius = radius;
  }
 
  void update(){
    if( y + vy >= height - ground){
      vy = - 0.8 * vy;
      y = height - ground;
    }
   
    vy += ay;
    y += vy;
  }
 
  void show(){
    fill(#FC6100);
    stroke(5);
    strokeWeight(3);
    
    ellipse(x, y, radius * 2, radius * 2);
    
    curve(
    x + radius * 4,
    y + radius,
    x + 0.7 * radius,
    y + 0.7 * radius,
    x + 0.7 * radius,
    y - 0.7 * radius,
    x + radius * 4,
    y - radius
    );
    
    curve(
    x - radius * 4,
    y + radius,
    x - 0.7 * radius,
    y - 0.7 * radius,
    x - 0.7 * radius,
    y + 0.7 * radius,
    x - radius * 4,
    y - radius
    );
    
    line(x, y - radius, x , y + radius);
    line(x - radius, y, x + radius, y);
  }
}
