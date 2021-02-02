class DrawChunk extends Actor
{
  
  // DONT USE THIS FOR REPEATED BUILDINGS
  DrawChunk()
  {
    super("Chunks.obj", false);  
    m_sizeZ = 120;
  }

  // PSHAPE REFERECNE means only one PSHAPE is created and therefore buffered.
  // Hugely saves on preformance
  DrawChunk(PShape shape) 
  {
    super(shape, true);        
    m_sizeZ = 120;
    
  }
}  
