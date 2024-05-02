Fish[] cardume = new Fish[60];

void setup(){
  size(1000, 600);
  for(int i = 0; i < cardume.length; i++){
    cardume[i] = new Fish();
  }
}

void draw(){
  background(#40ABFF);
  for(int i = 0; i < cardume.length; i++){
    cardume[i].move();
    cardume[i].drawsFish();
  }
}
