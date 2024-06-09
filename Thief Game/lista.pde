class No
{
  celula dado;
  No proximo;

  No(celula dado)
  {
    this.dado = dado;
    this.proximo = null;
  }
}

class ListaEncadeada
{
  No cabeca; //head

  void add(celula dado)
  {
    No novoNo = new No(dado);

    if (cabeca == null) cabeca = novoNo;
    else
    {
      No fim = cabeca;

      while (fim.proximo != null)
      {
        fim = fim.proximo;
      }

      fim.proximo = novoNo;
    }
  }

  void clear() {this.cabeca = null;}

  void sort()
  {
    No atual, anterior;
    celula temp;
    boolean trocado;

    if (cabeca == null) return; // Se a lista estiver vazia, não há nada para ordenar

    do
    {
      trocado = false;
      atual = cabeca;
      anterior = null;

      while (atual.proximo != null)
      {
        // Comparar os valores das células e trocá-los se estiverem na ordem errada
        if (atual.dado.valor > atual.proximo.dado.valor)
        {
          temp = atual.dado;
          atual.dado = atual.proximo.dado;
          atual.proximo.dado = temp;
          trocado = true;
        }

        // Avançar para o próximo nó
        anterior = atual;
        atual = atual.proximo;
      }

    } while (trocado);
  }
}
