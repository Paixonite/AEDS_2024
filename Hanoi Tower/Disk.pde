public class Disk{
  int size; //ranges from 1 - numDisks
  color diskColor;

  Disk(int size, color diskColor){
    this.size = size;
    this.diskColor = diskColor;
  }
 
  void show(int i, int j){
    fill(diskColor);
   
    rect(
    width/4 * (i + 1) - (size * width/4 / numDisks + 15) / 2,
    4 * height/5 - 3 * height/5 / (numDisks + 1) - j * 3 * height/5 / (numDisks + 1),
    size * width/4 / numDisks + 15,
    3 * height/5 / (numDisks + 1),
    3 * height/5 / (numDisks + 1) / 3
    );
  }
 
  void showBuffer(){
    fill(diskColor);
   
    rect(
    width/2 - (size * width/4 / numDisks + 15) / 2,
    height/20,
    size * width/4 / numDisks + 15,
    3 * height/5 / (numDisks + 1),
    3 * height/5 / (numDisks + 1) / 3
    );
  }

}
