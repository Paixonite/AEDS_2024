// Parâmetros da Simulação
int tamanhoDaPopulacao = 100;   // Tamanho da população
int quantidadeRecursos = 25;    // Número de recursos no ambiente
int tempoDeVida = 100;          // Duração de cada geração em frames
int populacaoMax = 250;         // População máxima para evitar superpopulação

int geracao;                // Contador de gerações
int contadorDeFrames;       // Contador de frames

ArrayList<Organismo> populacao; // Lista de organismos
ArrayList<PVector> comida;      // Lista de recursos

void setup() {
  size(800, 600);

  geracao = 0;
  contadorDeFrames = 0;

  populacao = new ArrayList<Organismo>();
  comida = new ArrayList<PVector>();
  
  // Inicializa a população
  for (int i = 0; i < tamanhoDaPopulacao; i++) {
    float[] dna = new float[3];
    for(int k = 0; k < dna.length; k++) dna[k] = random(1);
    populacao.add(new Organismo(new PVector(random(width), random(height)), dna));
  }
  
  // Inicializa os recursos
  for (int i = 0; i < quantidadeRecursos; i++) {
    comida.add(new PVector(random(width), random(height)));
  }
}

void draw() {
  background(0);
  
  // Atualiza e desenha os recursos
  for (PVector r : comida) {
    fill(255);
    ellipse(r.x, r.y, 10, 10);
  }
  
  // Atualiza e desenha os organismos
  for (int i = 0; i < populacao.size(); i++) {
    Organismo o = populacao.get(i);
    o.procuraComida();
    o.atualiza();
    o.mostra();
    
    // Verifica se está morto
    if (o.morreu()) {
      populacao.remove(i);
    } else {
      //Tenta reproduzir se houver espaço
      if(populacao.size() < populacaoMax)
        // Itera sobre os possíveis parceiros
        for (int j = i + 1; j < populacao.size(); j++){
          Organismo outro = populacao.get(j);
          
          // Verifica se são passíveis de reprodução 
          if(o.posicao.dist(outro.posicao) < o.tamanho * 2 && o.sexo != outro.sexo){
            Organismo filho = o.reproduzir(outro);
            if (filho != null) {
              populacao.add(filho);
              break;
            }
          }
        }
    }
  }
  
  // Contador de frames para controlar as gerações
  contadorDeFrames++;
  if (contadorDeFrames >= tempoDeVida) {
    novaGeracao();
    contadorDeFrames = 0;
    geracao++;
  }
    
  surface.setTitle("Geração: " + geracao + " | " + "População: " + populacao.size() + " | " + "Recursos: " + comida.size());
}

void novaGeracao() {
  // Reabastece os recursos
  comida.clear();
  for (int i = 0; i < quantidadeRecursos; i++) {
    comida.add(new PVector(random(width), random(height)));
  }
  
  //Se a população estiver muito pequena, adiciona novos organismos
  //if (populacao.size() < 10) {
  //  for (int i = 0; i < 10; i++) {
  //    float[] dna = new float[3];
  //    for(int k = 0; k < dna.length; k++) dna[k] = random(1);
  //    populacao.add(new Organismo(new PVector(random(width), random(height)), dna));
  //  }
  //}
  
}

void mousePressed(){
  setup();
}
