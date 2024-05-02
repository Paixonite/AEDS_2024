int [][]grid;
int n = 100;




void setup(){
  size (1000,1000);
  frameRate(100);
  background(255);
  grid = initGrid();
}




int [][]initGrid(){
  int[][]m = new int[n][n];
 
  for(int i = 0; i < n; i++)
    for(int j = 0; j < n; j++)
      m[i][j] = (int)(random(3));
       
  return m;
}


void printGrid(){
  float l = width/(float)n;
  float h = height/(float)n;


  for(int i = 0; i < n; i++){
    for(int j = 0; j < n; j++){
      stroke(200);
      switch (grid[i][j]){
        case 0:
          fill(255);
          break;
         
        case 1:
          fill(0, 255, 0);
          break;
         
        case 2:
          fill(0, 0, 255);
          break;
      }
    rect(j*l, i*h, l, h);
    }
  }
}


int countNeighbors(int i, int j){
  int sum = 0;
  for(int ki = -1; ki < 2; ki++)
    for(int kj = -1; kj < 2; kj++){
      if (ki == 0 && kj == 0) continue;
      if (grid[(n+i+ki)%n][(n+j+kj)%n] == grid[i][j])
        sum ++;
    }
       
  return sum;
}


void updateGrid() {
  int[][] newGrid = new int[n][n];


  for (int i = 0; i < n; i++) {
    for (int j = 0; j < n; j++) {
      if (grid[i][j] == 0) continue;


      int neighbors = countNeighbors(i, j);


      if (neighbors < 3) {
        boolean moved = false;
        for (int attempt = 0; attempt < 10; attempt++) {
          int kj = (int) random(n);
          int ki = (int) random(n);


          if (grid[ki][kj] == 0 && newGrid[ki][kj] == 0) {
            newGrid[ki][kj] = grid[i][j];
            newGrid[i][j] = 0;
            moved = true;
            break;
          }
        }
        if (!moved) {
          newGrid[i][j] = grid[i][j];
        }
      } else {
        newGrid[i][j] = grid[i][j];
      }
    }
  }
  grid = newGrid;
}




void draw(){
  printGrid();
  updateGrid();
 
  if(mousePressed)
    grid  = initGrid();
}
