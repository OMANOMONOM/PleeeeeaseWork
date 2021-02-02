//Class is currently responsible for collisions between actors.
//All actors, aka placeable, renderable objects are placed in here.

class ActorManager
{
  //Will be around 40 final game
  final int MAX_ACTORS = 10;

  //array contains reference to every actor in game
  //Will need to make it a 2D array
  //First dimension stores the actors by type to make it possible to "Slice down" aka cast 
  Actor[] actors;
  Player player;


  ActorManager()
  {
    actors = new Actor[MAX_ACTORS];
    //Code below is called Slicing. 
    //Player is always at index one 
    // TODO Could do with reading more into it.
    player = (Player)(actors[0]);
  }

  //Adds actor at first availabe index in Actors array
  void addActor(Actor actor)
  {
    for (int i = 0; i < MAX_ACTORS; i++)
    {
      // Create new obstacle object in first available index.
      if (actors[i] == null)
      {
        actors[i] = actor;
        return;
      }
    }
  }

  // TODO: RESEARCH better collision algorithms because this one sucks
  // Checks if an actors are colliding with the player
  boolean isColliding()
  {
    player = (Player)(actors[0]);
    //Loop through all other actors to compare
    for (int i = 1; i < MAX_ACTORS; i++)
    {
      if (actors[i] != null)
      {
        //Check for collisions
        if (((player.m_z - player.m_sizeZ) <= actors[i].m_z) && (player.m_z >= (actors[i].m_z- actors[i].m_sizeZ)))
        {
          if (((player.m_y - player.m_sizeY) <= actors[i].m_y) && (player.m_y >= (actors[i].m_y- actors[i].m_sizeY)))
          {
            if (((player.m_x + player.m_sizeX) >= actors[i].m_x) && (player.m_x <= (actors[i].m_x + actors[i].m_sizeX)))
            {
              return true;
            }
          }
        }
      }
    }
    // Ground and wall collision 
    // THESE LIMITS ARE ALL WRONG THANKS TO NEW MESHES!!!
    if (player.m_y >= 0 || player.m_x < (-170/2) || player.m_x > (170/2) - player.m_sizeX)
    {
      return true;
    }
    return false;
  }
}
