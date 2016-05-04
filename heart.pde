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