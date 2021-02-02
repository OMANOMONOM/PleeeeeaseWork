// interfaces between the actor manager and the game.
class ObstaclesManager
{
  final int  MAX_OBSTACLES = 10;
  Vehicle[] obstacleArray;
  float m_spawnZ;
  ActorManager actorMgr;

  ObstaclesManager(float spawnZ, ActorManager actmgr)
  {
    // Arrays of obstacles 
    m_spawnZ = spawnZ;
    obstacleArray = new Vehicle[MAX_OBSTACLES];
    actorMgr = actmgr;
  }

  // Spawn 
  void createObstacles()
  {
    for (int i = 0; i < MAX_OBSTACLES; i++)
    {
      // Create new obstacle object in first available index.
      if (obstacleArray[i] == null)
      {
        obstacleArray[i] = new Vehicle();
        actorMgr.addActor(obstacleArray[i]);
        obstacleArray[i].m_movement = new PVector(0.0, 0.0, 1.8);
        obstacleArray[i].transform(0, 0, m_spawnZ);
        return;
      }
    }
  }

  //Update the obstacles array
  void update()
  {
    //Move each of the obsticles
    for (int i = 0; i < MAX_OBSTACLES; i++)
    {
      if  (obstacleArray[i] != null)
      {
        //Move the obstacle in its chosen direction
        obstacleArray[i].transform(0.0, 0.0, obstacleArray[i].m_movement.z + (85.0/60));

        if (obstacleArray[i].m_z >100.0)
        {
          obstacleArray[i] = null;
          // Destroy said obstacle
          print("Object has been deleted");
        }
      }
    }
  }

  void render()
  {
    for (int i = 0; i < MAX_OBSTACLES; i++)
    {
      // Create new obstacle object in first available index.
      if (obstacleArray[i] != null)
      {
        obstacleArray[i].render();
      }
    }
  }
}
