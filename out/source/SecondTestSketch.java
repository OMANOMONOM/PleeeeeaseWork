import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class SecondTestSketch extends PApplet {

Actor[] renderables;
Player testPlayer;
WorldGenerator wrldGen;
/*
[0] up
[1] down
[2] left
[3] right
*/

int[] inputMap = new int[5];
public void setup()
{
    
    renderables = new Actor[10];
    for (int i = 0; i < 10 ; i++)
        {
            renderables[i] = new Gizmo(.1f);;
            renderables[i].position(i*110,renderables[i].m_y,renderables[i].m_z);
        }
    testPlayer = new Player();
    wrldGen = new WorldGenerator();
    
    perspective(PI/3.0f, width/height, ((height/2.0f) / tan(PI*60.0f/360.0f))/10.0f, ((height/2.0f) / tan(PI*60.0f/360.0f))*10.0f); 
    print("Near clipping plane is: " + ((height/2.0f) / tan(PI*60.0f/360.0f))/10.0f + "\n");
    print("The far clipping plane" + ((height/2.0f) / tan(PI*60.0f/360.0f))*10.0f);
}



//When ever a key is pressed, we check to see if its a valid key.
//When a valid key is pressed it's index in inputmap is set to one
public void keyPressed()
{
    if(key == 'w' || key == 'W')
    {
        inputMap[0] = 1;
    }
    if(key == 's' || key == 'S')
    {
        inputMap[1] = 1;
    }
    if(key == 'a' || key == 'A')
    {
        inputMap[2] = 1;
    }
    if(key == 'd' || key == 'D')
    {
        inputMap[3] = 1;
    }
}

public void keyReleased()
{
    if(key == 'w' || key == 'W')
    {
        inputMap[0] = 0;
    }
    if(key == 's' || key == 'S')
    {
        inputMap[1] = 0;
    }
    if(key == 'a' || key == 'A')
    {
        inputMap[2] = 0;
    }
    if(key == 'd' || key == 'D')
    {
        inputMap[3] = 0;
    }
}

public void draw()
{
    background(128);
    lights();
    testPlayer.cameraPosition();
    //camera(testPlayer.m_cameraX,testPlayer.m_cameraY, testPlayer.m_cameraZ,
     //   testPlayer.m_x, testPlayer.m_y-50, testPlayer.m_z,
       // 0.0, 1.0, 0.0);
     camera(testPlayer.m_cameraX, testPlayer.m_cameraY, testPlayer.m_cameraZ,
       testPlayer.m_x, testPlayer.m_y-50, testPlayer.m_z,
       0.0f, 1.0f, 0.0f);  


    for (Actor r : renderables)
    {
        r.render();
    }
    testPlayer.update(inputMap);
    testPlayer.render();
    wrldGen.update();
    wrldGen.render();
    
    
}
class Actor 
{
    PShape m_model;
    String m_modelPath;

    float m_x, m_y, m_z, scale;
    float originX, originY, originZ;
    float localSize, sizeX, sizeY, sizeZ;
    float rotateY;


    Actor()
    {
      
    }

    Actor(String modelPath)
    {
        m_modelPath = modelPath;
        m_model = loadShape(m_modelPath);
        localSize = 1.0f;
    }

    public void render()
    {
        pushMatrix();
        translate(originX, originY, originZ);
        rotateY(rotateY);
        pushMatrix();
        translate(m_x, m_y, m_z);
    
        shape(m_model);
        popMatrix();
        popMatrix();
        
        
    }

    public void position(float x, float y, float z)
    {
        m_x =x;
        m_y = y;
        m_z =z;
    }
    
     public void transform(float dx, float dy, float dz)
    {
        m_x += dx;
        m_y += dy;
        m_z += dz;

    }


    public void update(){
        
    }
}
class DrawChunk extends Actor
{
  // When we create a builing we automatically give it a position on world space
  DrawChunk()
  {
    super("Chunk.obj");
    sizeZ = 74.078f;
  }
}  
class Gizmo extends Actor
{

    Gizmo(float size)
    {
        super();
        localSize = size;
        m_model = createShape(GROUP);
        strokeWeight(10);
        stroke(color(255,0,0));
        PShape xLine = createShape(LINE, 0.0f,0.0f, 0.0f, 100.0f * localSize, 0.0f, 0.0f);
        stroke(color(0,255,0));
        PShape yLine = createShape(LINE, 0.0f,0.0f, 0.0f, 0.0f, 100.0f * localSize, 0.0f);
        stroke(color(0,0,255));
        PShape zLine = createShape(LINE, 0.0f,0.0f, 0.0f, 0.0f, 0.0f, localSize * 100.0f);
        stroke(color(0,0,0));
        m_model.addChild(xLine);
        m_model.addChild(yLine);
        m_model.addChild(zLine);
    }



    public void update()
    {
        render();
    }
}
class Obstacles extends Actor 
{
  PVector m_direction;
  // The only difference is that they can be animated
  // have their own direction of travle that may be different to the world
  Obstacles()
  {
    super();
    
  m_model = createShape(BOX, 10.65f,30.4f,10.9f);
  }
  

}
class ObstaclesManager
{
  final int  MAX_OBSTACLES = 10;
  Obstacles[] obstacleArray;
  float m_spawnZ;

  ObstaclesManager(float spawnZ)
  {
    // Arrays of obstacles 
    m_spawnZ = spawnZ;
    obstacleArray = new Obstacles[MAX_OBSTACLES];
  }


  // Spawn 
  public void createObstacles()
  {
    for (int i = 0; i < MAX_OBSTACLES; i++)
    {
      // Create new obstacle object in first available index.
      if (obstacleArray[i] == null)
      {
        obstacleArray[i] = new Obstacles();
        obstacleArray[i].m_direction = new PVector(0.0f,0.0f,10.0f/60);
        obstacleArray[i].position(0,0,m_spawnZ);
      }
    }
  }
  
  //Update the obstacles array
  public void update()
  {
    //Move each of the obsticles
    for (int i = 0; i < MAX_OBSTACLES; i++)
    {
      if  (obstacleArray[i] != null)
      {
        //Move the obstacle in its chosen direction
        obstacleArray[i].transform(0.0f, 0.0f, obstacleArray[i].m_direction.z + (85.0f/60));
      }
    }
  }
  
  public void render()
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
class Player extends Actor
{
    float m_cameraX;
    float m_cameraY;
    float m_cameraZ;
    float m_cameraZDisplace;
    float m_cameraYDisplace;

    float[] deltaV = new float[3];
    Player(){
        strokeWeight(2);
        m_model = createShape(BOX, 1.80f, 0.60f,3.0f);
        m_cameraZ = 0;
        m_cameraX = 0;
        m_cameraY = 0;
        m_cameraZDisplace = 150;
        m_cameraYDisplace = -110;
    }

    public @Override
    void position(float x, float y, float z)
    {
        
    }
    
    //@Override
    public void update(int[] inputMap){
        cameraPosition();
        
        //Create a vector from the inputs
        if(inputMap[0] - inputMap[1] == 0)
            deltaV[1] = 0;
        else if (inputMap[0] - inputMap[1] < 0)
            deltaV[1] = 1;
        else 
            deltaV[1] = -1;

        //Create a vector from the inputs
        if(inputMap[2] - inputMap[3] == 0)
            deltaV[0] = 0;
        else if (inputMap[2] - inputMap[3] < 0)
            deltaV[0] = 1;
        else 
            deltaV[0] = -1;
        //print(deltaV[0] + " : " + deltaV[1] + "\n");

        this.transform(deltaV[0], deltaV[1], 0);
    }

    public void cameraPosition()
    {
        m_cameraX = m_x;
        m_cameraY = m_y + m_cameraYDisplace;
        m_cameraZ = m_z + m_cameraZDisplace;
    }

   

}
class WorldGenerator extends Actor
{
  DrawChunk[] chunkArray;
  int bdDistance = 20;
  float farSpawnPoint;
  float treadmillSpeed = 85.0f/60;
  ObstaclesManager m_ObsManager;
  
  
  WorldGenerator()
  {
    chunkArray = new DrawChunk[bdDistance];
    for (int i = 0; i < bdDistance; i++)
    {
      chunkArray[i] = new DrawChunk();

      // Sets up each chunk with its inital position
      chunkArray[i].position(0, 0, i * ((-chunkArray[i].sizeZ)) );
    }
    farSpawnPoint = chunkArray[bdDistance - 1].m_z - chunkArray[0].sizeZ;
    m_ObsManager = new ObstaclesManager(farSpawnPoint);
    m_ObsManager.createObstacles();
  }

  //Each frame we move all the chunks +Z to imitate the player moving forward
  //If a chunk moves beyond the camera we teleport it to the back of the "treadmill"
  public void update()
  {
    // Move the treadmill of chunks
    for (int i = 0; i < chunkArray.length; i++)
    {
      chunkArray[i].transform(0, 0, treadmillSpeed);
      if (chunkArray[i].m_z > 150)
      {
        if (i == 0)
          chunkArray[0].m_z = chunkArray[bdDistance - 1].m_z - chunkArray[0].sizeZ;
        else
          chunkArray[i].m_z = chunkArray[(i-1)].m_z - chunkArray[0].sizeZ;
      }
    }
    m_ObsManager.update();
  }
  public @Override
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
      m_ObsManager.render();

    }
  }
}
  public void settings() {  size(1280,720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "SecondTestSketch" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
