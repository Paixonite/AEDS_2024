public final class celula
{
  public boolean acessivel;
  public PImage img;
  private int valor;
  
  public celula(boolean acessivel, PImage img, int valor)
  {
    this.acessivel = acessivel;
    this.img = img;
    this.valor = valor;
  }
  
  public void marcaPonto(personagem p)
  {
    if(this == armadilha)
    {
      ganhou = false;
      tempoSegundosCountdown = 0;
      return;
    }
    
    if(this.valor != 0)
    {
      p.pontuacao += this.valor;
      grid[p.posX][p.posY] = chao;
      inventario.add(this);
    }
  }
}
