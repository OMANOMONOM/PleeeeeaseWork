class WorldGeneratorManager extends Actor
{
  DrawChunk[] chunkArray;
  int bdDistance = 20;
  float farSpawnPoint;
  float treadmillSpeed = 85.0/60;
  PShape chunk;


  WorldGeneratorManager()
  {
    chunk = loadShape("Chunks.obj");

    chunkArray = new DrawChunk[bdDistance];
    for (int i = 0; i < bdDistance; i++)
    {
      //chunkArray[i] = new DrawChunk(chunk);
      chunkArray[i] = new DrawChunk(chunk);
      // Sets up each chunk with its inital position
      chunkArray[i].position(0, 0, i * ((-chunkArray[i].m_sizeZ)) );
    }
    farSpawnPoint = chunkArray[bdDistance - 1].m_z - chunkArray[0].m_sizeZ;
    
  }

  //Each frame we move all the chunks +Z to imitate the player moving forward
  //If a chunk moves beyond the camera we teleport it to the back of the "treadmill"
  void update()
  {
    // Move the treadmill of chunks
    for (int i = 0; i < chunkArray.length; i++)
    {
      chunkArray[i].transform(0, 0, treadmillSpeed);
      if (chunkArray[i].m_z > 150)
      {
        if (i == 0)
          chunkArray[0].m_z = chunkArray[bdDistance - 1].m_z - chunkArray[0].m_sizeZ;
        else
          chunkArray[i].m_z = chunkArray[(i-1)].m_z - chunkArray[0].m_sizeZ;
      }
    }
  }
  @Override
    void render()
  {
    //Render each one of the buildings
    for (int i = 0; i < chunkArray.length; i++)
    {
      // Update the position of each one of the buildings
      // We only need to update the X co-ordinate
      pushMatrix();
      // Render each one of the buildings

      chunkArray[i].render();
      popMatrix();
    }
  }
}
