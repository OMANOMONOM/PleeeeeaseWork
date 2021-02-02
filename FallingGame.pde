ActorManager m_actorMgr;
Player m_player;
WorldGeneratorManager m_wrldGenMgr;
ObstaclesManager m_ObsManager;
GUIManager m_GUIMgr;
Gizmo gizmo;
//Test code 
PGraphics GUI;
float m_intervalCount;
float m_interval;
float m_score;
enum Status {
  STATUS_MAINMENU, STATUS_PLAYING, STATUS_PAUSED, STATUS_OVER
}
Status status;
/*
[0] up
 [1] down
 [2] left
 [3] right
 */
int[] inputMap = new int[5];



void setup()
{
  size(1280, 720, P3D);
  gameSetup();
}

void gameSetup()
{
  //Initilise all the managers and player
  m_actorMgr = new ActorManager();
  m_player = new Player();
  m_actorMgr.addActor(m_player);
  m_wrldGenMgr = new WorldGeneratorManager();
  m_ObsManager = new ObstaclesManager(-120.0 * 15, m_actorMgr);
  m_ObsManager.createObstacles();
  m_GUIMgr = new GUIManager();
  status = Status.STATUS_PLAYING;
  gizmo = new Gizmo(1.0);
  
  m_interval = 60*3;
}

//When ever a key is pressed, we check to see if its a valid key.
//When a valid key is pressed it's index in inputmap is set to one
void keyPressed()
{
  if (key == 'w' || key == 'W')
  {
    inputMap[0] = 1;
  }
  if (key == 's' || key == 'S')
  {
    inputMap[1] = 1;
  }
  if (key == 'a' || key == 'A')
  {
    inputMap[2] = 1;
  }
  if (key == 'd' || key == 'D')
  {
    inputMap[3] = 1;
  }
}

void keyReleased()
{
  if (status == Status.STATUS_PLAYING)
  {
    if (key == 'w' || key == 'W')
    {
      inputMap[0] = 0;
    }
    if (key == 's' || key == 'S')
    {
      inputMap[1] = 0;
    }
    if (key == 'a' || key == 'A')
    {
      inputMap[2] = 0;
    }
    if (key == 'd' || key == 'D')
    {
      inputMap[3] = 0;
    }
  }
  if (status == Status.STATUS_OVER)
  {
    if (key == ENTER)
    {
      // RERUN the game
      gameSetup();
    }
    if (key == BACKSPACE)
    {
      
      // EXIT the game
    }
  }
}

void draw()
{
  if (status == Status.STATUS_PLAYING)
  {
    updateGameLoop();
    render3D();
    m_GUIMgr.drawGUI(m_player.m_energy, m_player.m_skimming, m_score);
    m_GUIMgr.renderGUI(m_GUIMgr.m_HudGUI);

  }
  if (status== Status.STATUS_OVER)
  {
    render3D();
    m_GUIMgr.renderGUI(m_GUIMgr.m_menuGui);

  }

  //image(GUI, 0,0);
}

void render3D() {
  pushMatrix();
  background(color(102,204,255));
  lights();

  m_player.cameraPosition();
  camera(m_player.m_cameraX, m_player.m_cameraY, m_player.m_cameraZ, 
    m_player.m_x +  m_player.m_cameraFocusPX, m_player.m_y + m_player.m_cameraFocusPY, m_player.m_z + m_player.m_cameraFocusPZ, 
    0.0, 1.0, 0.0);

          gizmo.render();

  perspective(PI/3.0, (float)width/height, 1, 100000);
  m_ObsManager.render();
  m_player.render();
  m_wrldGenMgr.render();
  //m_ObsManager.render();

  popMatrix();

}

void gameOverLoop()
{
  // Show Game over UI
  //GAME OVER 
  //SCORE 
  //PRESS SPACE TO PLAY AGAIN OR E TO EXIT
  //ACCEPT SAID INPUTS
  //START GAME AGAIN
  //EXIT TO MAIN MENU
}

Status setupGameOverScreen()
{
  m_GUIMgr.drawGameOverGUI();
  return Status.STATUS_OVER;
}

void updateGameLoop()
{
  ((Player)m_actorMgr.actors[0]).update(inputMap);
  m_wrldGenMgr.update();
  m_ObsManager.update();
  gizmo.update();

  if (m_actorMgr.isColliding())
  {
    status = setupGameOverScreen();
    print("We have a collison");
  }
  // X is the interval between spawns
  // Spawn every interval x an obstacle 
  if (m_intervalCount == m_interval)
  {
    //Spawn a new obstacle
    m_intervalCount = 0;
    m_ObsManager.createObstacles();
  }else
    m_intervalCount++;
  
}
