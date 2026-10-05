/* ***********************************************************************
 * Andre Jiao
 * Exercise 1 - Robot 1: Draw
 * Computer Science 10 | Mr. Gan - Block 1
 * Oct 4
 
 * This program is my own work - AJ   */

float px;

color bg;
float menuBarHeight;
color menuBarColor;
float toolBarHeight;
color toolBarColor;
color UIHoverColor;

float canvasWidth;
float canvasHeight;
float canvasX;
float canvasY;

boolean randomColor;
color brushColor;
float brushSize;
float brushSizeMin;
float brushSizeMax;

float brushOpacity;
float brushOpacityMin;
float brushOpacityMax;
String brushType;

boolean drawing; //store whether brush is actively drawing

boolean brushSizeDragging;
boolean brushOpacityDragging;

boolean clicked; //universal mouse click (press and release) flag
boolean pmousePressed; //store whether mouse was down previous frame

PImage selectedImage; //image that user selects for import

void settings() {
  //size(640,480);
  fullScreen();
}


void setup() {
  px = width/1920.0; //"pixel" defined relative to screen size
  bg = 230; //light gray background
  menuBarHeight = 30*px; //30px tall menu bar
  menuBarColor = bg; //same color as background
  toolBarHeight = 150*px; //100px tall toolbar
  toolBarColor = 255; //white toolbar
  UIHoverColor = 200; //default color for all buttons when hovered

  canvasWidth = width/1.4; //configure canvas width and height
  canvasHeight = height/1.4;
  canvasX = (width/2)-(canvasWidth/2); //offset canvas position using width and height so that it is centered when drawing using corners
  canvasY = ((height+menuBarHeight+toolBarHeight)/2)-(canvasHeight/2);

  //surface.setResizable(true); //make the window draggable and resizeable

  surface.setTitle("Paint by Dot");

  background(bg); //set bg

  canvas();
  //show canvas dimensions
  textSize(20*px); //set text size to 20
  textAlign(LEFT, CENTER); //center text
  fill(0); //black text
  text(round(canvasWidth)+" × "+round(canvasHeight)+"px", 200*px, height-30*px); //draw text
  
  randomColor = true; //random color on by default

  brushSize = 20*px; //set default opacity and size values
  brushSizeMin = 1*px;
  brushSizeMax = 100*px;

  brushOpacity = 255;
  brushOpacityMin = 0;
  brushOpacityMax = 255;

  brushType = "brush";
}


void draw() {
  menuBar(); //create main ui elements
  toolBar();

  coordinateDisplay(); //show cursor position relative to canvas top left

  //drawing logic
  boolean inCanvas = (mouseX+brushSize/2 >= canvasX && mouseX-brushSize/2 <= canvasX+canvasWidth && mouseY+brushSize/2 >= canvasY && mouseY-brushSize/2 <= canvasY+canvasHeight);
  drawing = (mousePressed && (drawing || inCanvas)) && !brushType.equals("eraser"); //drawing is active if mouse is down and it was active last frame OR mouse is within canvas, AND eraser is not active

  if (!drawing) {
    cursor(ARROW); //pointer cursor
    if (randomColor) {
      brushColor = color(random(255), random(255), random(255)); //assign random brush color
    }
  }
  if (inCanvas && !(brushSizeDragging || brushOpacityDragging)) { //check if brush within canvas with no UI element being dragged
    cursor(CROSS); //cross cursor
    if (mousePressed) {
      clip(canvasX, canvasY, canvasWidth, canvasHeight);
      fill(brushType.equals("eraser")? 255 : brushColor, brushOpacity); //configure fill according to brush settings
      noStroke(); //disable stroke
      ellipseMode(CENTER);
      ellipse(mouseX, mouseY, brushSize, brushSize); //draw ellipse at mouse location
      noClip();
    }
  }

  clicked = false; //reset click flag every frame
  pmousePressed = mousePressed; //set pmousePressed to current mouse press state for next frame
}

void mouseClicked() {
  clicked = true; //set a flag because mouseClicked itself is not a boolean
};

void menuBar() {
  rectMode(CORNER); //draw rectangle using corner
  noStroke(); //no outline
  fill(menuBarColor); //set color
  rect(0, 0, width, menuBarHeight); //draw rectangle along top of window
  //create "AndrePaint" name
  fill(0); //set text color
  textSize(20*px); //set text size
  textAlign(LEFT, CENTER); //left-align text
  text("AndrePaint", 20*px, menuBarHeight/2); //draw text
  button(130*px, menuBarHeight*0.1, 70*px, menuBarHeight*0.8, "Save", 0, 15*px, menuBarColor, UIHoverColor, this::saveImage); //create save button
  button(200*px, menuBarHeight*0.1, 70*px, menuBarHeight*0.8, "Import", 0, 15*px, menuBarColor, UIHoverColor, this::importImage); //create import button
  button(width-50*px, 0, 50*px, menuBarHeight, "×", 0, 40*px, menuBarColor, color(200, 50, 50), this::exit); //create exit button
}


void toolBar() { //create toolbar--lateral padding 30px
  rectMode(CORNER); //draw rectangle using corner
  noStroke(); //no outline
  fill(toolBarColor); //set color
  rect(0, menuBarHeight, width, toolBarHeight); //draw rectangle just below menu bar

  noStroke(); //no outline
  button(30*px, menuBarHeight+toolBarHeight*0.25, 70*px, toolBarHeight*0.5, "CLEAR", 0, 20*px, toolBarColor, UIHoverColor, this::canvas);  //create clear button
  stroke(0); //black outline
  line(130*px, menuBarHeight, 130*px, menuBarHeight+toolBarHeight); //create divider

  //brush preview label
  fill(0); //set text color
  textSize(20*px); //set text size
  textAlign(CENTER, CENTER); //center-align text
  text("Current Tool", 210*px, menuBarHeight+toolBarHeight*0.15); //draw text
  //create brush preview
  ellipseMode(CENTER); //draw ellipse using center point
  stroke(0); //black outline
  fill(brushType.equals("eraser")? 255 : brushColor, brushOpacity);
  ellipse(210*px, menuBarHeight+toolBarHeight*0.6, brushSize, brushSize);
  line(290*px, menuBarHeight, 290*px, menuBarHeight+toolBarHeight); //create divider


  stroke(0); //black outline
  toolSizeSlider(320*px, menuBarHeight+toolBarHeight/3, 200*px, 0, UIHoverColor, "Tool Size", 20*px); //create brush size slider
  toolOpacitySlider(320*px, menuBarHeight+toolBarHeight/1.4, 200*px, 0, UIHoverColor, "Opacity", 20*px); //create opacity slider
  line(570*px, menuBarHeight, 570*px, menuBarHeight+toolBarHeight); //create divider
  
  //tool selector label
  fill(0); //set text color
  textSize(20*px); //set text size
  textAlign(CENTER, CENTER); //center-align text
  text("Tool", 635*px, menuBarHeight+toolBarHeight*0.15); //draw text
  
  noStroke(); // no outline
  button(600*px, menuBarHeight+toolBarHeight*0.3, 70*px, toolBarHeight*0.28, "", 0, 20*px, brushType.equals("brush")? UIHoverColor: toolBarColor, UIHoverColor, () -> {
    brushType = "brush";
  }
  );  //select brush button
  button(600*px, menuBarHeight+toolBarHeight*0.65, 70*px, toolBarHeight*0.28, "", 0, 50*px, brushType.equals("eraser")? UIHoverColor: toolBarColor, UIHoverColor, () -> {
    brushType = "eraser";
  }
  ); //select eraser button


  //draw brush icon
  stroke(0); //no outline
  pushMatrix();
  translate(635*px, menuBarHeight+toolBarHeight*0.3+toolBarHeight*0.25/2);
  rotate(radians(-20));
  fill(0); //black handle
  beginShape(); //tapered handle
  vertex(-15*px, -5*px);
  vertex(25*px, -3*px);
  vertex(25*px, 3*px);
  vertex(-15*px, 5*px);
  endShape(CLOSE);

  fill(192, 192, 192); //silver ferrule
  beginShape(); //tapered ferrule
  vertex(-15*px, -5*px);
  vertex(-5*px, -4*px);
  vertex(-5*px, 4*px);
  vertex(-15*px, 5*px);
  endShape(CLOSE);

  fill(brushColor, brushOpacity); // bristles follow brush color
  beginShape(); //bristles
  vertex(-25*px, -brushSize/10);
  vertex(-15*px, -5*px);
  vertex(-15*px, 5*px);
  vertex(-25*px, brushSize/10);
  endShape(CLOSE);
  popMatrix();

  //draw eraser icon
  stroke(0); //black outline
  pushMatrix();
  translate(635*px, menuBarHeight+toolBarHeight*0.65+toolBarHeight*0.25/2);
  rotate(radians(-20));
  fill(255);
  rectMode(CENTER);
  rect(0, 0, 40*px, 20*px);
  fill(0);
  rect(-15*px, 0, 10*px, 20*px);
  popMatrix();

  stroke(0); //black outline
  line(700*px, menuBarHeight, 700*px, menuBarHeight+toolBarHeight); //create divider
  
  //color selector lable
  fill(0); //set text color
  textSize(20*px); //set text size
  textAlign(CENTER, CENTER); //center-align text
  text("Colors", 987.5*px, menuBarHeight+toolBarHeight*0.15); //draw text
  //create color selector
  stroke(0); //black outline
  button(730*px, menuBarHeight+toolBarHeight*0.35, 80*px, toolBarHeight*0.5, "Random", 0, 20*px, randomColor? UIHoverColor: toolBarColor, UIHoverColor, () -> {
    randomColor = true;
  }
  );  //create random color button
  //create 3 rows of color options
  color[] rainbow = {
    color(255, 0, 0), //red
    color(255, 255, 0), //yellow
    color(0, 255, 0), //green
    color(0, 255, 255), //cyan
    color(0, 0, 255), //blue
    color(255, 0, 255) //magenta
  };
  
  for (int i = 0; i < 15; i++) { //15 columns
  
    float colorProgress = i / 14.0; //horizontal position in the matrix as a decimal 0-1
  
    //determine lower bounding color row from the above table
    float colorProgressScaled = colorProgress * (rainbow.length - 1); //take decimal value and see where it falls on the 6 rows
    int low = floor(colorProgressScaled); //round down to previous row
  
    //prevent going past the last row
    if (low >= rainbow.length - 1) {
      low = rainbow.length - 2;
    }
  
    float tableRowProgress = colorProgressScaled - low; //see where the color falls between the 2 rows
  
    final color c = lerpColor( //create the color by blending between rows
      rainbow[low],
      rainbow[low + 1],
      tableRowProgress
    );
  
  
    //row 1: normal rainbow colors
    button(840*px+i*30*px, menuBarHeight+toolBarHeight*0.3, 20*px, 20*px, "", 0, 20*px, c, c, () -> {
        randomColor = false;
        brushColor = c;
      }
    );
  
    //row 2: lighter colors
    final color lightC = lerpColor(c, color(255), 0.35);
    button(840*px+i*30*px, menuBarHeight+toolBarHeight*0.54, 20*px, 20*px, "", 0, 20*px, lightC, lightC, () -> {
        randomColor = false;
        brushColor = lightC;
      }
    );
  
    //row 3: very light colors
    final color veryLightC = lerpColor(c, color(255), 0.65);
    button(840*px+i*30*px, menuBarHeight+toolBarHeight*0.78, 20*px, 20*px, "", 0, 20*px, veryLightC, veryLightC, () -> {
        randomColor = false;
        brushColor = veryLightC;
      }
    );
  }
}


void canvas() {
  rectMode(CORNER); //draw rectangle using corner
  noStroke(); //no outline
  fill(255); //white canvas
  rect(canvasX, canvasY, canvasWidth, canvasHeight);
}

void coordinateDisplay() {
  //show x and y coordinates relative to canvas top left
  rectMode(CORNER); //draw rectangle using corner
  noStroke(); //disable stroke
  fill(bg); //blend with background
  rect(0, height-50*px, 200*px, 50*px); //create a rectangle in the bottom left that redraws every frame
  fill(0); //set text color to black
  textSize(20*px); //set text size to 20
  textAlign(LEFT, CENTER); //center text
  if (mouseX >= canvasX && mouseX <= canvasX+canvasWidth && mouseY >= canvasY && mouseY <= canvasY+canvasHeight) { //check if cursor within canvas
    text("x: " + round(mouseX-canvasX) + " y: " + round(mouseY-canvasY), 30*px, height-30*px); //draw text
  }
  println("x: " + round(mouseX-canvasX) + " y: " + round(mouseY-canvasY)); //print to console
}

void button(float x, float y, float bwidth, float bheight, String btext, color btextColor, float btextSize, color bfill, color bhoverFill, Runnable bcallback) { //custom button maker function
  rectMode(CORNER); //draw rectangle using corner
  boolean hovering = mouseX >= x && mouseX <= x + bwidth && mouseY >= y && mouseY <= y + bheight; //checks if mouse is inside button

  fill(hovering? bhoverFill: bfill); //fill hover color if hovering over button, otherwise fill default color

  if (clicked && hovering) {
    bcallback.run();
    clicked = false; //clear the flag as soon as one button is triggered
  }

  rect(x, y, bwidth, bheight, 10*px); //draw button

  fill(btextColor); //set text color
  textSize(btextSize); //set text size
  textAlign(CENTER, CENTER); //center text
  text(btext, x + (bwidth / 2), y + (bheight / 2)); //draw text
}

void toolSizeSlider(float x, float y, float slength, color scolor, color shoverColor, String stext, float stextSize) {
  rectMode(CORNER); //draw rectangle using corner
  ellipseMode(RADIUS); //draw ellipses using center and radius
  float trackHeight = 5*px; //sets thickness of slider track
  float dotRad = 10*px; //sets radius of slider dot


  fill(scolor); //use slider color for all elements of slider
  rect(x, y, slength, trackHeight); //draw slider track
  textSize(stextSize); //set text size
  textAlign(LEFT, CENTER); //center text
  text(stext, x+10*px, y-25*px); //draw text

  boolean hovering = mouseX >= x && mouseX <= x+slength && mouseY >= (y+trackHeight/2)-dotRad && mouseY <= (y+trackHeight/2)+dotRad; //checks if mouse is inside slider dot or on slider track
  fill(hovering? shoverColor: scolor); //fill hover color if hovering over slider dot, otherwise fill default color

  float brushSizeProgress = map(brushSize, brushSizeMin, brushSizeMax, 0, slength); //position dot on track based on value of brushSize


  if ((hovering || brushSizeDragging ) && mousePressed && (!pmousePressed || brushSizeDragging )) { //check if mouse is or had been pressed while hovering
    brushSizeProgress = constrain(mouseX-x, 0, slength); //slider dot follows mouse
    brushSizeDragging = true; //allows slider dot to follow mouse even if not hovering provided it had been hovering when pressed and is still pressed
    fill(shoverColor); //fill slider dot with hover color whenever it is being moved
  }

  if (!mousePressed) brushSizeDragging = false; //stop following mouse once released

  ellipse(x+brushSizeProgress, y+trackHeight/2, dotRad, dotRad); //draw slider dot and center vertically on slider track

  brushSize = map(brushSizeProgress, 0, slength, brushSizeMin, brushSizeMax); //map position on track back to brushSize
}


void toolOpacitySlider(float x, float y, float slength, color scolor, color shoverColor, String stext, float stextSize) {
  rectMode(CORNER); //draw rectangle using corner
  ellipseMode(RADIUS); //draw ellipses using center and radius
  float trackHeight = 5*px; //sets thickness of slider track
  float dotRad = 10*px; //sets radius of slider dot


  fill(scolor); //use slider color for all elements of slider
  rect(x, y, slength, trackHeight); //draw slider track
  textSize(stextSize); //set text size
  textAlign(LEFT, CENTER); //center text
  text(stext, x+10*px, y-25*px); //draw text

  boolean hovering = mouseX >= x && mouseX <= x+slength && mouseY >= (y+trackHeight/2)-dotRad && mouseY <= (y+trackHeight/2)+dotRad; //checks if mouse is inside slider dot or on slider track
  fill(hovering? shoverColor: scolor); //fill hover color if hovering over slider dot, otherwise fill default color

  float brushOpacityProgress = map(brushOpacity, brushOpacityMin, brushOpacityMax, 0, slength); //position dot on track based on value of brushOpacity

  if ((hovering || brushOpacityDragging ) && mousePressed && (!pmousePressed || brushOpacityDragging )) { //check if mouse is or had been pressed while hovering
    brushOpacityProgress = constrain(mouseX-x, 0, slength); //slider dot follows mouse
    brushOpacityDragging = true; //allows slider dot to follow mouse even if not hovering provided it had been hovering when pressed and is still pressed
    fill(shoverColor); //fill slider dot with hover color whenever it is being moved
  }

  if (!mousePressed) brushOpacityDragging = false; //stop following mouse once released

  ellipse(x+brushOpacityProgress, y+trackHeight/2, dotRad, dotRad); //draw slider dot and center vertically on slider track

  brushOpacity = map(brushOpacityProgress, 0, slength, brushOpacityMin, brushOpacityMax); //map position on track back to brushOpacity
}

void saveImage() { //allow user to export their drawing
  selectOutput("Save canvas as:", "saveFileSelected"); //prompt
}

void saveFileSelected(File selection) {
  if (selection == null) return; //handle no selection
  String path = selection.getAbsolutePath();

  if (!path.toLowerCase().endsWith(".png") &&
    !path.toLowerCase().endsWith(".jpg") &&
    !path.toLowerCase().endsWith(".jpeg") &&
    !path.toLowerCase().endsWith(".tif")) {
    path += ".png"; //append .png if no other valid extension
  }

  PImage region = get(int(canvasX), int(canvasY), int(canvasWidth), int(canvasHeight)); //define canvas as area to save
  region.save(path); //save
}

void importImage() {
  selectInput("Select an image:", "importFileSelected");
}

void importFileSelected(File selection) {
  if (selection == null) return; //handle no selection
  String path = selection.getAbsolutePath();
  
    if (!path.toLowerCase().endsWith(".png") ||
    path.toLowerCase().endsWith(".jpg") ||
    path.toLowerCase().endsWith(".jpeg") ||
    path.toLowerCase().endsWith(".tif")) {
    selectedImage = loadImage(selection.getAbsolutePath()); //if file type valid, set selectedImage to that file
    
    float scale = min( //fit canvas lengthwise or widthwise, whichever dimension is bigger in the image
      (float)canvasWidth / selectedImage.width,
      (float)canvasHeight / selectedImage.height
    );
    image(selectedImage, canvasX+(canvasWidth-selectedImage.width*scale)/2, canvasY+(canvasHeight-selectedImage.height*scale), selectedImage.width*scale, selectedImage.height*scale //place and center image on canvas
    );
  }
}
