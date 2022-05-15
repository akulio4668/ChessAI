enum Type {
  PAWN,
  KNIGHT,
  BISHOP,
  ROOK,
  QUEEN,
  KING
}

enum Color {
  WHITE,
  BLACK
}

class Piece {
  int chessX;
  int chessY;
  Type pieceType;
  Color pieceColor;
  
  Piece(int x, int y, Type type, Color pColor) {
    chessX = x;
    chessY = y;
    pieceType = type;
    pieceColor = pColor;
  }
}
