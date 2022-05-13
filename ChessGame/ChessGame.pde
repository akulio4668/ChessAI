import java.util.Arrays;

ArrayList<Piece> board_pieces = new ArrayList<Piece>();
HashMap<String,PImage> piece_images = new HashMap<String,PImage>();

int BUFFER_LENGTH = 100;
String COLUMN_LABELS[] = { "8", "7", "6", "5", "4", "3", "2", "1" };
String ROW_LABELS[] = { "a", "b", "c", "d", "e", "f", "g", "h" };

float chessboardLength;
float squareLength;

void setup() {
  fullScreen();
  background(94, 63, 6);

  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, width-50, height-50);
  
  chessboardLength = height-BUFFER_LENGTH*2;
  squareLength = chessboardLength / 8;
  
  loadGamePieces();
}

void draw() {
  drawChessboard();
  
  imageMode(CENTER);
  image(piece_images.get("pWhite"), BUFFER_LENGTH + squareLength/2, BUFFER_LENGTH + squareLength/2, squareLength, squareLength);
}

void mousePressed() {
  String coordinate_position = "(" + mouseX + "," + mouseY + ")";
  System.out.println(coordinate_position);
}

void loadGamePieces() {
   piece_images.put("pWhite", loadImage("chess_pieces/pawn_white.png"));
}

void drawChessboard() {
  fill(255, 222, 181);
  rect(BUFFER_LENGTH+chessboardLength/2, BUFFER_LENGTH+chessboardLength/2, chessboardLength+75, chessboardLength+75);

  fill(150, 101, 9);
  rect(BUFFER_LENGTH+chessboardLength/2, BUFFER_LENGTH+chessboardLength/2, chessboardLength+10, chessboardLength+10);

  boolean light_square = true;

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (light_square) {
        stroke(255, 222, 181);
        fill(255, 222, 181);
      } else {
        stroke(150, 101, 9);
        fill(150, 101, 9);
      }
      rect(BUFFER_LENGTH+squareLength*j+squareLength/2, BUFFER_LENGTH+squareLength*i+squareLength/2, squareLength, squareLength);
      light_square = !light_square;
    }

    light_square = !light_square;
  }

  for (int i = 0; i < 8; i++) {
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(150, 101, 9);
    text(COLUMN_LABELS[i], BUFFER_LENGTH-20, BUFFER_LENGTH+squareLength/2+squareLength*i);
  }

  for (int i = 0; i < 8; i++) {
    textSize(25);
    textAlign(CENTER, CENTER);
    fill(150, 101, 9);
    text(ROW_LABELS[i], BUFFER_LENGTH+squareLength/2+squareLength*i, height-BUFFER_LENGTH+15);
  }
}

void initGame() {
  // pawns 
  for (int i = 0; i < 8; i++) {
    board_pieces.add(new Piece(i,1,Type.PAWN));
    board_pieces.add(new Piece(i,6,Type.PAWN));
  }
  
}
