DropdownList connectDropList;
Textlabel myTextarea;
int leftMargin = 10;
int posY = 10;
int ySpace = 36;
int rotation = 0;

//Println console;
Slider pixelSizeSlider;
Slider speedSlider;
Slider scaleSlider;
Slider penSlider;
PImage penUpImg; 
PImage penDownImg; 
PImage loadImg; 
PImage clearImg;
PImage pauseImg;
PImage plotImg;
MyButton loadButton;
MyButton plotButton;

class MyButton extends Button {
  public PImage img;

  MyButton(ControlP5 cp5, String theName) {
    super(cp5, theName);
  }
  public void setImg(PImage img)
  {
    this.img = img;
  }
}

MyButton addButton(String name, String label, int x, int y)
{

  PImage img = loadImage("icons/"+name+".png"); 
  MyButton b = new MyButton(cp5, name);
  b.setPosition(x, y)
    .setSize(menuWidth, 30)
      .setCaptionLabel(label)
        .setView(new myView())
          ;

  b.setImg(img);
  b.getCaptionLabel().setFont(createFont("", 10));
  return b;
}

Slider addSlider(String name, String label, float min, float max, float value)
{
  Slider s = cp5.addSlider(name)                       
    .setCaptionLabel(label)
      .setPosition(leftMargin, posY+=ySpace/2)
        .setSize(menuWidth, 17)
          .setRange(min, max) 
            .setColorBackground(color(115, 117, 216))
              .setColorActive(color(201, 206, 255))
                .setColorForeground(color(201, 206, 255))
                  .setColorCaptionLabel(color(0))
                    .setColorValue(color(0))
                      .setScrollSensitivity(1)
                        .setValue(value)      
                          ;
  controlP5.Label l = s.getCaptionLabel();
  l.getStyle().marginTop = 0; 
  l.getStyle().marginLeft = -(int)textWidth(label);
  return s;
}

class myView implements ControllerView<Button> {

  public void display(PGraphics theApplet, Button theButton) {
    theApplet.pushMatrix();
    if (theButton.isInside()) {
      if (theButton.isPressed()) { // button is pressed
        theApplet.fill(227, 230, 255);
      } else { // mouse hovers the button
        theApplet.fill(201, 206, 255);
      }
    } else { // the mouse is located outside the button area
      theApplet.fill(115, 117, 216);
    }

    stroke(0);
    strokeWeight(0.5); 

    theApplet.rect(0, 0, theButton.getWidth(), theButton.getHeight(), 8);   


    // center the caption label 
    int x = theButton.getWidth()/2 - theButton.getCaptionLabel().getWidth()/2-10;
    int y = theButton.getHeight()/2 - theButton.getCaptionLabel().getHeight()/2;

    translate(x, y);
    theButton.getCaptionLabel().setColor(0);
    theButton.getCaptionLabel().draw(theApplet);

    translate(-x, -y);
    PImage img = ((MyButton)theButton).img;
    if (img != null)
    {
      if ("".equals(theButton.getCaptionLabel().getText()))
        theApplet.image(img, theButton.getWidth()/2-16, -3, 32, 32);
      else
        theApplet.image(img, theButton.getWidth()-34, 0, 32, 32);
    }
    theApplet.popMatrix();
  }
}


void createcp5GUI()
{

  cp5 = new ControlP5(this);

  penUpImg= loadImage("icons/penUp.png"); 
  penDownImg= loadImage("icons/penDown.png"); 
  loadImg= loadImage("icons/load.png"); 
  clearImg= loadImage("icons/clear.png");
  pauseImg = loadImage("icons/pause.png");
  plotImg = loadImage("icons/plot.png");
  
  connectDropList = cp5.addDropdownList("dropListConnect")
    .setPosition(leftMargin, posY)
      .setCaptionLabel("Connect")
        .onEnter(toFront)
          .onLeave(close)
            .setBackgroundColor(color(115, 117, 216))
              .setColorBackground(color(115, 117, 216))
                .setColorForeground(color(201, 206, 255))
                  .setColorActive(color(201, 206, 255))
                    .setColorCaptionLabel(color(0))
                      .setColorValue(color(0))
                        .setItemHeight(20)
                          .setBarHeight(20)
                          .setWidth(menuWidth)
                            .setOpen(false)
                                .addItems(comPorts)
                                  ;


  myTextarea = cp5.addTextlabel("txt")
    .setPosition(leftMargin, posY+=20)
      .setSize(menuWidth, 30)
        .setFont(createFont("", 10))
          .setLineHeight(14)
            .setColor(textColor)
              .setColorBackground(gridColor)
                .setColorForeground(textColor)
                  ;

  addButton("setHome", "Set Home", leftMargin, posY+=ySpace/2);
  addButton("up", "", leftMargin+36, posY+=ySpace+4).onPress(press).onRelease(release).setSize(30, 24);
  addButton("left", "", leftMargin+16, posY+=30).onPress(press).onRelease(release).setSize(30, 24);
  addButton("right", "", leftMargin+56, posY).onPress(press).onRelease(release).setSize(30, 24);

  addButton("down", "", leftMargin+36, posY+=30).onPress(press).onRelease(release).setSize(30, 24);

  loadButton = addButton("load", "Load", leftMargin, posY+=ySpace);
  plotButton = addButton("plot", "Plot", leftMargin, posY+=ySpace);
  addButton("dorotate", "Rotate", leftMargin, posY+=ySpace);
  addButton("mirrorX","Flip X",leftMargin,posY+=ySpace);
  addButton("mirrorY","Flip Y",leftMargin,posY+=ySpace);

  posY += ySpace;
  scaleSlider = addSlider("scale", "SCALE", 0.1, 5, userScale);
  pixelSizeSlider = addSlider("pixelSlider", "PIXEL SIZE", 2, 16, pixelSize);

  penSlider = addSlider("penWidth", "PEN WIDTH", 0.1, 5, 0.5);
  penSlider.onRelease(penrelease)
    .onReleaseOutside(penrelease);        
  speedSlider = addSlider("speedChanged", "SPEED", 100, 2000, 500);
  speedSlider.onRelease(speedrelease)
    .onReleaseOutside(speedrelease);       
  addButton("penUp", "Pen Up", leftMargin, posY+=ySpace);

  addButton("goHome", "Go Home", leftMargin, posY+=ySpace);
  addButton("off", "Motors Off", leftMargin, posY+=ySpace);
  addButton("save", "Save", leftMargin, posY+=ySpace);
  addButton("export", "Export",leftMargin, posY+=ySpace);




  //console = cp5.addConsole(myTextarea);

  // myTextarea.setVisible(false);
}

CallbackListener toFront = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    theEvent.getController().bringToFront();
    ((DropdownList)theEvent.getController()).open();
  }
};

CallbackListener close = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    ((DropdownList)theEvent.getController()).close();
  }
};

CallbackListener press = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    Button b = (Button)theEvent.getController();
    if (b.getName().equals("left"))
      jog(true, -1, 0);
    else if (b.getName().equals("right"))
      jog(true, 1, 0);
    else if (b.getName().equals("up"))
      jog(true, 0, -1);
    else if (b.getName().equals("down"))
      jog(true, 0, 1);
  }
};

CallbackListener release = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    Button b = (Button)theEvent.getController();
    if (b.getName().equals("left"))
      jog(false, 0, 0);
    else if (b.getName().equals("right"))
      jog(false, 0, 0);
    else if (b.getName().equals("up"))
      jog(false, 0, 0);
    else if (b.getName().equals("down"))
      jog(false, 0, 0);
  }
};

CallbackListener speedrelease = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    setSpeed((int)speedSlider.getValue());
  }
};

CallbackListener penrelease = new CallbackListener() {
  public void controlEvent(CallbackEvent theEvent) {
    setPenWidth(penSlider.getValue());
  }
};

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.

  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    //println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    //println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());

    if ((""+theEvent.getController()).indexOf("dropListConnect") >=0)
    {
      Map m = connectDropList.getItem((int)theEvent.getController().getValue());
      println(m.get("name"));
      connect((String)m.get("name"));
    }
  }
}

void setHome()
{
  sendHome();
  updatePos(homeX, homeY);
}

void plotDone()
{
    plotButton.setCaptionLabel("Plot");
    plotButton.setImg(plotImg);
}

void fileLoaded()
{
    loadButton.setCaptionLabel("Clear");
    loadButton.setImg(clearImg);
}
void load(ControlEvent theEvent)
{
  Button b = (Button) theEvent.getController();  

  if (b.getCaptionLabel().getText().startsWith("Load"))
  {

    loadVectorFile();
  } else
  {
    clearSvg();
    clearGcode();
    clearImage();
    b.setCaptionLabel("Load");
    ((MyButton)b).setImg(loadImg);
  }
}

void plot(ControlEvent theEvent)
{
    Button b = (Button) theEvent.getController(); 
   if (b.getCaptionLabel().getText().indexOf("Step") >= 0)
   {
      if (plottingSvg)
      {
        int index = svgPathIndex;
        while(index == svgPathIndex)
          plotLine();
        
      } 
      else if (plottingImage)
        plotNextDiamondPixel();

      else if (plottingGcode)
        nextGcode();
      else
      {
        b.setCaptionLabel("Plot");
        ((MyButton)b).setImg(plotImg);
      }
   }
   else if (b.getCaptionLabel().getText().indexOf("Abort") >= 0)
    {
       b.setCaptionLabel("Plot");
      ((MyButton)b).setImg(plotImg);
    // oksend("M112\n");
     resetSvg();
     resetImage();
     resetGcode();   
    }
    else
    {  
 
    if (sh != null)
      plotSvg();
    else if (gcodeData != null)
      plotGcode();
    else if (oimg != null)
      plotDiamondImage();
      
    if(plottingSvg || plottingImage || plottingGcode)
    {
       if(myPort == null) 
           b.setCaptionLabel("Step");
       else
       {
          b.setCaptionLabel("Abort");
          ((MyButton)b).setImg(pauseImg);
       }
    }
  }
}

void dorotate()
{
  rotation += 90;
  if (rotation >= 360)
    rotation = 0;
  println("do rotate "+rotation);

  rotateSvg(rotation);
  rotateGcode(rotation);
  rotateImg();
}

void mirrorX()
{
  flipX *= -1;
  updateScale();
  flipImgX();
}
void mirrorY()
{
  flipY *= -1;
  updateScale();
  flipImgY();
}

void penUp(ControlEvent theEvent)
{
  Button b = (Button) theEvent.getController();  

  if (b.getCaptionLabel().getText().indexOf("Up") > 0)
  {
    sendPenUp();
    b.setCaptionLabel("Pen Down");
    ((MyButton)b).setImg(penDownImg);
  } else
  {
    sendPenDown();
    b.setCaptionLabel("Pen Up");
    ((MyButton)b).setImg(penUpImg);
  }
}

void goHome()
{
  sendAbsolute();

  sendPenUp();
  sendMoveG0(homeX,homeY);
  updatePos(homeX, homeY);
}

void off()
{
  sendMotorOff();
}

void save()
{
  saveProperties();
}

void export()
{
  if(sh != null)
    exportGcode();
}

void speedChanged(int speed)
{
  int s = (speed/10)*10;    
  if (s != speed)
    speedSlider.setValue(s);
}

void penWidth(float width)
{
  int w = (int)(width*10);
  float f = ((float)w)/10;   
  if (f != width)
    penSlider.setValue(f);
}

void pixelSlider(int size)
{
  // int s = (size/2)*2;

  setPixelSize(size);
  // if(s != size)
  //  pixelSizeSlider.setValue(s);
}

void scale(float scale)
{
  setuserScale(scale);

}

void jog(boolean jog, int x, int y)
{
  if (jog) {  
    sendRelative();
    jogX = x;
    jogY = y;
  } else
  {
    sendAbsolute();
    jogX = 0;
    jogY = 0;
  }
}