class Vehicle extends Actor 
{
  PVector m_movement;
  float LaneDisplacement;
  // The only difference is that they can be animated
  // have their own direction of travle that may be different to the world
  Vehicle()
  {
    super("CarBlockout.obj", true);
    //m_model = createShape(BOX, 10.65, 30.4, 10.9);
    m_sizeX = 16.8;
    m_sizeY = 19.1;
    m_sizeZ = 34.3;
    if (random(0,3) > 1.5)
      LaneDisplacement = 7.5;
    else
      LaneDisplacement = -7.5 - m_sizeX;
    m_originX= m_sizeX;
    transform(LaneDisplacement,0,0);
  }
  
  
  
  
}
