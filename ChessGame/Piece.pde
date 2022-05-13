enum Type {
  PAWN,
  KNIGHT,
  BISHOP,
  ROOK,
  QUEEN,
  KING
}

class Piece {
  int chess_x;
  int chess_y;
  Type piece_type;
  
  Piece(int x, int y, Type type) {
    chess_x = x;
    chess_y = y;
    piece_type = type;
  }
}
