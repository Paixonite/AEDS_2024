class Organismo {
  PVector posicao;
  PVector velocidade;
  float[] dna;
  float vida;    // Indica a aptidão (quanto mais saúde, melhor)
  float velocidadeMax;
  float percepcao; // Distância máxima para detectar recursos
  float tamanho;
  int sexo; // Pode ser 0 ou 1
  
  Organismo(PVector posicao, float[] dna) {
    this.posicao = posicao.copy();
    this.dna = dna;
    this.vida = 100;
    
    // Fenótipo derivado do genótipo (DNA)
    this.velocidadeMax = map(dna[0], 0, 1, 2, 5);
    this.percepcao = map(dna[1], 0, 1, 50, 200);
    this.tamanho = map(dna[2], 0, 1, 4, 8);
    this.velocidade = PVector.random2D();
    
    this.sexo = (int)random(2);
  }
  
  
  
  void atualiza() {
    // Movimento simples
    posicao.add(velocidade);
    // Consume energia ao se mover
    vida -= velocidadeMax / 10.0;
    
    // Limites da tela
    if (posicao.x > width) posicao.x = 0;
    if (posicao.x < 0) posicao.x = width;
    if (posicao.y > height) posicao.y = 0;
    if (posicao.y < 0) posicao.y = height;
  }
  
  
  
  void procuraComida() {
    PVector maisProximo = null;
    float dist = Float.MAX_VALUE;
    
    for (PVector r : comida) {
      float d = PVector.dist(posicao, r);
      if (d < dist && d < percepcao) {
        dist = d;
        maisProximo = r;
      }
    }
    
    if (maisProximo != null) {
      PVector desejado = PVector.sub(maisProximo, posicao);
      desejado.setMag(velocidadeMax);
      
      PVector direcao = PVector.sub(desejado, velocidade);
      velocidade.add(direcao);
      
      // Se reach o recurso, consome-o
      if (dist < tamanho) {
        vida += 20;
        comida.remove(maisProximo);
      }
    }
  }
  
  
  
  Organismo reproduzir(Organismo outro) {
    // Reproduz com uma probabilidade baseada na saúde
    if (random(1) < 0.1 && this.vida > 50) {
      float[] novoDna = new float[3];
      
      //Mescla DNA dos pais
      for(int i = 0; i < 3; i++){
        if((int)random(2) == 1)
          novoDna[i] = this.dna[i];
        else 
          novoDna[i] = outro.dna[i];
      }
      
      // Mutação
      for(int k = 0; k < novoDna.length; k++)
        if(random(1) < 0.05) novoDna[k] = constrain(novoDna[k] + random(-0.1, 0.1), 0, 1);
      
      vida -= 10;
      
      // Filho nasce num local aleatório
      PVector novaPosicao = new PVector();
      novaPosicao.y = (int)random(width);
      novaPosicao.x = (int)random(height);
      
      //novaPosicao.y = this.posicao.y + (int)random(-25, 25);
      //novaPosicao.x = this.posicao.x + (int)random(-25, 25);
      return new Organismo(novaPosicao, novoDna);
    } else {
      return null;
    }
  }
  
  
  
  boolean morreu() {
    return vida <= 0;
  }
  
  
  
  void mostra() {
    stroke(0);
    colorMode(HSB, 360, 100, 100);
    fill(cor(map(velocidadeMax, 2, 5, 0, 100)));
    //Desenha forma de acordo com o sexo
    if(sexo == 0){
      ellipse(posicao.x, posicao.y, tamanho, tamanho);
    } else {
      square(posicao.x, posicao.y, tamanho);
    }
    colorMode(RGB, 255, 255, 255);
  }
  
  
  
  color cor(float valor) {
    valor = constrain(valor, 0, 100);
    float matiz = map(valor, 0, 100, 0, 120);
    return color(matiz, 100, 100);
  }
}
