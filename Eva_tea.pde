// Florent Dufour
// April 2018
// Renders a planche of yogi-tea affirmations

// Caveat: does not support multi page

import processing.pdf.*;

final int SCALE = 3; // Experimental, switch back to 1 for normal behavior
final int ONE_CM_IN_PIX = SCALE * 28;
final int CANEVAS_WIDTH = SCALE * 595;
final int CANEVAS_HEIGHT = SCALE * 842;
final float LITTLE_PAPER_WIDTH_IN_CM = 3.1;
final float LITTLE_PAPER_HEIGHT_IN_CM =  2.8;
final int MARGIN = cmToPix(0.3);
final int PADDING = cmToPix(0.5);
final int LITTLE_PAPER_BACKGROUND_COLOR = color(176, 26, 83);
//final int LITTLE_PAPER_FONT_COLOR = 51;
final int TEXT_FONT_SIZE = SCALE * 8;
String[] affirmations;

void setup() {
  noLoop();
  background(255);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  textSize(TEXT_FONT_SIZE);
  affirmations = loadStrings("affirmations.txt");
  surface.setSize(CANEVAS_WIDTH, CANEVAS_HEIGHT);
  println("[INFO] Canevas size: " + width + "px / " + height + "px");
  println("[INFO] " + affirmations.length + " affirmations loaded from file");

  //beginRecord(PDF, "out/planche_Eva_tea.pdf");
}

void draw() {
  noStroke();
  final int NUMBER_OF_COLUMNS = getMaxElements(cmToPix(LITTLE_PAPER_WIDTH_IN_CM), CANEVAS_WIDTH, MARGIN);
  final int NUMBER_OF_ROWS = getMaxElements(cmToPix(LITTLE_PAPER_HEIGHT_IN_CM), CANEVAS_HEIGHT, MARGIN);

  println("[INFO] Max columns: " + NUMBER_OF_COLUMNS);
  println("[INFO] Max rows: " + NUMBER_OF_ROWS);

  fill(LITTLE_PAPER_BACKGROUND_COLOR); 

  final int littlePaperWidth = cmToPix(LITTLE_PAPER_WIDTH_IN_CM);
  final int littlePaperHeight = cmToPix(LITTLE_PAPER_HEIGHT_IN_CM);

  int indexOfAffirmation = 0;

  for (int j = 0; j < NUMBER_OF_ROWS; j++) {
    for (int i = 0; i < NUMBER_OF_COLUMNS; i++) {
      pushMatrix();

      try {
        String affirmation = affirmations[indexOfAffirmation];
        translate((i+1) * MARGIN + i * littlePaperWidth, (j+1) * MARGIN + j * littlePaperHeight);
        fill(LITTLE_PAPER_BACKGROUND_COLOR);

        rect(littlePaperWidth/2, littlePaperHeight/2, littlePaperWidth, littlePaperHeight);
        fill(255);
        ellipse(SCALE * 10, SCALE * 10, SCALE * 3, SCALE * 3);
        text (affirmation, littlePaperWidth/2, littlePaperHeight/2, littlePaperWidth - PADDING, littlePaperHeight);
      } 
      catch (Exception e) {
        // No text to print, do not draw rectangle (save ink)
      }
      indexOfAffirmation++;

      popMatrix();
    }
  }
  saveFrame("out/planche_Eva_tea.tiff");
  //endRecord();
}

/**
 * Converts cm in pix
 * <p>
 * It is easier to use pixels in the sketch but the real world paper are expressed in cm.
 */
int cmToPix(float cm) {
  return int(cm * ONE_CM_IN_PIX);
}

/**
 * Get the maximum of little paper that can fit on the page.
 * <p>
 * This can be independently used for rows or columns.
 */
int getMaxElements(int sizeOfElement, int availableSpace, int margin) {
  int terminalMargins = 2 * margin;
  int numberOfElements = 1; // At least 1
  int totalSize = terminalMargins + numberOfElements * sizeOfElement;

  // We assume the margins alone do not exceed the page width or height
  while (totalSize < (availableSpace - (sizeOfElement + margin))) {
    numberOfElements++;
    totalSize += sizeOfElement + numberOfElements;
  }
  return numberOfElements;
}
