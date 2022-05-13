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
  int chess_x;
  int chess_y;
  Type piece_type;
  Color piece_color;
  
  Piece(int x, int y, Type type, Color p_color) {
    chess_x = x;
    chess_y = y;
    piece_type = type;
    piece_color = p_color;
  }
}
