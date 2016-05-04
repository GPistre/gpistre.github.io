import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;
Surface surface;
ArrayList<Heart> hearts;

void setup() {
  //smooth();
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  hearts = new ArrayList<Heart>();
  box2d.setGravity(0, -20);
  surface = new Surface();
  size(640, 480); 
  background(0);
}
 
void draw() {
    //if (mousePressed) {
    //hearts.add(new Heart(mouseX, mouseY, 10));
  //}
//  
  box2d.step();

  background(255);

  // Draw all particles
  for (Heart p: hearts) {
    p.display();
  }
  
  surface.display();
  // Particles that leave the screen, we delete them
  // (note they have to be deleted from both the box2d world and our list
  for (int i = hearts.size()-1; i >= 0; i--) {
    Heart p = hearts.get(i);
    if (p.done()) {
      hearts.remove(i);
    }
  }
}

void mousePressed() {
  for (int i = 0; i < random(4, 10); i++) {
    int xOffset = int(random(0, 20)) - 10;
    int yOffset = int(random(0, 20)) - 10;
    hearts.add(new Heart(mouseX + xOffset, mouseY + yOffset, 10));
  }
  
}