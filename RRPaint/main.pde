
/* ***********************************************************************
* Full Name: Rayansh Rathi
* Assignment Name: Computer Science 10 Block 1A/B
* Class: Computer Science 10 Block 1A/B
* Date Completed: October 4, 2026

* This program is my own work - RR */


//CODE:

/*PLAN:
    - Make Screen
      - ALL CENTERED TO SCREEN SIZE (100%)
     
      - Home Screen
        - Introduction
        - Creative Button with explanation
        - Realistic Button with explanation
        - Preferences/Settings
        - Load/Upload
      - Creative Screen
      - Realistic Screen
    - TWO Passages (GUI for it)
      - Creative
        - Random Colors
          - UPDATE ONLY WHEN MOUSE NOT PRESSED
        - Choose size
        - Eraser Choice
        - Override Colors/Size is a possibility (Switch to realistic)
      - Realistic
        - Color Choice
          - REAL-TIME FEEDBACK/DISPLAY
          - Color shades
        - Size Choice
          - Slider Adjustability with real-time feedback/display
        - Transparency
          - Sliders Adjustability with real-time feedback/display
        - Eraser Choice
        - Clear All
        - Switch to Creative
    - Buttons Required
      - Save
      - Load
      - Help
      - Themes/Settings
    - Data to show
      - MouseX/Y
      - Brush Size
     
    - OPTIONAL:
      - Layering of Stuff
      - Different Brush Types
      - Select and Move Feature
        - Select and Remove Feature
      - Keyboard Shortcuts
      - Top Strip with application name etc.

CODING BASES:

SIZE = 1980 x 1080 of Screen coded on                          ***********     IT SHOULD WORK ON ANY SCREEN SIZE HOWEVER     ****************



*/



//Initialize Variables



int x; //Looks for MouseX
int y; //Looks for MouseY

int ellipses = 0;
boolean painting = false;

color bg = color(215); //Background Color

String userPosition = "Home"; //OTHER OPTIONS: Creative/Realistic/Home
String dominantHand = "Right"; //Other options: Right/Left

PGraphics drawingLayer; //Stores ONLY the artwork and prevents UI from being captured
PImage uploadImage;

int loop = 0;




//ART VARIABLES

color brushColor; //Defines the color of brush
float brushSize; //Defines the size of brush
float transparency = 255; //Defines the transparency of brush
boolean eraserActive = false; //Sees if eraser is active or not
String currentBrush = "Normal";




//INITIALIZATION OF CANVAS VARIABLES

boolean initializedCanvas = false; //Makes sure the canvas does not continously erase work
boolean firstInitialization = false; //REMOVES THE FIRST DOT RIGHT AFTER INITIALIZED
boolean pendingHandSwitch = false; //Makes sure hand switching happens after Preferences closes




//EXIT BUTTON VARIABLES

color EB_Red = color(200, 50, 50); //Hover Color
color EB_Normal = 190; //Non-hover color is background color to blend

float[] EB_rectangleButton; //Initialize list for exit button dimensions





//HOME PAGE VARIABLES

float[] HP_title; //TITLE OF PROGRAM DIMENSIONS
float HP_bottomValue; // Seperates title from rest of text

color HP_Normal = color(255); //NORMAL COLOR FOR THE BOXES

float[] HP_realisticButton; //BUTTON DIMENSIONS
float[] HP_creativeButton;

int cornerSoftner = 20; //Softens the corner of the boxes







//Creative Canvas Variables

float[] canvas; //Makes canvas
float[] canvasRight; //Makes canvas
float[] canvasLeft; //Makes canvas
float[] toolBar; //Makes side toolbar
float[] toolBarRight; //Makes side toolbar
float[] toolBarLeft; //Makes side toolbar






//SLIDER VARIABLES

float[] slider_brushSize_C;
float[] slider_brushSize_C_Right;
float[] slider_brushSize_C_Left;
float[] slider_transparency_C;
float[] slider_transparency_C_Right;
float[] slider_transparency_C_Left;

HashMap<String, FloatList> sliderDisplacement = new HashMap<String, FloatList>();





//Eraser Variables

float[] brush_dimensions;
float[] brush_dimensions_Right;
float[] brush_dimensions_Left;
boolean brushes_active = false;
boolean brushes_button_pressed = false;
String[] brushTypes;
float[] brush_box_dimensions;
PImage behindBox;
boolean resetArea = false;

float[] eraser_dimensions;
float[] eraser_dimensions_Right;
float[] eraser_dimensions_Left;

float[] paint_dimensions;
float[] paint_dimensions_Right;
float[] paint_dimensions_Left;





//TEXT BOX VARIABLES

boolean hoverTextBox = false;
boolean textBoxMode = false;





//Color Picker Variables

float[] gradientBox;
float[] gradientBoxRight;
float[] gradientBoxLeft;

float[] gradientTextBox;
float[] gradientTextBoxRight;
float[] gradientTextBoxLeft;

PImage gradient;
float[] slider_brightness;
float[] slider_brightness_Right;
float[] slider_brightness_Left;


boolean color_active = false;
boolean color_button_active = false;
PImage behindBox2;
color[] colorPalette;
float[] colorPalette_size;
float[] colorPalette_size_Right;
float[] colorPalette_size_Left;
float[] colorPalette_box_size;
int perRow = 5;


float brush_hue;
float brush_saturation;
float brush_brightness;

String colorNotation = "RGB";

float[] addColor_box_size;
float[] addColor_box_size_Right;
float[] addColor_box_size_Left;

boolean addColor_pressed = false;
int messagetime = 0;
boolean duplicatesRemoved = false;
int messagetime2 = 0;

float[] colorShow_dimensions;
float[] colorShow_dimensions_Right;
float[] colorShow_dimensions_Left;


//Navigator C <-> R Variables

float[] navigatorCR_switchBox;
float[] navigatorCR_switchBox_Right;
float[] navigatorCR_switchBox_Left;
boolean transitioned = false;





//Preferences 

float[] preferences_open_dimensions;

PImage behindBox_preferences;

boolean preferences_open = false;
boolean preferences_pressed = false;

float[] preferences_switchBox;
float[] preferences_switchBox2;

float[] preferences_button_dimensions;
float[] save_button_dimensions;
float[] upload_button_dimensions;

boolean upload_pressed = false;



//Clear All button
float[] clearAll_button_dimensions;
float[] clearAll_button_dimensions_Right;
float[] clearAll_button_dimensions_Left;


//Undo Button Variables
float[] undoButton_dimensions;
float[] undoButton_dimensions_Right;
float[] undoButton_dimensions_Left;

class PixelDelta {
  int index;
  color oldColor;

  PixelDelta(int index, color oldColor) {
    this.index = index;
    this.oldColor = oldColor;
  }
}

ArrayList<ArrayList<PixelDelta>> undoStack = new ArrayList<ArrayList<PixelDelta>>();
ArrayList<PixelDelta> currentDelta = null;
HashMap<Integer, Boolean> changedPixels = new HashMap<Integer, Boolean>();

boolean drawingStroke = false;
boolean clear_pressed = false;
int maxUndo = 50;

boolean undoButton_pressed = false;


//Application Tool Bar
float[] appBar_dimensions; 

//Save Function Variables
boolean save_pressed = false;
String saveMessage = "";
int saveMessageTimer = 0;


//Coords dimensions

float [] coord_dimensions;
float [] coord_dimensions_Right;
float [] coord_dimensions_Left;





//Functions:




//Setup

void setup() {
 
  fullScreen(); // Full sizes the program
  //size(1280, 720); //TESTING
 
  frameRate(120);
 
  //windowResizable(true); //gives more flexibility to user
 
  background(bg); //sets background
 
  rectMode(CORNERS); //Makes rect() as rect(x1, y1, x2, y2)
  println(width); //TESTING
  println(height);
 
  noStroke(); //Removes borders on shapes
 
  PFont font = createFont("SansSerif", 12);
  textFont(font);
  
  
  
  
  //EXIT BUTTON:
  EB_rectangleButton = new float[] {
    width * 0.965,
    0,
    width,
    height * 0.0345
  }; //proportionalize exit button dimensions
 
 
 
 
 
  //HOME PAGE:
  HP_title = new float[] {//Title Dimensions
    width * 0.5,
    height * 0.07
  };
 
  HP_realisticButton = new float[] { //Button Dimensions
    width * 0.15,
    height * 0.3,
    width * 0.45,
    height * 0.9
  };
 
  HP_creativeButton = new float[] {
    width * 0.55,
    height * 0.3,
    width * 0.85,
    height * 0.9
  };
 
  HP_bottomValue = height * 0.4; // Seperator dimensions
 
 
 
 
 
  //Creative Page:
  canvas = new float[] { //Canvas dimensions
    width * 0.23,
    height * 0.05,
    width * 0.98,
    height * 0.94
  };
 
  canvasRight = new float[] { //Canvas dimensions
    width * 0.23,
    height * 0.05,
    width * 0.98,
    height * 0.94
  };
 
  canvasLeft = new float[] {
    width * 0.02,
    height * 0.05,
    width * 0.77,
    height * 0.94
  };
  
 
  toolBar = new float[] { //toolbar dimensions
    width * 0.02,
    height * 0.05,
    width * 0.21,
    height * 0.94
  };
  
  toolBarRight = new float[] { //toolbar dimensions
    width * 0.02,
    height * 0.05,
    width * 0.21,
    height * 0.94
  };
  
  toolBarLeft = new float[] { //toolbar dimensions
    width * 0.79,
    height * 0.05,
    width * 0.98,
    height * 0.94
  };
 
 
 
 
  //Create Artwork Layer
  //The artwork layer contains ONLY the drawing and never contains the UI.

  drawingLayer = createGraphics(
    round(canvasRight[2] - canvasRight[0]),
    round(canvasRight[3] - canvasRight[1])
  );

  drawingLayer.beginDraw();
  drawingLayer.background(255);
  drawingLayer.endDraw();

 
 
 
  //SLIDER CREATION for Brush Size:
  slider_brushSize_C = new float[] {
    width * 0.04,
    height * 0.115,
    width * 0.14,
    height * 0.12
  };
  
  slider_brushSize_C_Right = new float[] {
    width * 0.04,
    height * 0.115,
    width * 0.14,
    height * 0.12
  };
  
  slider_brushSize_C_Left = new float[] {
    width * 0.81,
    height * 0.115,
    width * 0.91,
    height * 0.12
  };
 
  FloatList brushSize_C_List = new FloatList();
  brushSize_C_List.append(
    map(
      25,
      3,
      50,
      0,
      slider_brushSize_C[2] - slider_brushSize_C[0]
    )
  );
  brushSize_C_List.append(0.0);
 
  sliderDisplacement.put("brushSize_C", brushSize_C_List);
 
 
 
 
  //Slider Creation for Transparency:
  slider_transparency_C = new float[] {
    width * 0.04,
    height * 0.225,
    width * 0.14,
    height * 0.23
  };
  
  slider_transparency_C_Right = new float[] {
    width * 0.04,
    height * 0.225,
    width * 0.14,
    height * 0.23
  };
  
  slider_transparency_C_Left = new float[] {
    width * 0.81,
    height * 0.225,
    width * 0.91,
    height * 0.23
  };
 
  FloatList transparency_C_List = new FloatList();
  transparency_C_List.append(
    map(
      100,
      0,
      100,
      0,
      slider_transparency_C[2] - slider_transparency_C[0]
    )
  );
  transparency_C_List.append(0.0);
 
  sliderDisplacement.put("transparency_C", transparency_C_List);
 
 
 
 
  //Eraser Variables
 
  paint_dimensions = new float[] {
    width * 0.04,
    height * 0.57 + (width * 0.15),
    width * 0.085,
    height * 0.57 + (width * 0.195)
  };
  
  paint_dimensions_Right = new float[] {
    width * 0.04,
    height * 0.57 + (width * 0.15),
    width * 0.085,
    height * 0.57 + (width * 0.195)
  };
  
  paint_dimensions_Left = new float[] {
    width * 0.81,
    height * 0.57 + (width * 0.15),
    width * 0.855,
    height * 0.57 + (width * 0.195)
  };
 
  eraser_dimensions = new float[] {
    width * 0.095,
    height * 0.57 + (width * 0.15),
    width * 0.14,
    height * 0.57 + (width * 0.195)
  };
  
  eraser_dimensions_Right = new float[] {
    width * 0.095,
    height * 0.57 + (width * 0.15),
    width * 0.14,
    height * 0.57 + (width * 0.195)
  };
  
  eraser_dimensions_Left = new float[] {
    width * 0.865,
    height * 0.57 + (width * 0.15),
    width * 0.91,
    height * 0.57 + (width * 0.195)
  };
 
  //Color Picker Variables
 
  gradientBox = new float[] {
    width * 0.04,
    height * 0.43,
    width * 0.19,
    height * 0.43 + (width * 0.15)
  };
  
  gradientBoxRight = new float[] {
    width * 0.04,
    height * 0.43,
    width * 0.19,
    height * 0.43 + (width * 0.15)
  };
  
  gradientBoxLeft = new float[] {
    width * 0.81,
    height * 0.43,
    width * 0.96,
    height * 0.43 + (width * 0.15)
  };
  
  colorShow_dimensions = new float[] {
    width * 0.04,
    height * 0.49 + (width * 0.15),
    width * 0.19, 
    height * 0.55 + (width * 0.195),
  };
  
  colorShow_dimensions_Right = new float[] {
    width * 0.04,
    height * 0.49 + (width * 0.15),
    width * 0.19, 
    height * 0.55 + (width * 0.195),
  };
  
  colorShow_dimensions_Left = new float[] {
    width * 0.81,
    height * 0.49 + (width * 0.15),
    width * 0.96, 
    height * 0.55 + (width * 0.195),
  };
  
  gradientTextBox = new float[] {
    width * 0.04,
    height * 0.45,
    width * 0.19,
    height * 0.47
  };
  
  gradientTextBoxRight = new float[] {
    width * 0.04,
    height * 0.45,
    width * 0.19,
    height * 0.47
  };
  
  gradientTextBoxLeft = new float[] {
    width * 0.81,
    height * 0.45,
    width * 0.96,
    height * 0.47
  };
  
  
  colorPickerOnce();
  
  colorMode(RGB, 255);
  
  colorPalette = new color[] {
    color(255, 255, 255),
    color(128, 128, 128),
    color(0, 0, 0),
    color(255, 0, 0),
    color(255, 165, 0),
    color(255, 255, 0),
    color(0, 128, 0),
    color(0, 0, 255),
    color(255, 192, 203),
    color(128, 0, 128)
  };
  
  colorPalette_box_size = new float[] {
    width * 0.017,
    height * 0.031167
  };
  
  addColor_box_size = new float[] {
    width * 0.04,
    height * 0.44 + (width * 0.15),
    width * 0.19,
    height * 0.48 + (width * 0.15)
  };
  addColor_box_size_Right = new float[] {
    width * 0.04,
    height * 0.44 + (width * 0.15),
    width * 0.19,
    height * 0.48 + (width * 0.15)
  };
  addColor_box_size_Left = new float[] {
    width * 0.81,
    height * 0.44 + (width * 0.15),
    width * 0.96,
    height * 0.48 + (width * 0.15)
  };
  
  
  
  //Slider Creation for Brightness of Colors:
  
  slider_brightness = new float[] {
    width * 0.04,
    height * 0.335,
    width * 0.14,
    height * 0.34
  };
  
  slider_brightness_Right = new float[] {
    width * 0.04,
    height * 0.335,
    width * 0.14,
    height * 0.34
  };
  
  slider_brightness_Left = new float[] {
    width * 0.81,
    height * 0.335,
    width * 0.91,
    height * 0.34
  };
  
  FloatList brightness_List = new FloatList();
  brightness_List.append(
    map(
      100,
      0,
      100,
      0,
      slider_brightness[2] - slider_brightness[0]
    )
  );
  brightness_List.append(0.0);
 
  sliderDisplacement.put("brightness", brightness_List);
  
  
  
  
  
  //Navigator C <-> R Varibales 
  
  navigatorCR_switchBox = new float[] {
    width * 0.04,
    height * 0.95,
    width * 0.19,
    height * 0.985
  };
  
  navigatorCR_switchBox_Right = new float[] {
    width * 0.04,
    height * 0.95,
    width * 0.19,
    height * 0.985
  };
  
  navigatorCR_switchBox_Left = new float[] {
    width * 0.81,
    height * 0.95,
    width * 0.96,
    height * 0.985
  };
  
  
  
  
  
  //Preferences Variables
  
  preferences_open_dimensions = new float[] {
    width * 0.25,
    height * 0.25,
    width * 0.75,
    height * 0.75
  };
  
  preferences_button_dimensions = new float[] {
    width * 0.03,
    0,
    width * 0.1,
    height * 0.0345
  };
  
  save_button_dimensions = new float[] {
    width * 0.11,
    0,
    width * 0.18,
    height * 0.0345
  };
  
  upload_button_dimensions = new float[] {
    width * 0.19,
    0,
    width * 0.26,
    height * 0.0345
  };
  
  preferences_switchBox = new float[] {
    width * 0.59,
    height * 0.33,
    width * 0.74,
    height * 0.38
  };
  
  preferences_switchBox2 = new float[] {
    width * 0.59,
    height * 0.43,
    width * 0.74,
    height * 0.48
  };
  
  
  
  //Clear All Variables
  clearAll_button_dimensions = new float[] {
    width * 0.90,
    height * 0.95,
    width * 0.98,
    height * 0.985
  };
  
  clearAll_button_dimensions_Right = new float[] {
    width * 0.90,
    height * 0.95,
    width * 0.98,
    height * 0.985
  };
  
  clearAll_button_dimensions_Left = new float[] {
    width * 0.02,
    height * 0.95,
    width * 0.10,
    height * 0.985
  };
  
  undoButton_dimensions = new float[] {
    width * 0.80,
    height * 0.95,
    width * 0.88,
    height * 0.985
  };
  
  undoButton_dimensions_Right = new float[] {
    width * 0.80,
    height * 0.95,
    width * 0.88,
    height * 0.985
  };
  
  undoButton_dimensions_Left = new float[] {
    width * 0.12,
    height * 0.95,
    width * 0.20,
    height * 0.985
  };
  
  
  //Application Variables
  
  appBar_dimensions = new float[] {
    0,
    0,
    width,
    height * 0.0345
  };
  
  coord_dimensions = new float[] {
    width * 0.23,
    height * 0.945,
    width * 0.70,
    height * 0.99
  };
  
  coord_dimensions_Right = new float[] {
    width * 0.23,
    height * 0.945,
    width * 0.70,
    height * 0.99
  };
  
  coord_dimensions_Left = new float[] {
    width * 0.38,
    height * 0.945,
    width * 0.77,
    height * 0.99
  };
  
  colorPalette_size = new float[] { //Creates box size for the pre-set colors
    width * 0.21,
    gradientBox[1] - height * 0.05,
    width * 0.21 + (perRow * (colorPalette_box_size[0]) + (perRow + 1) * (width * 0.015)),
    (gradientBox[1] - height * 0.05) +
    ((ceil((float)colorPalette.length / perRow)) * colorPalette_box_size[1] +
    (((ceil((float)colorPalette.length / perRow) + 1) * (height * 0.02778))))
  };
  
}





//Loop

void draw() {
 
  x = mouseX; //LOOKS FOR MOUSE X/Y
  y = mouseY;
  
  
  colorPalette_size_Right = new float[] {
    width * 0.21,
    gradientBox[1] - height * 0.05,
    width * 0.21 + (perRow * colorPalette_box_size[0] +
        (perRow + 1) * (width * 0.015)),
    (gradientBox[1] - height * 0.05) +
    ((ceil((float)colorPalette.length / perRow)) * colorPalette_box_size[1] +
    ((ceil((float)colorPalette.length / perRow) + 1) * (height * 0.02778)))
  };

  colorPalette_size_Left = new float[] {
    width * 0.79 - (perRow * colorPalette_box_size[0] +
        (perRow + 1) * (width * 0.015)),
    gradientBox[1] - height * 0.05,
    width * 0.79,
    (gradientBox[1] - height * 0.05) +
    ((ceil((float)colorPalette.length / perRow)) * colorPalette_box_size[1] +
    ((ceil((float)colorPalette.length / perRow) + 1) * (height * 0.02778)))
  };




 
  leftRightHand();
  canvasBorder();
  
  if (userPosition == "Home") {
    homePage();
  }
 
  else if (userPosition == "Creative") {
    creativePage();
  }
 
  else if (userPosition == "Realistic") {
    realisticPage();
  }
  
 
  else {
  
    background(bg);
 
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(250);
   
    text("ERROR 404", width/2, height /2);
   
  }
  
 
  if (!mousePressed && drawingStroke) {
    finishUndoStroke();
  }
  
  cursorChange();
  
  if (saveMessageTimer > 0) { //Makes Saved message
    fill(0, 180);
    textAlign(CENTER, CENTER);
    textSize(18);
  
    text(
      saveMessage,
      width / 2,
      height * 0.97
    );
  
    saveMessageTimer--;
  }

}





//PAGE FUNCTIONS:


//HOME PAGE FUNCTION

void homePage() {
 
  String page_title = "Rayansh's Paint Software";
  float pageTitle_fontSize = 58;
 
  float scaleFactor_realistic;
  float scaleFactor_creative;
 
  float title_fontSize = 22;
  float text_fontSize = 17;
 
  String realistic_title = "Realistic Mode";
  String creative_title = "Creative Mode";
 
  String realistic_description = "Realistic Mode is a mode in which you may: \n \n 1. Draw anything you wish \n \n 2. Draw with complete control over all aspects including Color, Brush Size, Opacity, Transparency, etc. \n \n 3. Best for planned or artistic drawing, including the oppurtunity to draw realistic paintings \n \n 4. Can switch to Creative Mode at anytime without losing your work!";
  
  String creative_description = "Creative Mode is a mode in which you may: \n \n 1. Draw anything you wish \n \n 2. Draw with RANDOMIZED Colors, increasing creativity \n \n 3. Draw with control over certain aspects like Brush Size, Opacity, and Transparency \n \n 4. Best for looking for ideas for a new realistic project and Abstract pieces \n \n 5. Can switch to Realistic Mode at anytime without losing your work!";
 
  background(bg);
  exitButton();
 
  textAlign(CENTER, CENTER);
 
  textSize(pageTitle_fontSize);
  text(page_title, HP_title[0], HP_title[1]);
 
 
  if (x >= HP_realisticButton[0] && y >= HP_realisticButton[1] && x <= HP_realisticButton[2] && y <= HP_realisticButton[3]) {
    scaleFactor_realistic = 1.05;
    
    if (mousePressed) {
      userPosition = "Realistic";
    }
  }
  
  else {
    scaleFactor_realistic = 1.00;
  }
  
  
 
  if (x >= HP_creativeButton[0] && y >= HP_creativeButton[1] && x <= HP_creativeButton[2] && y <= HP_creativeButton[3]) {
    scaleFactor_creative = 1.05;
    
    if (mousePressed) {
      userPosition = "Creative";
    }
  }
  
  else {
    scaleFactor_creative = 1.00;
  }
  
  
 
  fill(HP_Normal);
 
 
  rect(
    HP_realisticButton[0] / scaleFactor_realistic,
    HP_realisticButton[1] / scaleFactor_realistic,
    HP_realisticButton[2] * scaleFactor_realistic,
    HP_realisticButton[3] * scaleFactor_realistic,
    cornerSoftner
  );
 
 
  rect(
    HP_creativeButton[0] / scaleFactor_creative,
    HP_creativeButton[1] / scaleFactor_creative,
    HP_creativeButton[2] * scaleFactor_creative,
    HP_creativeButton[3] * scaleFactor_creative,
    cornerSoftner
  );
  
 
 
  fill(0);
 
  textSize(title_fontSize * scaleFactor_realistic);
  text(
    realistic_title,
    HP_realisticButton[0],
    HP_realisticButton[1],
    HP_realisticButton[2],
    HP_bottomValue
  );
  
 
  textSize(title_fontSize * scaleFactor_creative);
  text(
    creative_title,
    HP_creativeButton[0],
    HP_creativeButton[1],
    HP_creativeButton[2],
    HP_bottomValue
  );
  
  
 
  textSize(text_fontSize * scaleFactor_realistic);
  text(
    realistic_description,
    HP_realisticButton[0],
    HP_bottomValue,
    HP_realisticButton[2],
    HP_realisticButton[3]
  );
  
 
  textSize(text_fontSize * scaleFactor_creative);
  text(
    creative_description,
    HP_creativeButton[0],
    HP_bottomValue,
    HP_creativeButton[2],
    HP_creativeButton[3]
  );
  
  drawLogo(width * 0.75, height * 0.07, 58);
}






//CREATIVE PAGE FUNCTION:

void creativePage() {
 
  if (!initializedCanvas) {
    initializeCanvas();
  }
 
  else {
   
    displayArtwork();
   
    toolBar();
   
   
   
    if (currentBrush == "Normal") {
      
      if (!mousePressed) {
        brushColor = color(random(255), random(255), random(255));
      }
      
      else if (mousePressed && x >= canvas[0] && y >= canvas[1] && x <= canvas[2] && y <= canvas[3] && sliderDisplacement.get("brushSize_C").get(1) == 0.0 && sliderDisplacement.get("transparency_C").get(1) == 0.0 && !brushes_active && !resetArea && !color_active && !preferences_pressed && !preferences_open) {
       
        if (!drawingStroke) {
          startUndoStroke();
        }

        float localX = x - canvas[0];
        float localY = y - canvas[1];

        recordPixelsBeforeBrush(localX, localY, brushSize);

        drawingLayer.beginDraw();
        drawingLayer.colorMode(RGB, 255);
        drawingLayer.fill(brushColor, transparency);
        drawingLayer.noStroke();
        drawingLayer.ellipse(localX, localY, brushSize, brushSize);
        drawingLayer.endDraw();
       
      }
      
    }
    
    
    
   
    if (currentBrush == "Eraser") {
      
      colorMode(RGB, 255);
      brushColor = color(255, 255, 255);
      
      if (mousePressed && x >= canvas[0] && y >= canvas[1] && x <= canvas[2] && y <= canvas[3] && sliderDisplacement.get("brushSize_C").get(1) == 0.0 && sliderDisplacement.get("transparency_C").get(1) == 0.0 && !brushes_active && !resetArea && !color_active && !preferences_pressed && !preferences_open) {
       
        if (!drawingStroke) {
          startUndoStroke();
        }

        float localX = x - canvas[0];
        float localY = y - canvas[1];

        recordPixelsBeforeBrush(localX, localY, brushSize);

        drawingLayer.beginDraw();
        drawingLayer.colorMode(RGB, 255);
        drawingLayer.fill(255, transparency);
        drawingLayer.noStroke();
        drawingLayer.ellipse(localX, localY, brushSize, brushSize);
        drawingLayer.endDraw();
       
      }
      
    }
   
   
    navigatorCR();
    clearAllButton();
    showCoords();
    undoButton();
    toolbarStrip();
    exitButton();
    
    brushEraser();
    brushPaint();
    
    
  }
 
}






//REALISTIC FEATURES PAGE:

void realisticPage() {
   
  if (!initializedCanvas) {
    initializeCanvas();
  }
 
  else {
   
    displayArtwork();
   
    toolBar();
   
    if (currentBrush == "Normal") {
      
      if (mousePressed && x >= canvas[0] && y >= canvas[1] && x <= canvas[2] && y <= canvas[3] && sliderDisplacement.get("brushSize_C").get(1) == 0.0 && sliderDisplacement.get("transparency_C").get(1) == 0.0 && !brushes_active && !resetArea && !color_active && !preferences_open) {
        
        if (!drawingStroke) {
          startUndoStroke();
        }

        float localX = x - canvas[0];
        float localY = y - canvas[1];

        recordPixelsBeforeBrush(localX, localY, brushSize);

        drawingLayer.beginDraw();
        drawingLayer.colorMode(HSB, 255);
        drawingLayer.fill(brush_hue, brush_saturation, brush_brightness, transparency);
        drawingLayer.noStroke();
        drawingLayer.ellipse(localX, localY, brushSize, brushSize);
        drawingLayer.endDraw();
        
        ellipses++;
        println(ellipses);
      }
      
    }
   
   
    if (currentBrush == "Eraser") {
      
      colorMode(RGB, 255);
      brushColor = color(255, 255, 255);
      
      if (mousePressed && x >= canvas[0] && y >= canvas[1] && x <= canvas[2] && y <= canvas[3] && sliderDisplacement.get("brushSize_C").get(1) == 0.0 && sliderDisplacement.get("transparency_C").get(1) == 0.0 && !brushes_active && !resetArea && !color_active && !preferences_open) {
       
        if (!drawingStroke) {
          startUndoStroke();
        }

        float localX = x - canvas[0];
        float localY = y - canvas[1];

        recordPixelsBeforeBrush(localX, localY, brushSize);

        drawingLayer.beginDraw();
        drawingLayer.colorMode(RGB, 255);
        drawingLayer.fill(255, transparency);
        drawingLayer.noStroke();
        drawingLayer.ellipse(localX, localY, brushSize, brushSize);
        drawingLayer.endDraw();
       
      }
      
    }
   
   
    clearAllButton();
    undoButton();
    showCoords();
    toolbarStrip();
    exitButton();
    
    brushEraser();
    brushPaint();
    
    
  }
}






//OTHER FUNCTIONS:


//Displays ONLY the artwork layer onto the current canvas.

void displayArtwork() {

  image(
    drawingLayer,
    canvas[0],
    canvas[1],
    canvas[2] - canvas[0],
    canvas[3] - canvas[1]
  );

}





void toolBar() {
  int valueSize = 15;
  
  fill(190);
  rect(toolBar[0], toolBar[1], toolBar[2], toolBar[3]);
 
 
  brushSize = map(
    sliderDisplacement.get("brushSize_C").get(0),
    0,
    slider_brushSize_C[2] - slider_brushSize_C[0],
    3,
    50
  );
  
  transparency = map(
    sliderDisplacement.get("transparency_C").get(0),
    0,
    slider_transparency_C[2] - slider_transparency_C[0],
    0,
    255
  );
 
 
  sliderFunction(
    slider_brushSize_C[0],
    slider_brushSize_C[1],
    slider_brushSize_C[2],
    slider_brushSize_C[3],
    valueSize,
    sliderDisplacement.get("brushSize_C").get(0),
    "brushSize_C",
    sliderDisplacement.get("brushSize_C").get(1),
    "Brush Size"
  );
 
  realtimeFeedbackBrushSize(
    slider_brushSize_C[0],
    slider_brushSize_C[1],
    slider_brushSize_C[2]
  );
 
 
  sliderFunction(
    slider_transparency_C[0],
    slider_transparency_C[1],
    slider_transparency_C[2],
    slider_transparency_C[3],
    valueSize,
    sliderDisplacement.get("transparency_C").get(0),
    "transparency_C",
    sliderDisplacement.get("transparency_C").get(1),
    "Opacity"
  );
 
  realtimeFeedbackTransparency(
    slider_transparency_C[0],
    slider_transparency_C[1],
    slider_transparency_C[2]
  );

  colorPicker();
  navigatorCR();
}


void exitButton() {
 
  float xSize =
    ((EB_rectangleButton[2] - EB_rectangleButton[0]) / 2) * 1.5;
 
 
  if (x >= EB_rectangleButton[0] && y >= EB_rectangleButton[1] && x <= EB_rectangleButton[2] && y <= EB_rectangleButton[3]) {
 
    fill(EB_Red);
   
    if (mousePressed) {
      exit();
    }
   
  }
  else {
    if (userPosition != "Home") {
      fill(EB_Normal);
    }
    else {
      fill(bg);
    }
  }
 
 
  rect(
    EB_rectangleButton[0],
    EB_rectangleButton[1],
    EB_rectangleButton[2],
    EB_rectangleButton[3]
  );
 
 
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(xSize);
 
  text(
    "\u00D7",
    EB_rectangleButton[2] -
    ((EB_rectangleButton[2] - EB_rectangleButton[0]) / 2),
    EB_rectangleButton[3] -
    ((EB_rectangleButton[3] - EB_rectangleButton[1]) / 2)
  );
 
}




//INITIALIZATION OF CANVAS:

//UNDO FUNCTIONS

void startUndoStroke() {
  currentDelta = new ArrayList<PixelDelta>();
  changedPixels.clear();
  drawingStroke = true;
}


void recordPixelsBeforeBrush(float centerX, float centerY, float size) { //Records only the pixels that are drawn/changed for more storage
  drawingLayer.loadPixels();

  int radius = ceil(size / 2.0);

  int startX = max(0, floor(centerX - radius));
  int endX = min(drawingLayer.width - 1, ceil(centerX + radius));
  int startY = max(0, floor(centerY - radius));
  int endY = min(drawingLayer.height - 1, ceil(centerY + radius));

  for (int py = startY; py <= endY; py++) {
    for (int px = startX; px <= endX; px++) {

      int index = py * drawingLayer.width + px;

      if (!changedPixels.containsKey(index)) {
        currentDelta.add(
          new PixelDelta(
            index,
            drawingLayer.pixels[index]
          )
        );

        changedPixels.put(index, true);
      }
    }
  }
}


void finishUndoStroke() {
  if (!drawingStroke || currentDelta == null) { //Ends the mouse line pixel changes
    return;
  }

  if (currentDelta.size() > 0) {
    undoStack.add(currentDelta);

    if (undoStack.size() > maxUndo) {
      undoStack.remove(0);
    }
  }

  currentDelta = null;
  changedPixels.clear();
  drawingStroke = false;
}


void undo() { //Changes the canvas based on the undo button
  if (undoStack.size() == 0) {
    return;
  }

  ArrayList<PixelDelta> delta =
    undoStack.remove(undoStack.size() - 1);

  drawingLayer.loadPixels();

  for (PixelDelta pixel : delta) {
    drawingLayer.pixels[pixel.index] = pixel.oldColor;
  }

  drawingLayer.updatePixels();
}


void clearCanvasWithUndo() { //If Canvas is cleared it takes the pixels that were changed
  startUndoStroke();

  drawingLayer.loadPixels();

  for (int i = 0; i < drawingLayer.pixels.length; i++) {

    currentDelta.add(
      new PixelDelta(
        i,
        drawingLayer.pixels[i]
      )
    );
  }

  drawingLayer.beginDraw();
  drawingLayer.background(255);
  drawingLayer.endDraw();

  finishUndoStroke();
}


void undoButton() { //Makes the undo button
  
  fill(bg);
  stroke(0);
  strokeWeight(2);
  rect(undoButton_dimensions[0], undoButton_dimensions[1], undoButton_dimensions[2], undoButton_dimensions[3]);
  noStroke();
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(17);
  text("Undo", undoButton_dimensions[0], undoButton_dimensions[1], undoButton_dimensions[2], undoButton_dimensions[3]);
  
  if (x >= undoButton_dimensions[0] && y >= undoButton_dimensions[1] && x <= undoButton_dimensions[2] && y <= undoButton_dimensions[3]) {
    if (mousePressed && !undoButton_pressed) {
      undoButton_pressed = true;
      undo();
    }
  }
  if (!mousePressed) {
    undoButton_pressed = false;
  }
}


void initializeCanvas() { //Initializes the canvas (Blank)

  drawingLayer.beginDraw();
  drawingLayer.background(255);
  drawingLayer.endDraw();
  if (!mousePressed) {
    initializedCanvas = true;
  }
}





//Builds all Sliders with just this one function

void sliderFunction(
  float sliderXs,
  float sliderYs,
  float sliderXe,
  float sliderYe,
  float ellipseSize,
  float displacement,
  String sliderName,
  float sliderState,
  String sliderTitle
) {
 
  fill(0);
  textSize(18);
  textAlign(LEFT, CENTER);
 
  float textYs = sliderYs - height * 0.045;
  float textYe = sliderYs - height * 0.005;
  
  if (sliderName == "brushSize_C") {
    text(
      sliderTitle + ": " +
      round(
        map(
          sliderDisplacement.get("brushSize_C").get(0),
          0,
          slider_brushSize_C[2] - slider_brushSize_C[0],
          3,
          50
        )
      ),
      sliderXs,
      textYs,
      sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05,
      textYe
    );
  }
  
  if (sliderName == "transparency_C") {
    text(
      sliderTitle + ": " +
      round(
        map(
          sliderDisplacement.get("transparency_C").get(0),
          0,
          slider_brushSize_C[2] - slider_brushSize_C[0],
          0,
          100
        )
      ) + "%",
      sliderXs,
      textYs,
      sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05,
      textYe
    );
  }
  
  if (sliderName == "brightness") {
    text(
      sliderTitle + ": " +
      round(
        map(
          sliderDisplacement.get("brightness").get(0),
          0,
          slider_brushSize_C[2] - slider_brushSize_C[0],
          0,
          100
        )
      ) + "%",
      sliderXs,
      textYs,
      sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05,
      textYe
    );
  }
 
 
  fill(50);
  rect(sliderXs, sliderYs, sliderXe, sliderYe);
 
 
  fill(50);
  ellipse(
    sliderXs + displacement,
    sliderYs + ((sliderYe - sliderYs) / 2),
    ellipseSize,
    ellipseSize
  );
 
 
  float ellipseXs =
    sliderXs - (ellipseSize / 2) + displacement;
  
  float ellipseXe =
    sliderXs + (ellipseSize / 2) + displacement;
  
  float ellipseYc =
    sliderYs + ((sliderYe - sliderYs) / 2);
 

  if (!mousePressed) {
   
    sliderState = 0.0;
    sliderDisplacement.get(sliderName).set(1, sliderState);
  }
 
  if (x >= ellipseXs && x <= ellipseXe && y >= ellipseYc - (ellipseSize / 2) && y <= ellipseYc + (ellipseSize / 2)) {
 
    if (mousePressed) {
     
      sliderState = 1.0;
      sliderDisplacement.get(sliderName).set(1, sliderState);
     
    }
   
  }
 
  if (sliderState == 1.0) {
 
    displacement = mouseX - sliderXs;
   
    if (displacement > (sliderXe - sliderXs)) {
      displacement = sliderXe - sliderXs;
    }
    
    if (displacement < 0) {
      displacement = 0.0;
    }
   
    sliderDisplacement.get(sliderName).set(0, displacement);
  }
 
}





//Used for Cursor modification

void cursorChange() {
 
  if (userPosition != "Home") {
   
    if (x >= canvas[0] && y >= canvas[1] && x <= canvas[2] && y <= canvas[3] && sliderDisplacement.get("brushSize_C").get(1) == 0.0 && sliderDisplacement.get("transparency_C").get(1) == 0.0 && !brushes_active && !color_active && !preferences_open) {
      cursor(CROSS);
    }
    
    else if (hoverTextBox == true) {
      cursor(TEXT);
    }
    
    else {
      cursor(ARROW);
    }
   
  }
  
  else {
    cursor(ARROW);
  }
 
}





//Makes a real time change in size of ellipse for Brush Size

void realtimeFeedbackBrushSize(
  float sliderXs,
  float sliderYs,
  float sliderXe
) {
 
 
  float feedbackXs =
    sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05;
  
  float feedbackYs =
    sliderYs - height * 0.035;
  
  float feedbackXe =
    sliderXe + width * 0.05;
  
  float feedbackYe =
    sliderYs + height * 0.035;
 
 
  float squareSize;
  squareSize = min(
    feedbackXe - feedbackXs,
    feedbackYe - feedbackYs
  );
 
  float feedbackCx = feedbackXe - squareSize;
  float feedbackCy = feedbackYs + ((feedbackYe - feedbackYs)/2);
 
 
  stroke(0);
  strokeWeight(2);
  fill(190);
  rect(
    feedbackCx,
    feedbackYs,
    feedbackCx + squareSize,
    feedbackYs + squareSize
  );
  noStroke();
 
  fill(0);
  ellipse(
    feedbackCx + squareSize / 2,
    feedbackYs + squareSize / 2,
    brushSize,
    brushSize
  );

 
  rectMode(CORNERS);
}


void realtimeFeedbackTransparency(
  float sliderXs,
  float sliderYs,
  float sliderXe
) {
 
 
  float feedbackXs =
    sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05;
  
  float feedbackYs =
    sliderYs - height * 0.035;
  
  float feedbackXe =
    sliderXe + width * 0.05;
  
  float feedbackYe =
    sliderYs + height * 0.035;
 
 
  float squareSize;
  squareSize = min(
    feedbackXe - feedbackXs,
    feedbackYe - feedbackYs
  );
 
  float feedbackCx = feedbackXe - squareSize;
  float feedbackCy =
    feedbackYs + ((feedbackYe - feedbackYs)/2);
 
 
  stroke(0);
  strokeWeight(2);
  fill(190);
  rect(
    feedbackCx,
    feedbackYs,
    feedbackCx + squareSize,
    feedbackYs + squareSize
  );
  noStroke();
 
  fill(0, 0, 0, transparency);
  ellipse(
    feedbackCx + squareSize / 2,
    feedbackYs + squareSize / 2,
    30,
    30
  );

 
  rectMode(CORNERS);
}



//Shows Mouse x and y
void showCoords() {
  colorMode(RGB, 255);
  fill(0);
  
  if (dominantHand == "Right") {
    textAlign(LEFT, CENTER);
  }
  
  else if (dominantHand == "Left") {
    textAlign(RIGHT, CENTER);
  }
  
  textSize(18);
  text("Mouse X: " + x + "\n" + "Mouse Y: " + y, coord_dimensions[0], coord_dimensions[1], coord_dimensions[2], coord_dimensions[3]);

}


void brushEraser() { //Makes Eraser Button for brushes
  
  if (currentBrush == "Eraser") {
    stroke(0);
    strokeWeight(2);
  }
  else {
    noStroke();
  }
  
  fill(190);
  rect(
    eraser_dimensions[0],
    eraser_dimensions[1],
    eraser_dimensions[2],
    eraser_dimensions[3]
  );
  
  noStroke();
  
  eraserSymbol(
    eraser_dimensions[0] +
    ((eraser_dimensions[2] - eraser_dimensions[0]) / 2),
    
    eraser_dimensions[1] +
    ((eraser_dimensions[3] - eraser_dimensions[1]) / 2),
    
    20,
    40
  );
  
  
  if (x >= eraser_dimensions[0] && y >= eraser_dimensions[1] && x <= eraser_dimensions[2] && y <= eraser_dimensions[3]) {
    
    if (mousePressed) {
      currentBrush = "Eraser";
    }
  }
  
}


void brushPaint() { //Makes Paint brush button for brushes

  if (currentBrush == "Normal") {
    stroke(0);
    strokeWeight(2);
  }
  else {
    noStroke();
  }
  
  fill(190);
  rect(
    paint_dimensions[0],
    paint_dimensions[1],
    paint_dimensions[2],
    paint_dimensions[3]
  );
  
  noStroke();
  
 
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(48);
  
  text(
    "\uD83D\uDD8C",
    paint_dimensions[0],
    paint_dimensions[1],
    paint_dimensions[2],
    paint_dimensions[3]
  );
  
  if (x >= paint_dimensions[0] && y >= paint_dimensions[1] && x <= paint_dimensions[2] && y <= paint_dimensions[3]) {
    
    if (mousePressed) {
      currentBrush = "Normal";
    }
  }
}




void canvasBorder() { //Makes sure the paint does not go outside the canvas
  
  if (!color_active && dominantHand == "Right") {
    
    fill(bg);
    
    rect(
      toolBar[2] + width * 0.0001,
      0,
      canvas[0],
      height
    );
    
    rect(0, 0, width, canvas[1]);
    rect(0, canvas[3], width, height);
    rect(canvas[2], 0, width, height);
  }
  
  else if (!color_active && dominantHand == "Left") {
    
    fill(bg);
    
    rect(toolBar[0], 0, canvas[2], height);
    rect(0, 0, width, canvas[1]);
    rect(0, canvas[3], width, height);
    rect(0, 0, canvas[0], height);
  }
  
}






void colorPicker() { //Color Picker/Gradient function calling into the toolbar

  fill(bg);
  rect(
    gradientBox[0],
    gradientBox[1],
    gradientBox[2],
    gradientBox[3]
  );

  fill(0);
  textSize(22);
  textAlign(LEFT, CENTER);
  
  text(
    "Color Picker",
    gradientBox[0],
    gradientBox[1] - height * 0.05,
    gradientBox[2],
    gradientBox[1] - height * 0.01
  );
  

  image(
    gradient,
    gradientBox[0],
    gradientBox[1],
    gradientBox[2] - gradientBox[0],
    gradientBox[3] - gradientBox[1]
  );
  
  brush_brightness = map(
    sliderDisplacement.get("brightness").get(0),
    0,
    slider_brightness[2] - slider_brightness[0],
    0,
    255
  );
  
  if (userPosition == "Realistic") {
    colorList();
    
    sliderFunction(
        slider_brightness[0],
        slider_brightness[1],
        slider_brightness[2],
        slider_brightness[3],
        15,
        sliderDisplacement.get("brightness").get(0),
        "brightness",
        sliderDisplacement.get("brightness").get(1),
        "Brightness"
    );
    
    realtimeFeedbackBrightness(
      slider_brightness[0],
      slider_brightness[1],
      slider_brightness[2]
    );
    
    if (x >= gradientBox[0] && y >= gradientBox[1] && x <= gradientBox[2] && y <= gradientBox[3]) {
      
      if (mousePressed) {
        brush_hue = hue(get(mouseX, mouseY));
        brush_saturation = saturation(get(mouseX, mouseY));
      }
    
    }
    
  }
  
  else {
    
    if (dominantHand == "Right") {
      
      rectMode(CENTER);
      
      pushMatrix();
      
      translate(
        width * (0.02 + (0.19 / 2)),
        height * (0.45 + (0.455 / 2)) - height * 0.2
      );
      
      rotate(radians(45));
      
      fill(0, 0, 0, 0);
      strokeWeight(10);
      stroke(255, 0, 0);
      
      rect(
        0,
        0,
        width * 0.175,
        height * 0.1
      );
      
      fill(255,0,0);
      textAlign(CENTER, CENTER);
      textSize(33);
      
      text(
        "Only In Realistic",
        0,
        0,
        width * 0.175,
        height * 0.1
      );
      
      noStroke();
      popMatrix();
      
      rectMode(CORNERS);
    
    }
    
    else if (dominantHand == "Left") {
      
      rectMode(CENTER);
      
      pushMatrix();
      
      translate(
        width * (0.02 + (0.19 / 2)) + width * 0.77,
        height * (0.45 + (0.455 / 2)) - height * 0.2
      );
      
      rotate(radians(45));
      
      fill(0, 0, 0, 0);
      strokeWeight(10);
      stroke(255, 0, 0);
      
      rect(
        0,
        0,
        width * 0.175,
        height * 0.1
      );
      
      fill(255,0,0);
      textAlign(CENTER, CENTER);
      textSize(33);
      
      text(
        "Only In Realistic",
        0,
        0,
        width * 0.175,
        height * 0.1
      );
      
      noStroke();
      popMatrix();
      
      rectMode(CORNERS);
    }
    
  }
  
  addColor();
  colorShow();
}







void colorPickerOnce() { //Makes initial gradient to prevent slow framerate due to for loop

  colorMode(HSB, 255);

  int w = int(gradientBox[2] - gradientBox[0]);
  int h = int(gradientBox[3] - gradientBox[1]);

  gradient = createImage(w, h, RGB);
  gradient.loadPixels();

  for (int px = 0; px < w; px++) {
    
    for (int py = 0; py < h; py++) {

      float hue = map(px, 0, w - 1, 0, 255);
      float saturation = map(py, 0, h - 1, 255, 0);

      gradient.pixels[py * w + px] =
        color(hue, saturation, 255);
    }
  }

  gradient.updatePixels();
  colorMode(RGB, 255);
}





void colorList() { // Makes the preset color picker palette

  // Determine how many colors go on each row
  perRow = 5;

  if (colorPalette.length > 50) {
    perRow = 10;
  }

  if (colorPalette.length > 100) {
    perRow = 20;
  }

  if (colorPalette.length > 200) {
    perRow = 25;
  }

  // Calculate number of rows
  int rows = ceil((float)colorPalette.length / perRow);

  // Calculate palette dimensions
  float paletteWidth =
    perRow * colorPalette_box_size[0] +
    (perRow + 1) * (width * 0.015);

  float paletteHeight =
    rows * colorPalette_box_size[1] +
    (rows + 1) * (height * 0.02778);

  // Right-hand layout
  if (dominantHand == "Right") {

    colorPalette_size[0] = width * 0.21;
    colorPalette_size[1] = gradientBox[1] - height * 0.05;
    colorPalette_size[2] = colorPalette_size[0] + paletteWidth;
    colorPalette_size[3] = colorPalette_size[1] + paletteHeight;

  }

  // Left-hand layout
  else {

    colorPalette_size[2] = width * 0.79;
    colorPalette_size[1] = gradientBox[1] - height * 0.05;
    colorPalette_size[0] = colorPalette_size[2] - paletteWidth;
    colorPalette_size[3] = colorPalette_size[1] + paletteHeight;
  }


  fill(0);
  textSize(22);
  textAlign(RIGHT, CENTER);

  if (!color_active) {
    text(
      ">",
      gradientBox[0],
      gradientBox[1] - height * 0.05,
      gradientBox[2],
      gradientBox[1] - height * 0.01
    );
  }
  else {
    text(
      "X",
      gradientBox[0],
      gradientBox[1] - height * 0.05,
      gradientBox[2],
      gradientBox[1] - height * 0.01
    );
  }


  // OPEN / CLOSE COLOR PALETTE
  if (
    x >= gradientBox[0] &&
    y >= gradientBox[1] - height * 0.05 &&
    x <= gradientBox[2] &&
    y <= gradientBox[1] - height * 0.01
  ) {

    if (mousePressed && color_button_active) {

      if (!color_active) {

        behindBox2 = get(
          round(colorPalette_size[0]) - 1,
          round(colorPalette_size[1]) - 1,
          round(colorPalette_size[2]) + 1,
          round(colorPalette_size[3]) + 1
        );

      }

      color_active = !color_active;
      color_button_active = false;

      if (brushes_active) {
        brushes_active = false;
      }

      if (!color_active) {

        set(
          round(colorPalette_size[0]) - 1,
          round(colorPalette_size[1]) - 1,
          behindBox2
        );

      }
    }
  }


  if (!mousePressed) {
    color_button_active = true;
  }


  // CHANGE NUMBER OF COLORS PER ROW
  if (colorPalette.length > 50) {
    perRow = 10;
  }

  if (colorPalette.length > 100) {
    perRow = 20;
  }

  if (colorPalette.length > 200) {
    perRow = 25;
  }


  // DRAW PALETTE
  if (color_active) {

    fill(190);

    rect(
      colorPalette_size[0],
      colorPalette_size[1],
      colorPalette_size[2],
      colorPalette_size[3]
    );


    // DRAW EACH COLOR
    for (int r = 0; r <= int(colorPalette.length / perRow); r++) {

      for (
        int s = 0;
        s < min(perRow, colorPalette.length - (r * perRow));
        s++
      ) {

        fill(
          colorPalette[
            (r * perRow) + s
          ]
        );


        float x1;
        float x2;

        float y1 =
          colorPalette_size[1] +
          (((2 * r) + 1) * (height * 0.02778));

        float y2 =
          y1 + colorPalette_box_size[1];


        // RIGHT HAND
        if (dominantHand == "Right") {

          x1 =
            colorPalette_size[0] +
            (((2 * s) + 1) * (width * 0.015));

          x2 =
            x1 + colorPalette_box_size[0];

        }


        // LEFT HAND
        else {

          x2 =
            colorPalette_size[2] -
            (((2 * s) + 1) * (width * 0.015));

          x1 =
            x2 - colorPalette_box_size[0];

        }


        rect(
          x1,
          y1,
          x2,
          y2
        );

      }
    }


    // DETECT COLOR CLICK
    for (int r = 0; r <= int(colorPalette.length / perRow); r++) {

      for (
        int s = 0;
        s < min(perRow, colorPalette.length - (r * perRow));
        s++
      ) {

        float x1;
        float x2;

        float y1 =
          colorPalette_size[1] +
          (((2 * r) + 1) * (height * 0.02778));

        float y2 =
          y1 + colorPalette_box_size[1];


        // RIGHT HAND
        if (dominantHand == "Right") {

          x1 =
            colorPalette_size[0] +
            (((2 * s) + 1) * (width * 0.015));

          x2 =
            x1 + colorPalette_box_size[0];

        }


        // LEFT HAND
        else {

          x2 =
            colorPalette_size[2] -
            (((2 * s) + 1) * (width * 0.015));

          x1 =
            x2 - colorPalette_box_size[0];

        }


        // COLOR CLICKED
        if (
          x >= x1 &&
          y >= y1 &&
          x <= x2 &&
          y <= y2
        ) {

          if (mousePressed) {

            colorMode(HSB, 255);

            brush_hue =
              hue(
                colorPalette[
                  (r * perRow) + s
                ]
              );

            brush_saturation =
              saturation(
                colorPalette[
                  (r * perRow) + s
                ]
              );


            sliderDisplacement.get("brightness").set(
              0,
              map(
                brightness(
                  colorPalette[
                    (r * perRow) + s
                  ]
                ),
                0,
                255,
                0,
                slider_brightness[2] -
                slider_brightness[0]
              )
            );


            brush_brightness =
              brightness(
                colorPalette[
                  (r * perRow) + s
                ]
              );

          }
        }
      }
    }
  }
}





void addColor() { //Allows for us to add colors upto 250 of them to the palette, Prevents duplicate colors

  // Draw button
  colorMode(RGB, 255);
  fill(190);

  rect(
    addColor_box_size[0],
    addColor_box_size[1],
    addColor_box_size[2],
    addColor_box_size[3]
  );

  fill(0);
  textAlign(LEFT, CENTER);
  textSize(18);

  text(
    "Save Color to Palette",
    addColor_box_size[0],
    addColor_box_size[1],
    addColor_box_size[2],
    addColor_box_size[3]
  );

  textAlign(RIGHT, CENTER);
  textSize(32);

  text(
    "+",
    addColor_box_size[0],
    addColor_box_size[1],
    addColor_box_size[2],
    addColor_box_size[3]
  );


  // ADD COLOR
  if (
    x >= addColor_box_size[0] &&
    y >= addColor_box_size[1] &&
    x <= addColor_box_size[2] &&
    y <= addColor_box_size[3]
  ) {

    if (mousePressed && !addColor_pressed) {

      if (colorPalette.length < 250) {

        colorMode(HSB, 255);

        float r = red(
          color(
            brush_hue,
            brush_saturation,
            brush_brightness
          )
        );

        float g = green(
          color(
            brush_hue,
            brush_saturation,
            brush_brightness
          )
        );

        float b = blue(
          color(
            brush_hue,
            brush_saturation,
            brush_brightness
          )
        );

        colorMode(RGB, 255);

        colorPalette = append(
          colorPalette,
          color(r, g, b)
        );

        addColor_pressed = true;
      }
    }
  }


  if (!mousePressed) {
    addColor_pressed = false;
  }

  ArrayList<Integer> uniqueColors = new ArrayList<Integer>();

  boolean foundDuplicate = false;

  for (int i = 0; i < colorPalette.length; i++) {

    int currentColor = colorPalette[i];

    if (uniqueColors.contains(currentColor)) {

      foundDuplicate = true;

    } 
    else {

      uniqueColors.add(currentColor);

    }
  }


  // Actually delete duplicate entries
  if (foundDuplicate) {

    colorPalette = new color[uniqueColors.size()];

    for (int i = 0; i < uniqueColors.size(); i++) {

      colorPalette[i] = uniqueColors.get(i);

    }

    messagetime2 = 100;
  }

  if (messagetime2 > 0) {
    fill(bg);
    rect(0, canvas[3], width, height);
    fill(0, 180);

    textAlign(CENTER, CENTER);
    textSize(18);

    text(
      "Duplicates have been removed",
      width / 2,
      height * 0.97
    );

    messagetime2--;
  }
  if (messagetime2 == 0) {
    fill(bg);
    rect(0, canvas[3], width, height);
  }
}







void realtimeFeedbackBrightness(
  float sliderXs,
  float sliderYs,
  float sliderXe
) { //Makes the realtime feedback for brightness
 
  float feedbackXs =
    sliderXs + ((sliderXe - sliderXs) / 2) + width * 0.05;
  
  float feedbackYs =
    sliderYs - height * 0.035;
  
  float feedbackXe =
    sliderXe + width * 0.05;
  
  float feedbackYe =
    sliderYs + height * 0.035;
 
 
  float squareSize;
  
  squareSize = min(
    feedbackXe - feedbackXs,
    feedbackYe - feedbackYs
  );
 
  float feedbackCx = feedbackXe - squareSize;
 
 
  stroke(0);
  strokeWeight(2);
  fill(190);
  
  rect(
    feedbackCx,
    feedbackYs,
    feedbackCx + squareSize,
    feedbackYs + squareSize
  );
  
  noStroke();
  
  colorMode(HSB, 255);
  
  fill(
    brush_hue,
    brush_saturation,
    brush_brightness
  );
  
  ellipse(
    feedbackCx + squareSize / 2,
    feedbackYs + squareSize / 2,
    30,
    30
  );

 
  rectMode(CORNERS);
}






void navigatorCR() { //Allows the change between creative and realistic
  
  colorMode(RGB, 255);
  
  fill(bg);
  
  rect(
    navigatorCR_switchBox[0],
    navigatorCR_switchBox[1],
    navigatorCR_switchBox[2],
    navigatorCR_switchBox[3]
  );
  
  float switchXs = navigatorCR_switchBox[0];
  
  float switchXc =
    navigatorCR_switchBox[0] +
    ((navigatorCR_switchBox[2] - navigatorCR_switchBox[0]) / 2);
  
  float switchXe = navigatorCR_switchBox[2];
  float switchYs = navigatorCR_switchBox[1];
  float switchYe = navigatorCR_switchBox[3];
  
  if (userPosition == "Realistic") {
    
    fill(0);
    
    rect(
      switchXs,
      switchYs,
      switchXc,
      switchYe
    );
    
    fill(255);
    textSize(18.5);
    textAlign(CENTER, CENTER);
    
    text(
      "Realistic",
      switchXs,
      switchYs,
      switchXc,
      switchYe
    );
    
    fill(255);
    
    rect(
      switchXc,
      switchYs,
      switchXe,
      switchYe
    );
    
    fill(0);
    
    textSize(18.5);
    textAlign(CENTER, CENTER);
    
    text(
      "Creative",
      switchXc,
      switchYs,
      switchXe,
      switchYe
    );
    
    if (x >= switchXc && y >= switchYs && x <= switchXe && y <= switchYe) {
      
      if (mousePressed) {
        userPosition = "Creative";
        transitioned = true;
      }
    }
  }
  
  
  else if (userPosition == "Creative") {
    
    fill(255);
    
    rect(
      switchXs,
      switchYs,
      switchXc,
      switchYe
    );
    
    fill(0);
    
    textSize(18.5);
    textAlign(CENTER, CENTER);
    
    text(
      "Realistic",
      switchXs,
      switchYs,
      switchXc,
      switchYe
    );
    
    fill(0);
    
    rect(
      switchXc,
      switchYs,
      switchXe,
      switchYe
    );
    
    fill(255);
    
    textSize(18.5);
    textAlign(CENTER, CENTER);
    
    text(
      "Creative",
      switchXc,
      switchYs,
      switchXe,
      switchYe
    );
    
    if (x >= switchXs && y >= switchYs && x <= switchXc && y <= switchYe) {
      
      if (mousePressed) {
        userPosition = "Realistic";
        transitioned = true;
      }
    }
  }

}


void clearAllButton() { //Clears Everything using this button
  
  stroke(0);
  fill(bg);
  strokeWeight(2);
  
  rect(
    clearAll_button_dimensions[0],
    clearAll_button_dimensions[1],
    clearAll_button_dimensions[2],
    clearAll_button_dimensions[3]
  );
  
  fill(0);
  textSize(17);
  textAlign(CENTER, CENTER);
  
  text(
    "Clear All",
    clearAll_button_dimensions[0],
    clearAll_button_dimensions[1],
    clearAll_button_dimensions[2],
    clearAll_button_dimensions[3]
  );
  
  noStroke();
  
  if (x >= clearAll_button_dimensions[0] && y >= clearAll_button_dimensions[1] && x <= clearAll_button_dimensions[2] && y <= clearAll_button_dimensions[3]) {
    
    if (mousePressed && !clear_pressed) {
      clearCanvasWithUndo();
      clear_pressed = true;
    }
  }
  
  if (!mousePressed) {
    clear_pressed = false;
  }

}


void toolbarStrip() { //The toolbar is made using this function
  
  fill(190);
  noStroke();
  
  rect(
    appBar_dimensions[0],
    appBar_dimensions[1],
    appBar_dimensions[2],
    appBar_dimensions[3]
  );
  
  drawLogo(
    width * 0.01,
    appBar_dimensions[1] +
    ((appBar_dimensions[3] - appBar_dimensions[1]) / 2),
    28
  );
  
  preferences();
  saveFile2();
  upload();
}


void preferences() { //This is for the preferences page
  
  if (x >= preferences_button_dimensions[0] && y >= preferences_button_dimensions[1] && x <= preferences_button_dimensions[2] && y <= preferences_button_dimensions[3]) {
    
    fill(150);
    
    if (mousePressed && !preferences_pressed) {
      
      preferences_open = !preferences_open;
      preferences_pressed = true;
      
    }
  }
  else {
    fill(190);
  }
  
  if (!mousePressed) {
    preferences_pressed = false;
  }
  
  rect(
    preferences_button_dimensions[0],
    preferences_button_dimensions[1],
    preferences_button_dimensions[2],
    preferences_button_dimensions[3]
  );
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  text(
    "Preferences",
    preferences_button_dimensions[0],
    preferences_button_dimensions[1],
    preferences_button_dimensions[2],
    preferences_button_dimensions[3]
  );
  
  preferencesOpened();
  
}


void preferencesOpened() { //When it is opened, GUI
  
  if (preferences_open) {
    
    fill(220);
    
    rect(
      preferences_open_dimensions[0],
      preferences_open_dimensions[1],
      preferences_open_dimensions[2],
      preferences_open_dimensions[3]
    );
    
    fill(0);
    textSize(22);
    textAlign(LEFT, CENTER);
    
    text(
      "Preferences",
      preferences_open_dimensions[0] + width * 0.01,
      preferences_open_dimensions[1],
      preferences_open_dimensions[2],
      height * 0.3
    );
    
    
    colorMode(RGB, 255);
    
    fill(bg);
    
    rect(
      preferences_switchBox[0],
      preferences_switchBox[1],
      preferences_switchBox[2],
      preferences_switchBox[3]
    );
    
    float switchXs = preferences_switchBox[0];
    
    float switchXc =
      preferences_switchBox[0] +
      ((preferences_switchBox[2] - preferences_switchBox[0]) / 2);
    
    float switchXe = preferences_switchBox[2];
    float switchYs = preferences_switchBox[1];
    float switchYe = preferences_switchBox[3];
    
    
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(18);
    
    text(
      "Dominant Hand:",
      preferences_open_dimensions[0] + width * 0.02,
      switchYs,
      switchXe,
      switchYe
    );
    
    if (dominantHand == "Left") {
      
      fill(0);
      
      rect(
        switchXs,
        switchYs,
        switchXc,
        switchYe
      );
      
      fill(255);
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "Left",
        switchXs,
        switchYs,
        switchXc,
        switchYe
      );
      
      fill(255);
      
      rect(
        switchXc,
        switchYs,
        switchXe,
        switchYe
      );
      
      fill(0);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "Right",
        switchXc,
        switchYs,
        switchXe,
        switchYe
      );
      
      if (x >= switchXc && y >= switchYs && x <= switchXe && y <= switchYe) {
        
        if (mousePressed) {
          dominantHand = "Right";
          pendingHandSwitch = true;
          preferences_open = false;
        }
      }
    }
    
    
    else if (dominantHand == "Right") {
      
      fill(255);
      
      rect(
        switchXs,
        switchYs,
        switchXc,
        switchYe
      );
      
      fill(0);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "Left",
        switchXs,
        switchYs,
        switchXc,
        switchYe
      );
      
      fill(0);
      
      rect(
        switchXc,
        switchYs,
        switchXe,
        switchYe
      );
      
      fill(255);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "Right",
        switchXc,
        switchYs,
        switchXe,
        switchYe
      );
      
      if (x >= switchXs && y >= switchYs && x <= switchXc && y <= switchYe) {
        
        if (mousePressed) {
          dominantHand = "Left";
          pendingHandSwitch = true;
          preferences_open = false;
        }
      }
    }
    
    fill(0);
    
    if (x >= width * 0.72 && y >= preferences_open_dimensions[1] && x <= preferences_open_dimensions[2] && y <= height * 0.3) {
      
      fill(200, 50, 50);
      
      rect(
        width * 0.72,
        preferences_open_dimensions[1],
        preferences_open_dimensions[2],
        height * 0.3
      );
      
      fill(0);
      textAlign(RIGHT, CENTER);
      
      text(
        "X",
        preferences_open_dimensions[0],
        preferences_open_dimensions[1],
        preferences_open_dimensions[2] - width * 0.01,
        height * 0.3
      );
      
      if (mousePressed) {
        
        preferences_open = !preferences_open;
        preferences_pressed = true;
        
      }
    }
    else {
      
      textAlign(RIGHT, CENTER);
      
      text(
        "X",
        preferences_open_dimensions[0],
        preferences_open_dimensions[1],
        preferences_open_dimensions[2] - width * 0.01,
        height * 0.3
      );
    }
    
    
    
    colorMode(RGB, 255);
    
    fill(bg);
    
    rect(
      preferences_switchBox2[0],
      preferences_switchBox2[1],
      preferences_switchBox2[2],
      preferences_switchBox2[3]
    );
    
    float switchXs2 = preferences_switchBox2[0];
    
    float switchXc2 =
      preferences_switchBox2[0] +
      ((preferences_switchBox2[2] - preferences_switchBox2[0]) / 2);
    
    float switchXe2 = preferences_switchBox2[2];
    float switchYs2 = preferences_switchBox2[1];
    float switchYe2 = preferences_switchBox2[3];
    
    
    fill(0);
    textAlign(LEFT, CENTER);
    textSize(18);
    
    text(
      "Prefered Color Notation:",
      preferences_open_dimensions[0] + width * 0.02,
      switchYs2,
      switchXe2,
      switchYe2
    );
    
    if (colorNotation == "RGB") {
      
      fill(0);
      
      rect(
        switchXs2,
        switchYs2,
        switchXc2,
        switchYe2
      );
      
      fill(255);
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "RGB",
        switchXs2,
        switchYs2,
        switchXc2,
        switchYe2
      );
      
      fill(255);
      
      rect(
        switchXc2,
        switchYs2,
        switchXe2,
        switchYe2
      );
      
      fill(0);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "HSB",
        switchXc2,
        switchYs2,
        switchXe2,
        switchYe2
      );
      
      if (x >= switchXc2 && y >= switchYs2 && x <= switchXe2 && y <= switchYe2) {
        
        if (mousePressed) {
          colorNotation = "HSB";
          //pendingHandSwitch = true;
          preferences_open = false;
        }
      }
    }
    
    
    else if (colorNotation == "HSB") {
      
      fill(255);
      
      rect(
        switchXs2,
        switchYs2,
        switchXc2,
        switchYe2
      );
      
      fill(0);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "RGB",
        switchXs2,
        switchYs2,
        switchXc2,
        switchYe2
      );
      
      fill(0);
      
      rect(
        switchXc2,
        switchYs2,
        switchXe2,
        switchYe2
      );
      
      fill(255);
      
      textSize(18.5);
      textAlign(CENTER, CENTER);
      
      text(
        "HSB",
        switchXc2,
        switchYs2,
        switchXe2,
        switchYe2
      );
      
      if (x >= switchXs2 && y >= switchYs2 && x <= switchXc2 && y <= switchYe2) {
        
        if (mousePressed) {
          colorNotation = "RGB";
          //pendingHandSwitch = true;
          preferences_open = false;
        }
      }
    }
  } 
  
  
  
  
  
  
  
  
  

}


//HAND SWITCHING
//The artwork is stored separately in drawingLayer.

void leftRightHand() {

  if (pendingHandSwitch) {

    pendingHandSwitch = false;

    if (dominantHand == "Left") {

      canvas = canvasLeft;
      toolBar = toolBarLeft;
      slider_brushSize_C = slider_brushSize_C_Left;
      slider_transparency_C = slider_transparency_C_Left;
      gradientBox = gradientBoxLeft;
      gradientTextBox = gradientTextBoxLeft;
      slider_brightness = slider_brightness_Left;
      navigatorCR_switchBox = navigatorCR_switchBox_Left;
      clearAll_button_dimensions = clearAll_button_dimensions_Left;
      eraser_dimensions = eraser_dimensions_Left;
      paint_dimensions = paint_dimensions_Left;
      addColor_box_size = addColor_box_size_Left;
      colorShow_dimensions = colorShow_dimensions_Left;
      undoButton_dimensions = undoButton_dimensions_Left;
      coord_dimensions = coord_dimensions_Left;
      colorPalette_size = colorPalette_size_Left;

    }

    else if (dominantHand == "Right") {

      canvas = canvasRight;
      toolBar = toolBarRight;
      slider_brushSize_C = slider_brushSize_C_Right;
      slider_transparency_C = slider_transparency_C_Right;
      gradientBox = gradientBoxRight;
      gradientTextBox = gradientTextBoxRight;
      slider_brightness = slider_brightness_Right;
      navigatorCR_switchBox = navigatorCR_switchBox_Right;
      clearAll_button_dimensions = clearAll_button_dimensions_Right;
      eraser_dimensions = eraser_dimensions_Right;
      paint_dimensions = paint_dimensions_Right;
      addColor_box_size = addColor_box_size_Right;
      colorShow_dimensions = colorShow_dimensions_Right;
      undoButton_dimensions = undoButton_dimensions_Right;
      coord_dimensions = coord_dimensions_Right;
      colorPalette_size = colorPalette_size_Right;
    }

  }

}




void drawLogo(float x, float y, float size) { //Makes the logo for the paint software
  
  pushMatrix();
  translate(x, y);
  
  colorMode(RGB, 255);
  
  textSize(size);
  fill(255);
  
  text("\uD83C\uDFA8", 0, 0);
  
  float rSize = size * 0.75;
  float xOffset = size * 0.22;
  float yOffset = -size * 0.18;
  
  textSize(rSize);
  fill(40, 40, 40);
  
  text("\u211B", xOffset, yOffset); 
  
  popMatrix();
}


void eraserSymbol(float x, float y, float sizeX, float sizeY) { //Makes the eraser symbol for the eraser button
  
  pushMatrix();
  translate(x, y);
  rotate(45);
  
  colorMode(RGB, 255);
  rectMode(CENTER);
  
  stroke(0);
  strokeWeight(3);
  
  fill(255);
  
  rect(0, 0, sizeX, sizeY);
  
  fill(0);
  
  rectMode(CORNER);
  
  rect(
    (-1 * sizeX) / 2,
    (-1 * sizeY) / 2,
    sizeX,
    sizeY * 0.7
  );
  
  noStroke();
  
  rectMode(CORNERS);
  
  popMatrix();
}

void saveFile2() { //Allows for us to save the canvas into a .png, .tiff. .jpg. .tga file
  if (x >= save_button_dimensions[0] && y >= save_button_dimensions[1] && x <= save_button_dimensions[2] && y <= save_button_dimensions[3]) {
    fill(150);
    if (mousePressed && !save_pressed) {
      save_pressed = true;
    }
    if (!mousePressed && save_pressed) {
      selectOutput("Choose where to save your artwork:", "fileSelected");
    }
  }
  else {
    fill(190);
  }
  noStroke();
  rect(
    save_button_dimensions[0],
    save_button_dimensions[1],
    save_button_dimensions[2],
    save_button_dimensions[3]
  );
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  text(
    "Save File",
    save_button_dimensions[0],
    save_button_dimensions[1],
    save_button_dimensions[2],
    save_button_dimensions[3]
  );
  
  
  if (!mousePressed) {
    save_pressed = false;
  }
}


void fileSelected(File selection) { //Helps the save function get a location for the file
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    String path = selection.getAbsolutePath();
    
    // Optional: Ensure the file ends with a valid image extension if the user forgot
    if (!path.toLowerCase().endsWith(".png") && 
        !path.toLowerCase().endsWith(".jpg") && 
        !path.toLowerCase().endsWith(".tif")) {
      path += ".png"; // default to png
    }
    
    // Save the graphic to the selected path
    drawingLayer.save(path);
    println("User selected " + path);
    saveMessage = "Artwork Saved!";
    saveMessageTimer = 180;
  }
}

void upload() { //Allows us to upload a photo into the canvas
  if (x >= upload_button_dimensions[0] && y >= upload_button_dimensions[1] && x <= upload_button_dimensions[2] && y <= upload_button_dimensions[3]) {
    fill(150);
    if (mousePressed && !upload_pressed) {
      upload_pressed = true;
    }
    if (!mousePressed && upload_pressed) {
      selectInput("Select an image to load:", "fileSelected2");
    }
  }
  else {
    fill(190);
  }
  noStroke();
  rect(
    upload_button_dimensions[0],
    upload_button_dimensions[1],
    upload_button_dimensions[2],
    upload_button_dimensions[3]
  );
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(16);
  
  text(
    "Upload File",
    upload_button_dimensions[0],
    upload_button_dimensions[1],
    upload_button_dimensions[2],
    upload_button_dimensions[3]
  );
  
  if (!mousePressed) {
    upload_pressed = false;
  }
  
}

void fileSelected2(File selection) { //Assists the Upload function to get the directory of a certain image
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    println("User selected " + selection.getAbsolutePath());
    
    PImage tempHold = loadImage(selection.getAbsolutePath());
    
    if (tempHold != null) {
      tempHold.resize(drawingLayer.width, drawingLayer.height);
      
      uploadImage = tempHold;
      
      drawingLayer.beginDraw();
      drawingLayer.background(255);
      drawingLayer.image(uploadImage, 0, 0); // No scaling stretching needed now
      drawingLayer.endDraw();
      
      tempHold = null;
      System.gc();
      
      initializedCanvas = true;
      println("Image uploaded and safety-scaled successfully.");
    }
  }
}




void colorShow() { //Shows the RGB or HSB code depending on preferences
  if (userPosition == "Realistic") {
    if (colorNotation == "RGB") {
      colorMode(HSB, 255);
      fill(0, 0, 0);
      textSize(18);
      textAlign(LEFT, TOP);
      text(
        "Red (R): " + round(red(color(brush_hue, brush_saturation, brush_brightness))) + "\n" + 
        "Green (G): " + round(green(color(brush_hue, brush_saturation, brush_brightness))) + "\n" + 
        "Blue (B): " + round(blue(color(brush_hue, brush_saturation, brush_brightness))), 
        colorShow_dimensions[0],
        colorShow_dimensions[1],
        colorShow_dimensions[2],
        colorShow_dimensions[3]
      );
    }
    else if (colorNotation == "HSB") {
      colorMode(HSB, 255);
      fill(0, 0, 0);
      textSize(18);
      textAlign(LEFT, TOP);
      text(
        "Hue (H): " + round(brush_hue) + "\n" + 
        "Saturation (S): " + round(brush_saturation) + "\n" + 
        "Brightness (B): " + round(brush_brightness), 
        colorShow_dimensions[0],
        colorShow_dimensions[1],
        colorShow_dimensions[2],
        colorShow_dimensions[3]
      );
    }
  }
}
