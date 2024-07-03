ArvoreBinaria arv;
int numNos = 10;
int modo;
int indice;
boolean click;
PImage[] botao = new PImage[5];

void setup(){
   size(600, 600);
   strokeWeight(2);
   background(#A8E5EA);
   
   modo = 0;
   indice = 0;

   botao[0] = loadImage("button1.png");
   botao[1] = loadImage("button2.png");
   botao[2] = loadImage("button3.png");
   botao[3] = loadImage("button4.png");
   botao[4] = loadImage("button5.png");
   
   newTree();
}

void draw(){
  menu();
   
  arv.mostrar();
 
 if(modo != 0){
    fill(255);
    rect(0, height - 80, width - 1, 79);
    switch(modo){
      case 1:
      arv.raiz.preOrdem();
      textSize(30);
      text("PRÉ ORDEM", 90, height - 40);
      break;
     
      case 2:
      arv.raiz.emOrdem();
      textSize(30);
      text(" EM ORDEM", 90, height - 40);
      break;
     
      case 3:
      arv.raiz.posOrdem();
         textSize(30);
      text("PÓS ORDEM", 90, height - 40);
      break;
    }
    indice = 0;
 }
}

void mouseClicked(){
  click = true;
}

void menu(){
  int tamanho = (height/15 + width/15)/2;
  for(int i = 0; i < 5; i++)
    image(botao[i], i * tamanho, 0, tamanho, tamanho);
 
  if(click && mouseY >= 0 && mouseY <= tamanho){
    if(mouseX > 0 * tamanho && mouseX < 1 * tamanho){
      exit();
    }
    if(mouseX > 1 * tamanho && mouseX < 2 * tamanho){
      setup();
      click = false;
    }
    if(mouseX > 2 * tamanho && mouseX < 3 * tamanho){
      modo = 1;
      click = false;
    }
    if(mouseX > 3 * tamanho && mouseX < 4 * tamanho){
      modo = 2;
      click = false;
    }
    if(mouseX > 4 * tamanho && mouseX < 5 * tamanho){
      modo = 3;
      click = false;
    }
  }
}

void newTree (){
  arv = new ArvoreBinaria();
  for(int i = 0; i< numNos; i++)
     arv.insere((int)random(100));
}
