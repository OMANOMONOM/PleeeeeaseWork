// GUI MANAGER - does gui stuff
// for what ever reason rendering GUI isn't too taxing BUT creating the inital buffer pgraphic makes processing sh
// For in game i was thinkning only updating the Gui every 6 frames, aka 10 times a second?????/
// Or make the GUI out of smaller PGraphics
// Or call the draw GUI only when states change??? 

class GUIManager
{
  PGraphics m_HudGUI;
  PGraphics m_menuGui;

  GUIManager()
  {
  m_HudGUI = createGraphics(200, 200, P2D);
  m_menuGui = createGraphics(width, height, P2D);

  }

  //  1. turn z-buffer off
  //  2. draw GUi
  //  3. turn z-buffer back on for the next render loop
  void renderGUI( PGraphics gui)
  {
    hint(PConstants.DISABLE_DEPTH_TEST);
    if (gui != null)
      image(gui, 0, 0);
    hint(PConstants.ENABLE_DEPTH_TEST);
  }
  
  //TODO - only call every 6 frames???
  void drawGUI(float  energy, boolean isSkimming, float score)
{
  m_HudGUI.beginDraw();
  m_HudGUI.background(0, 0);  
  m_HudGUI.fill(color(256, 0, 0));
  m_HudGUI.textSize(20);
  m_HudGUI.text("Energy level: " + energy + "% ", 20, 100);
  if(isSkimming)
    m_HudGUI.text("Skimming!!", 20, 130);
  m_HudGUI.text("Score: " + score, 20, 160);
  m_HudGUI.fill(125);
  m_HudGUI.endDraw();
}

void drawGameOverGUI()
{
  m_menuGui.beginDraw();
  m_menuGui.background(0, 0);
  m_menuGui.textSize(90);
  String s = "GAME OVER";
  m_menuGui.text(s, ((width/2)-(textWidth(s)*4.5)), height /2); 
  m_menuGui.endDraw();
}


}
