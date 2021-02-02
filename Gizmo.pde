class Gizmo extends Actor
{
  // Just for debugging purposes 
  Gizmo(float size)
  {
    super();
    m_localSize = size;
    m_model = createShape(GROUP);
    strokeWeight(10);
    stroke(color(255, 0, 0));
    PShape xLine = createShape(LINE, 0.0, 0.0, 0.0, 100.0 * m_localSize, 0.0, 0.0);
    stroke(color(0, 255, 0));
    PShape yLine = createShape(LINE, 0.0, 0.0, 0.0, 0.0, 100.0 * m_localSize, 0.0);
    stroke(color(0, 0, 255));
    PShape zLine = createShape(LINE, 0.0, 0.0, 0.0, 0.0, 0.0, m_localSize * 100.0);
    stroke(color(0, 0, 0));
    m_model.addChild(xLine);
    m_model.addChild(yLine);
    m_model.addChild(zLine);
  }


  void update()
  {
    render();
  }
}
