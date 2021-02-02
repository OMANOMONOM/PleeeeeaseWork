class Player extends Actor
{
  
  // ------------ Declarations ------------------------------
  //Camera
  float m_cameraX;
  float m_cameraY;
  float m_cameraZ;
  float m_cameraZDisplace;
  float m_cameraYDisplace;
  float m_cameraXDisplace;
  float m_cameraFocusPZ = -8.23;
  float m_cameraFocusPY = -3.38;
  float m_cameraFocusPX = (7.22/2);
  boolean m_skimming;

  //Movement 
  float sinkRate = 0.2;
  float m_energy = 100f;
  float[] deltaV = new float[3];
  
  // ---------------- Implementation -------------------------
  Player() {
    super("player/plane_hitbox.obj", true);
    strokeWeight(2);
    m_model.setFill(color(255, 0, 0));
    //m_model = createShape(BOX, 1.80, 0.60,3.0);
    
    // Sets camera offset from player
    m_cameraZ = 0;
    m_cameraX = 0;
    m_cameraY = 0;
    m_cameraZDisplace = 39;
    m_cameraYDisplace = -10.3;
    m_cameraXDisplace = (7.22/2);
    m_sizeX = 7.21;
    m_sizeY = 2.23;
    m_sizeZ = 12.129;
    m_y = -40;
    
    //originX = -sizeX/2;
    //originY = -sizeY/2;
    //originZ = -sizeZ/2;
  }

  //@Override
  void update(int[] inputMap) {
    cameraPosition();

    //Create a vector from the vertical inputs
    if (inputMap[0] - inputMap[1] == 0)
    {
      deltaV[1] = 0;
    } else if (inputMap[0] - inputMap[1] < 0)
    {
      deltaV[1] = 1;
    } else 
    {
      if ((m_energy -1)  >= 0)
      {
        deltaV[1] = -1;
        m_player.m_energy -= -(deltaV[1]);
      }
    }

    //Create a vector from the horizontal inputs
    if (inputMap[2] - inputMap[3] == 0)
      deltaV[0] = 0;
    else if (inputMap[2] - inputMap[3] < 0)
      deltaV[0] = 1;
    else 
    deltaV[0] = -1;
    //print(deltaV[0] + " : " + deltaV[1] + "\n");

    //this.transform(deltaV[0], deltaV[1], 0);
    this.transform(deltaV[0], sinkRate + deltaV[1], 0);
    
    if(this.m_y > -20)
    {
      m_skimming = true;
      m_energy += 0.5;
    }else
    {
      m_skimming = false;
    }
  }

  void cameraPosition()
  {
    m_cameraX = m_x + m_cameraXDisplace;
    m_cameraY = m_y + m_cameraYDisplace;
    m_cameraZ = m_z + m_cameraZDisplace;
  }
}
