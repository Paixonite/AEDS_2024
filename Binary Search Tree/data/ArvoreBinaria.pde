class ArvoreBinaria {
  No raiz;

  ArvoreBinaria() {
    raiz = null;
  }

  void insere(int valor) {
    raiz = insereRec(raiz, valor);
  }

  private No insereRec(No raiz, int valor) {
        if(raiz == null){
            raiz = new No(valor);
            return raiz;
        }
   
        if (valor < raiz.valor)
            if (raiz.esq == null)
                raiz.esq = new No(valor);
            else
                insereRec(raiz.esq, valor);
        else if (valor > raiz.valor)
            if (raiz.dir == null)
                raiz.dir = new No(valor);
            else
                insereRec(raiz.dir, valor);
   
        return raiz;
  }

  void mostrar() {
    mostrarArvore(raiz, width / 2, 40, width / 4);
  }

  private void mostrarArvore(No raiz, float x, float y, float xOffset) {
    textSize(17);
    if (raiz != null) {
     

      if (raiz.esq != null) {
        line(x, y, x - xOffset, y + 60);
        mostrarArvore(raiz.esq, x - xOffset, y + 60, xOffset / 2);
      }

      if (raiz.dir != null) {
        line(x, y, x + xOffset, y + 60);
        mostrarArvore(raiz.dir, x + xOffset, y + 60, xOffset / 2);
      }
     
      stroke(0);
      fill(#00ACFF);
      ellipse(x, y, 30, 30);
      fill(0);
      textAlign(CENTER, CENTER);
      text(raiz.valor, x, y);
    }
  }
}
