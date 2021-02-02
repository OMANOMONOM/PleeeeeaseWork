// Base class for all assets which are renderable AND collidable 
// All object origins are based upon their front left coner i think
// Dubug hitboxes are done in blender and imported for simplcity.

// TODO: Make this an abstract class? or at least make most of the funcitons virtual/Abstract what ever its called in JAVA
class Actor 
{
  
  // ------------ Declarations ------------------------------
  
  PShape m_model;
  PShape m_collisionMesh;
  String m_modelPath;

  float m_x, m_y, m_z, scale;
  float m_originX, m_originY, m_originZ;
  float m_localSize, m_sizeX, m_sizeY, m_sizeZ;
  float m_rotateY;
  boolean m_isCollidable;


  // ------------ Implementation ------------------------------

  Actor()
  {
    
  }

  //Any Actor which will have multiple instacnes use this constructor 
  Actor(PShape pshape, boolean isCollidable)
  {
    m_model = pshape;
    m_localSize = 1.0;
    m_isCollidable = isCollidable;
  }

  //All other actors use this constructor
  Actor(String modelPath, boolean isCollideable)
  {
    m_modelPath = modelPath;
    m_model = loadShape(m_modelPath);
    m_localSize = 1.0;
    m_isCollidable = isCollideable;
  }
  // 
  //Actor(String modelPath, boolean isCollideable, PShape collisionMesh)
  //{
  //  m_modelPath = modelPath;
  //  m_collisionMesh = collisionMesh;
  //  m_model = loadShape(m_modelPath);
  //  localSize = 1.0;
  //  m_isCollidable = isCollideable;
  //}

  // ...
  void render()
  {
    // DO NOT TOUCH ANY OF THIS TOOK FUCKING AGES TO SORT OUT
    pushMatrix();
    translate(m_originX, m_originY, m_originZ);
    pushMatrix();
    translate(m_x, m_y, m_z);

    shape(m_model);
    //if(m_collisionMesh != null)
    //{
    //  shape(m_collisionMesh);
    //}
    popMatrix();
    popMatrix();
  }

  // DO NOT USE. JUST TRANSFORM FROM THE ORIGIN
  void position(float x, float y, float z)
  {
    m_x = x;
    m_y = y;
    m_z = z;
  }

  //Probably should be renamed to translate?
  void transform(float dx, float dy, float dz)
  {
    m_x += dx;
    m_y += dy;
    m_z += dz;
  }

  //TODO - make a virtual function
  void update() {
    //print("We're executing the subclass function");
  }
}
