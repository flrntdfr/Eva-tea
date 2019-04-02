final int ONE_CM_IN_PIX = 28;
final int CANEVAS_WIDTH = 595;
final int CANEVAS_HEIGHT = 842;
final float LITTLE_PAPER_WIDTH_IN_CM = 3.1;
final float LITTLE_PAPER_HEIGHT_IN_CM = 2.8;
final int MARGIN = int(0.3 * ONE_CM_IN_PIX);
final int PADDING = int(0.5 * ONE_CM_IN_PIX);
final int LITTLE_PAPER_BACKGROUND_COLOR = 51;
final int LITTLE_PAPER_FONT_COLOR = 51;
final int TEXT_FONT_SIZE = 12;

void setup() {
  noLoop();
  surface.setSize(CANEVAS_WIDTH, CANEVAS_HEIGHT);
  background(255);
  textSize(TEXT_FONT_SIZE);
}

void draw() {
  noStroke();
  //final int NUMBER_OF_COLUMNS = getMaxColumns();
  final int NUMBER_OF_COLUMNS = getMaxElement(cmToPix(LITTLE_PAPER_WIDTH_IN_CM), CANEVAS_WIDTH, MARGIN);
  final int NUMBER_OF_ROWS = getMaxElement(cmToPix(LITTLE_PAPER_HEIGHT_IN_CM), CANEVAS_HEIGHT, MARGIN);
  //final int NUMBER_OF_ROWS = getMaxRows();
  fill(LITTLE_PAPER_BACKGROUND_COLOR); 
  final int littlePaperWidth = cmToPix(LITTLE_PAPER_WIDTH_IN_CM);
  final int littlePaperHeight = cmToPix(LITTLE_PAPER_HEIGHT_IN_CM);
  print("[INFO] Max Columns: " + NUMBER_OF_COLUMNS);
  for (int j = 0; j < NUMBER_OF_ROWS; j++) {
    for (int i = 0; i < NUMBER_OF_COLUMNS; i++) {
      PVector origin = new PVector((i+1) * MARGIN + i * littlePaperWidth, (j+1) * MARGIN + j * littlePaperHeight);
      fill(LITTLE_PAPER_BACKGROUND_COLOR);
      rect(origin.x, origin.y, littlePaperWidth, littlePaperHeight);
      fill(255);
      text("word", origin.x+PADDING, origin.y + PADDING + TEXT_FONT_SIZE);
    }
  }
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
    println("[INFO - Number of elements] " + numberOfElements + " : " + totalSize + " occupied over " + availableSpace);
  }
  return numberOfElements;
}
