import java.util.Arrays;

ArrayList<Piece> boardPieces = new ArrayList<Piece>();
LogicMaster boardTracker;

Piece pickedUp = null;
HashMap<String,PImage> pieceImages = new HashMap<String,PImage>();

int BUFFER_LENGTH = 100;
String COLUMN_LABELS[] = { "8", "7", "6", "5", "4", "3", "2", "1" };
String ROW_LABELS[] = { "a", "b", "c", "d", "e", "f", "g", "h" };

float chessboardLength;
float squareLength;

void setup() {
  fullScreen();
  
  chessboardLength = height-BUFFER_LENGTH*2;
  squareLength = chessboardLength / 8;
  
  boardTracker = new LogicMaster();
  
  loadGamePieces();
  initGame();
  
  boardTracker.printBoard();
}

void draw() {
  background(94, 63, 6);

  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, width-50, height-50);  
  
  drawChessboard();
  drawBoardPieces();
  
  if (pickedUp != null) {
    image(choosePieceImage(pickedUp.pieceType,pickedUp.pieceColor), mouseX, mouseY, squareLength, squareLength);
  }
}

void mousePressed() {
  int xPos = floor((mouseX - BUFFER_LENGTH)/squareLength);
  int yPos = floor(((height - mouseY) - BUFFER_LENGTH)/squareLength);
  
  if (xPos >= 0 && yPos >= 0 && xPos < 8 && yPos < 8) {
    if (pickedUp == null) {
      for (int i = 0; i < boardPieces.size(); i++) {
        Piece currPiece = boardPieces.get(i);
        if (currPiece.chessX == xPos && currPiece.chessY == yPos) {
           pickedUp = currPiece;
           boardPieces.remove(i);
           break;
        }
      }
    } else {
      boardPieces.add(new Piece(xPos, yPos, pickedUp.pieceType, pickedUp.pieceColor));
      pickedUp = null;
    }
  }
  
}

void drawBoardPieces() {
  imageMode(CENTER);
  for (int i = 0; i < boardPieces.size(); i++) {
    PImage placeImage = null;
    
    Piece currPiece = boardPieces.get(i);
    placeImage = choosePieceImage(currPiece.pieceType, currPiece.pieceColor);
    
    image(placeImage, BUFFER_LENGTH+squareLength/2+squareLength*currPiece.chessX, height-(BUFFER_LENGTH+squareLength/2+squareLength*currPiece.chessY), squareLength, squareLength);
  }
}

PImage choosePieceImage(Type pieceType, Color pieceColor) {
  switch (pieceType) {
      case PAWN:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("pWhite");
        } else {
          return pieceImages.get("pBlack"); 
        }
      case BISHOP:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("bWhite");
        } else {
          return pieceImages.get("bBlack");
        }
      case KNIGHT:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("nWhite");
        } else {
          return pieceImages.get("nBlack");
        }
      case ROOK:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("rWhite");
        } else {
          return pieceImages.get("rBlack");
        }
      case QUEEN:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("qWhite");
        } else {
          return pieceImages.get("qBlack");
        }
      case KING:
        if (pieceColor == Color.WHITE) {
          return pieceImages.get("kWhite");
        } else {
          return pieceImages.get("kBlack");
        }
      default:
        return null;
    }
}

void loadGamePieces() {
   pieceImages.put("pWhite", loadImage("chess_pieces/pawn_white.png"));
   pieceImages.put("pBlack", loadImage("chess_pieces/pawn_black.png"));
   pieceImages.put("bWhite", loadImage("chess_pieces/bishop_white.png"));
   pieceImages.put("bBlack", loadImage("chess_pieces/bishop_black.png"));
   pieceImages.put("nWhite", loadImage("chess_pieces/knight_white.png"));
   pieceImages.put("nBlack", loadImage("chess_pieces/knight_black.png"));
   pieceImages.put("rWhite", loadImage("chess_pieces/rook_white.png"));
   pieceImages.put("rBlack", loadImage("chess_pieces/rook_black.png"));
   pieceImages.put("qWhite", loadImage("chess_pieces/queen_white.png"));
   pieceImages.put("qBlack", loadImage("chess_pieces/queen_black.png"));
   pieceImages.put("kWhite", loadImage("chess_pieces/king_white.png"));
   pieceImages.put("kBlack", loadImage("chess_pieces/king_black.png"));
}

void drawChessboard() {
  fill(255, 222, 181);
  rect(BUFFER_LENGTH+chessboardLength/2, BUFFER_LENGTH+chessboardLength/2, chessboardLength+75, chessboardLength+75);

  fill(150, 101, 9);
  rect(BUFFER_LENGTH+chessboardLength/2, BUFFER_LENGTH+chessboardLength/2, chessboardLength+10, chessboardLength+10);

  boolean lightSquare = true;

  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      if (lightSquare) {
        stroke(255, 222, 181);
        fill(255, 222, 181);
      } else {
        stroke(150, 101, 9);
        fill(150, 101, 9);
      }
      rect(BUFFER_LENGTH+squareLength*j+squareLength/2, BUFFER_LENGTH+squareLength*i+squareLength/2, squareLength, squareLength);
      lightSquare = !lightSquare;
    }

    lightSquare = !lightSquare;
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
    boardPieces.add(new Piece(i,1,Type.PAWN,Color.WHITE));
    boardTracker.addPiece(i,1,Type.PAWN,Color.WHITE);
    
    boardPieces.add(new Piece(i,6,Type.PAWN,Color.BLACK));
    boardTracker.addPiece(i,6,Type.PAWN,Color.BLACK);
  }
  
  Type backRowInit[] = { Type.ROOK, Type.KNIGHT, Type.BISHOP, Type.QUEEN, Type.KING, Type.BISHOP, Type.KNIGHT, Type.ROOK };
  
  // backrows
  for (int i = 0; i < 8; i++) {
    boardPieces.add(new Piece(i,0,backRowInit[i],Color.WHITE));
    boardTracker.addPiece(i,0,backRowInit[i],Color.WHITE);
    
    boardPieces.add(new Piece(i,7,backRowInit[i],Color.BLACK));
    boardTracker.addPiece(i,7,backRowInit[i],Color.BLACK);
  }
  
}
