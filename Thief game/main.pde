int nl = 16; //Numero de linhas
int na = 20; //Numero de colunas

float h;//Constante que guarda a altura de cada celula
float w;//Constante que guarda a largura de cada celula

int tempoSegundosTotal = 120; //Variavel que conta quanto tempo o programa sera excutado
int tempoMilesimosCountdown = 0; //Variavel que guarda o tempo de execucao do programa
int tempoSegundosCountdown = tempoSegundosTotal;
int tempoMilesimosItens = 0; //
int tempoMilesimosIntervaloItens = 2000;

boolean pausado = false;//Guarda se o programa sera executado normalmente ou na tela de pause
boolean terminado = false;
boolean ganhou = true;

boolean click = false;//Guarda se o houve um unico clique no mouse

PImage chaoImg, cofreImg, paredeImg, personagemImg, gameOverImg1, gameOverImg2, armadilhaImg; //Imagens utilizadas nas telas

celula chao, cofre, parede, armadilha; //Celulas utilizadas no cenario
celula item[] = new celula[10]; //Celulas utilizadas nos itens

celula[][] grid = new celula[na][nl]; //Alocacao do grid 
personagem p = new personagem(na, nl); //Criacao do personagem
ListaEncadeada inventario = new ListaEncadeada(); //Alocacao da lista

int nColunasLista = 20;

void setup()
{
  size(1280,1024);//(1824,992)
  //fullScreen();
  frameRate(60);
  background(545454);

  h = (float)width/na;
  w = (float)height/nl;

  gameOverImg1 = loadImage("cashRain.png");
  gameOverImg2 = loadImage("barras.png");
  personagemImg = loadImage("paradoFrente0.png");
  chaoImg = loadImage("chao.png");
  cofreImg = loadImage("cofre.png");
  paredeImg = loadImage("parede.png");
  armadilhaImg = loadImage("armadilha.png");

  chao = new celula(true, chaoImg, 0);
  cofre = new celula(false, cofreImg, 0);
  parede = new celula(false, paredeImg, 0);
  armadilha = new celula(true, armadilhaImg, 0);

  item[0] = new celula(true, loadImage("bronze1.png"), 1);
  item[1] = new celula(true, loadImage("bronze2.png"), 2);
  item[2] = new celula(true, loadImage("bronze3.png"), 3);
  item[3] = new celula(true, loadImage("prata1.png"), 4);
  item[4] = new celula(true, loadImage("prata2.png"), 5);
  item[5] = new celula(true, loadImage("prata3.png"), 6);
  item[6] = new celula(true, loadImage("ouro1.png"), 7);
  item[7] = new celula(true, loadImage("ouro2.png"), 8);
  item[8] = new celula(true, loadImage("ouro3.png"), 9);
  item[9] = new celula(true, loadImage("nota.png"), 10);

  criaGrid();
  showGrid();
}

void keyPressed() // Funcao que identifica qual tecla foi apertada;
{
  if(key == CODED && terminado == false && pausado == false)
{ 
    switch(keyCode){
      case UP:
        p.mvUP();
        break;
      case DOWN:
        p.mvDW();
        break;
      case LEFT:
        p.mvLF();
        break;
      case RIGHT:
        p.mvRG();
        break;
    }
  }
}

void mousePressed()
{
  click = true;
}

void draw()
{
  if(terminado == false)
  {
    if(pausado == false)
    {
      milesimosCountdown();
      cronometro();
      showScore();
      showPause();
      imprimirPersonagem();
      criaItens();
    }

    pausar();
  }

  if(tempoSegundosCountdown == 0)
  {
    terminado = true;
    gameOver();
  }
}

void gameOver()
{
  fill(0);
  rect(0, 0, 5000, 5000);

  terminado = true;

  if(ganhou)
  {
    image(gameOverImg1, 0, 0, width, height/2);

    fill(#013901);
    rect(0, height/4 - 62, width, 75);

    fill(#00CE01);
    textSize(75);
    text("ESCAPOU COM SUCESSO", width/5, height/4);

    fill(0);
    rect(width/3 + 85, height/5 + 75, textWidth(" Lucro: $   K"), 75);

    fill(#FAD500);
    textSize(50);
    text("Lucro: $" + p.pontuacao + "K", width/2 - 85, height/4 + 75);
  }
  else
  {
    image(gameOverImg2, 0, 0, width, height/2);

    fill(#400101);
    rect(0, height/4 - 70, width, 80);

    fill(255,0,0);
    textSize(75);
    text("VOCÊ FOI PRESO", width/3, height/4);

    fill(0);
    rect(width/3 + 80, height/5 + 75, textWidth(" Fiança: $   K"), 75);

    fill(#FAD500);
    textSize(50);
    text("Fiança: $" + p.pontuacao + "K", width/2 - 85, height/4 + 75);
  }

  fill(255);
  textSize(50);
  text("Inventário:", 50, height/2 + 100);

  fill(255);
  textSize(50);
  text("Recomeçar?", width/2, height/2 + 100);

  fill(#004000);
  rect(width - 150, height/2 + 53, textWidth("SIM"), 50);

  fill(#400000);
  rect(width - 300, height/2 + 53, textWidth("NÃO"), 50);

  fill(0, 255, 0);
  textSize(50);
  text("SIM", width - 150, height/2 + 100);

  fill(255, 0, 0);
  textSize(50);
  text("NÃO", width - 300, height/2 + 100);

  //Inventário
  inventario.sort();
  imprimeLista();

  //SIM
  if(mousePressed && mouseX >= width - 150 && mouseX <= width - 150 + textWidth("SIM")
  && mouseY >= height/2 + 53 && mouseY <= height/2 + 53 + 50){
    criaGrid();
    showGrid();
    p.posX = na/2;
    p.posY = nl/2;
    p.pontuacao = 0;
    tempoSegundosCountdown = tempoSegundosTotal;
    inventario.clear();
    ganhou = true;
    terminado = false;
  }

  //NAO
  if(mousePressed && mouseX >= width - 300 && mouseX <= width - 300 + textWidth("NÃO")
  && mouseY >= height/2 + 53 && mouseY <= height/2 + 53 + 50){
    exit();
  }
}

void imprimeLista()
{
  No aux = inventario.cabeca;
  int i = 0, j = 0;

  for(;;)
  {
    if(aux == null) break;

    if(i % nColunasLista == 0 && i != 0) //
    {
      j++;
      i -= nColunasLista;
    }

    image(aux.dado.img, i * 64, j * 64 + height/2 + 120, 32 * 2, 32 * 2);

    aux = aux.proximo;
    i++;
  }
}



void imprimirPersonagem()
{
  for(int i = p.posX - 1; i <= p.posX + 1; i++)
  {
     for(int j = p.posY - 1; j <= p.posY + 1; j++)
     {
       if(grid[i][j].acessivel == true) image(grid[i][j].img, i * h, j * w, h, w);
     }
  }

  image(personagemImg, p.posX * h, p.posY * w, h, w);
}

void showScore()
{
    fill(#150055);
    rect(width - 128, 0, 128, 64);

    fill(#FAE205);
    textSize(40);
    text("$" + p.pontuacao + "K", width - 106, 40);
}

void criaGrid()
{
  float r;
  
  for(int i = 1; i < na - 1; i++)
  {
    for(int j = 1; j < nl - 1; j++)
    {
      r = random(1);
      
      if(r < 0.05) grid[i][j] = armadilha;
      else if(r < 0.2) grid[i][j] = cofre;
      else grid[i][j] = chao;
    }
  }
  
  for(int i = 0; i < na; i++){
    grid[i][0] = parede;
    grid[i][nl - 1] = parede;
  }
  for(int j = 0; j < nl; j++){
    grid[0][j] = parede;
    grid[na - 1][j] = parede;
  }
  
  grid[na/2][nl/2] = chao;
}

void showGrid()
{
  for(int i = 0; i < na; i++)
  {
    for(int j = 0; j < nl; j++)
    {
      image(chao.img, i * h, j * w, h, w);
      image(grid[i][j].img, i * h, j * w, h, w);
    }
  }
}

void milesimosCountdown()
{
  if(millis() - tempoMilesimosCountdown >= 1000)
  {
    tempoSegundosCountdown--;
    tempoMilesimosCountdown = millis();
  }
}

void cronometro()
{  
  int minutos = tempoSegundosCountdown / 60;
  int segundos = tempoSegundosCountdown % 60;

  fill(#150055);
  rect(0, 0, 128, 64);
  
  fill(#FAE205);
  textSize(40);
  text(minutos + ":" + nf(segundos, 2), 25, 40);
}

void criaItens()
{
  if(millis() - tempoMilesimosItens >= tempoMilesimosIntervaloItens)
  {
    int x, y;
    
    do
    {
      x = (int)random(1, na - 1);
      y = (int)random(1, nl - 1);
    } while(grid[x][y].acessivel == false || grid[x][y].valor != 0 || grid[x][y] == armadilha);
    
    int i = (int)random(10);
    grid[x][y] = item[i];
    image(grid[x][y].img, x * h, y * w, h, w);
  
    tempoMilesimosItens = millis();
  }
}

void showPause()
{
    fill(#150055);
    rect(width/2 - 64, 0, 128, 64);
    
    fill(#FAE205);
    textSize(40);
    text("Pause", width/2 - 50, 40);
}

void pausar()
{
  if(click == true)
  {
    click = false;
    
    if(mouseX >= width/2 - 64 && mouseX <= width/2 - 64 + 128 && mouseY >= 0 && mouseY <= 64)
    {
      if(pausado == true)
      {
        pausado = false;
        showGrid();
      }
      else menuPause();
    }
  }
}

void showPlay()
{
    fill(#150055);
    rect(width/2 - 64, 0, 128, 64);
    
    fill(#FAE205);
    textSize(40);
    text("Play", width/2 - 37, 40);
}

void menuPause()
{
  pausado = true;
  
  background(#000000);
  cronometro();
  showScore();
  imprimeLista();
  showPlay();
}
