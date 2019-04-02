// Florent Dufour
// April 2018
// Renders a planche of yogi-tea affirmations

import processing.pdf.*;

final int ONE_CM_IN_PIX = 28;
final int CANEVAS_WIDTH = 595;
final int CANEVAS_HEIGHT = 842;
final float LITTLE_PAPER_WIDTH_IN_CM = 3.1;
final float LITTLE_PAPER_HEIGHT_IN_CM = 2.8;
final int MARGIN = cmToPix(0.3);
final int PADDING = cmToPix(0.5);
final int LITTLE_PAPER_BACKGROUND_COLOR = 51;
//final int LITTLE_PAPER_FONT_COLOR = 51;
final int TEXT_FONT_SIZE = 8;
String[] affirmations;

void setup() {
  noLoop();
  surface.setSize(CANEVAS_WIDTH, CANEVAS_HEIGHT);
  background(255);
  textSize(TEXT_FONT_SIZE);
  affirmations = loadStrings("affirmations.txt");
  println(affirmations[0]);
  textAlign(CENTER, CENTER);
  beginRecord(PDF, "out/planche_Eva_tea.pdf");
}

void draw() {
  noStroke();
  final int NUMBER_OF_COLUMNS = getMaxElement(cmToPix(LITTLE_PAPER_WIDTH_IN_CM), CANEVAS_WIDTH, MARGIN);
  final int NUMBER_OF_ROWS = getMaxElement(cmToPix(LITTLE_PAPER_HEIGHT_IN_CM), CANEVAS_HEIGHT, MARGIN);
  
  fill(LITTLE_PAPER_BACKGROUND_COLOR); 
  
  final int littlePaperWidth = cmToPix(LITTLE_PAPER_WIDTH_IN_CM);
  final int littlePaperHeight = cmToPix(LITTLE_PAPER_HEIGHT_IN_CM);
  
  int indexOfAffirmation = 0;
  
  for (int j = 0; j < NUMBER_OF_ROWS; j++) {
    for (int i = 0; i < NUMBER_OF_COLUMNS; i++) {
      pushMatrix();
      translate((i+1) * MARGIN + i * littlePaperWidth, (j+1) * MARGIN + j * littlePaperHeight);
      fill(LITTLE_PAPER_BACKGROUND_COLOR);
      
      rectMode(CENTER);
      rect(littlePaperWidth/2, littlePaperHeight/2, littlePaperWidth, littlePaperHeight);
      fill(255);
      ellipse(10,10,3,3);
      try {
        text (affirmations[indexOfAffirmation], littlePaperWidth/2, littlePaperHeight/2, littlePaperWidth - PADDING, littlePaperHeight);
      } 
      catch (Exception e) {
        // Do nothing...
      }
      indexOfAffirmation++;
      popMatrix();
    }
  }
  saveFrame("out/planche_Eva_tea.tiff");
  endRecord();
}

int cmToPix(float cm) {
  return int(cm * ONE_CM_IN_PIX);
}

int getMaxElement(int sizeOfElement, int availableSpace, int margin) {
  int terminalMargins = 2 * margin;
  int numberOfElements = 1; // At least 1
  int totalSize = terminalMargins + numberOfElements * sizeOfElement;

  // We assume the margins alone do not exceed the page width or height
  while (totalSize < (availableSpace - (sizeOfElement + margin))) {
    numberOfElements++;
    totalSize += sizeOfElement + numberOfElements;
  }
  println("[INFO] Max elements: " + numberOfElements);
  return numberOfElements;
}
