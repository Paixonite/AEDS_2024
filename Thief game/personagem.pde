public final class personagem
{
  public int posX; // Posicao no eixo X(no grid).
  public int posY; // Posicao no eixo Y(no grid).
  public int pontuacao;

  public personagem(int na, int nl) // Passar os parametros incialmente
  {
    this.posX = na/2;
    this.posY = nl/2;
    this.pontuacao = 0;
  }

  // Funcao de mover pra cima.
  public void mvUP()
  {
    celula c = grid[this.posX][this.posY - 1];

    if(c.acessivel == false) return;

    this.posY--;
    c.marcaPonto(this);
  }

  // Funcao de mover pra baixo.
  public void mvDW()
  {
    celula c = grid[this.posX][this.posY + 1];

    if(c.acessivel == false) return;

    this.posY++;
    c.marcaPonto(this);
  }

  // Funcao de mover pra esquerda.
  public void mvLF()
  {
    celula c = grid[this.posX - 1][this.posY];

    if(c.acessivel == false) return;

    this.posX--;
    c.marcaPonto(this);
  }

  // Funcao de mover pra direita.
  public void mvRG()
  {
    celula c = grid[this.posX + 1][this.posY];

    if(c.acessivel == false) return;

    this.posX++;
    c.marcaPonto(this);
  }
}
