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
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// A circular particle

class Heart {

  // We need to keep track of a Body and a radius
  Body body;
  float r;
  color shapeColor;

  Heart(float x, float y, float r_) {
    r = r_;
    // This function puts the particle in the Box2d world
    makeBody(x, y, r);
    shapeColor = randomColor();
  }

  // This function removes the particle from the box2d world
  void killBody() {
    box2d.destroyBody(body);
  }

  // Is the particle ready for deletion?
  boolean done() {
    // Let's find the screen position of the particle
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Is it off the bottom of the screen?
    if (pos.y > height+r*2) {
      killBody();
      return true;
    }
    return false;
  }

  // 
  void display() {
    // We need the Body’s location and angle
    Vec2 pos = box2d.getBodyPixelCoord(body);    
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    
    translate(pos.x, pos.y);
    rotate(-a / 10);
    
    fill(shapeColor);
    stroke(shapeColor);
    beginShape();
    
    float val = 0;
    for (int i = 0; i < 25; i++) {
      val += 0.3;
      float xp = 16 * sin(val) * sin(val) * sin(val);
      float yp1 = 13 * cos(val);
      float yp2 = 5 * cos(2 * val);
      float yp3 = 2 * cos(3 * val);
      float yp4 = cos(4 * val);
      float yp = yp1 - yp2 - yp3 - yp4;
      vertex(-xp, -yp);
    }
    
    endShape(CLOSE);
    popMatrix();
  }

  // Here's our function that adds the particle to the Box2D world
  void makeBody(float x, float y, float r) {
    // Define a body
    BodyDef bd = new BodyDef();
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x,y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.world.createBody(bd);

    PolygonShape ps = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(r);
    float box2dH = box2d.scalarPixelsToWorld(r);  // Box2D considers the width and height of a
    ps.setAsBox(box2dW, box2dH);
    //CircleShape cs = new CircleShape();
    //cs.m_radius = box2d.scalarPixelsToWorld(r);
    
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    // Parameters that affect physics
    fd.density = 100;
    fd.friction = 0.1;
    fd.restitution = 0.03;
    // Attach fixture to body
    body.createFixture(fd);

    // Give it a random initial velocity (and angular velocity)
    body.setLinearVelocity(new Vec2(random(-5f, 5f),random(2.5f, 5f)));
    body.setAngularVelocity(random(-100,100));
  }
  
  color randomColor() {
  color[] colors = {color(192, 17, 255), 
                    color(202, 22, 42),
                    color(69, 102, 238),
                    color(255, 218, 7),
                    color(193, 240, 255),
                    color(253, 58, 6),
                    color(0, 0, 206)};
                    
   int index = int(random(colors.length));
   
   return colors[index];
  }
  
}
// The Nature of Code
// <http://www.shiffman.net/teaching/nature>
// Spring 2010
// Box2DProcessing example

// An uneven surface boundary

class Surface {
  // We'll keep track of all of the surface points
  ArrayList<Vec2> surface;


  Surface() {
    surface = new ArrayList<Vec2>();
    // Here we keep track of the screen coordinates of the chain
    
    
    
    surface.add(new Vec2(width, 0));
    surface.add(new Vec2(width, height));
    surface.add(new Vec2(0, height));
    surface.add(new Vec2(0, 0));
    // This is what box2d uses to put the surface in its world
    ChainShape chain = new ChainShape();

    // We can add 3 vertices by making an array of 3 Vec2 objects
    Vec2[] vertices = new Vec2[surface.size()];

    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));     
    }
    
    chain.createChain(vertices,vertices.length);
 
    // The edge chain is now a body!
    BodyDef bd = new BodyDef();
    Body body = box2d.world.createBody(bd);
    // Shortcut, we could define a fixture if we
    // want to specify frictions, restitution, etc.
    body.createFixture(chain,1);
  }

  // A simple function to just draw the edge chain as a series of vertex points
  void display() {
    strokeWeight(1);
    stroke(0);
    fill(200);
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x,v.y);
    }
    vertex(0,height);
    vertex(width,height);
    endShape();
  }
}
