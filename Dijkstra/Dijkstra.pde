

Grafo g;

void setup(){
  size(600,600);
 
  int n = 10;
  int [][]adj= new int[n][n];
 
  for(int i = 0; i < n; i++)
    for(int j = 0; j < n; j++){
      adj[i][j] = random(1) > 0.5 ? (int)random(1,5) : 0;
      adj[j][i] = adj[i][j];
    }
 
  g = new Grafo(adj);
 
  for(int i = 0; i < 500; i++)
    g.atualizar();
 
  background(#D3EEFF);
 
  g.desenhar(g.dijkstra(0,9));
}

void draw(){}

void mousePressed(){
  setup();
}
