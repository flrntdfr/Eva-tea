// Florent Dufour
// April 2018
// Renders a planche of yogi-tea affirmations

// Caveat: max ... affirmations can be rendered. Does not support multi-page.

import processing.pdf.*;

final int ONE_CM_IN_PIX = 28;
final int CANEVAS_WIDTH = 595;
final int CANEVAS_HEIGHT = 842;
final float LITTLE_PAPER_WIDTH_IN_CM = 3.1;
final float LITTLE_PAPER_HEIGHT_IN_CM =  2.8;
final int MARGIN = cmToPix(0.3);
final int PADDING = cmToPix(0.5);
final int LITTLE_PAPER_BACKGROUND_COLOR = color(176, 26, 83);
final int LITTLE_PAPER_FONT_COLOR = 255;
final int TEXT_FONT_SIZE = 8;
PFont TEXT_FONT;
String[] affirmations;

void setup() {
  noLoop();
  background(255);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  TEXT_FONT = createFont("Avenir", 32);
  textFont(TEXT_FONT);
  textSize(TEXT_FONT_SIZE);
  affirmations = loadStrings("affirmations.txt");
  size(595, 842, PDF, "out/render.pdf"); // Size does not support variables and surfacce.setSize() does not support PDF rendering... So... hardcoded values.

  println("[INFO] Canevas size: " + width + "px / " + height + "px");
  if (affirmations.length <= 54) {
    println("[INFO] " + affirmations.length + " affirmations loaded from file");
  } else {
    println("[ERROR] " + affirmations.length + " affirmations loaded. Too much.");
  }
}

void draw() {
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
        fill(LITTLE_PAPER_FONT_COLOR);
        ellipse(10, 10, 3, 3);
        text (affirmation, littlePaperWidth/2, littlePaperHeight/2, littlePaperWidth - PADDING, littlePaperHeight);
      } 
      catch (Exception e) {
        // No text to print, do not draw rectangle (save ink)
      }
      indexOfAffirmation++;

      popMatrix();
    }
  }
  println("[INFO] Output rendered");
  exit();
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
