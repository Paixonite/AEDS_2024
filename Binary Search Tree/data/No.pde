class No {
  int valor;
  No esq;
  No dir;

  No(int valor) {
    this.valor = valor;
    esq = null;
    dir = null;
  }
 
  void preOrdem(){
      imprimeNo();
      if (esq != null) esq.preOrdem();
      if (dir != null) dir.preOrdem();
  }
 
   void emOrdem(){
      if (esq != null) esq.emOrdem();
      imprimeNo();
      if (dir != null) dir.emOrdem();
  }
 
   void posOrdem(){
      if (esq != null) esq.posOrdem();
      if (dir != null) dir.posOrdem();
      imprimeNo();
  }
 
  void imprimeNo(){
    int x = 40;
    int y = height - 40;
    fill(#00ACFF);
    ellipse(x * (indice + 5), y, 30, 30);
    fill(0);
    textAlign(CENTER, CENTER);
    text(this.valor, x * (indice + 5), y);
    indice++;
  }
}
