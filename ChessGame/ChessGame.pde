import java.util.Arrays;

ArrayList<Piece> board_pieces = new ArrayList<Piece>();
Piece picked_up = null;
HashMap<String,PImage> piece_images = new HashMap<String,PImage>();

int BUFFER_LENGTH = 100;
String COLUMN_LABELS[] = { "8", "7", "6", "5", "4", "3", "2", "1" };
String ROW_LABELS[] = { "a", "b", "c", "d", "e", "f", "g", "h" };

float chessboardLength;
float squareLength;

void setup() {
  fullScreen();
  
  chessboardLength = height-BUFFER_LENGTH*2;
  squareLength = chessboardLength / 8;
  
  loadGamePieces();
  initGame();
}

void draw() {
  background(94, 63, 6);

  fill(255);
  rectMode(CENTER);
  rect(width/2, height/2, width-50, height-50);  
  
  drawChessboard();
  drawBoardPieces();
  
  if (picked_up != null) {
     image(piece_images.get("pWhite"), mouseX, mouseY, squareLength, squareLength);
  }
}

void mousePressed() {
  int x_pos = floor((mouseX - BUFFER_LENGTH)/squareLength);
  int y_pos = floor(((height - mouseY) - BUFFER_LENGTH)/squareLength);
  
  if (x_pos >= 0 && y_pos >= 0 && x_pos < 8 && y_pos < 8) {
    for (int i = 0; i < board_pieces.size(); i++) {
      Piece curr_piece = board_pieces.get(i);
      if (curr_piece.chess_x == x_pos && curr_piece.chess_y == y_pos) {
         picked_up = curr_piece;
         board_pieces.remove(i);
         break;
      }
    }
  }
  
}

void drawBoardPieces() {
  imageMode(CENTER);
  for (int i = 0; i < board_pieces.size(); i++) {
    PImage place_image = null;
    
    Piece curr_piece = board_pieces.get(i);
    switch (curr_piece.piece_type) {
      case PAWN:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("pWhite");
        } else {
          place_image = piece_images.get("pBlack"); 
        }
        break;
      case BISHOP:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("bWhite");
        } else {
          place_image = piece_images.get("bBlack");
        }
        break;
      case KNIGHT:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("nWhite");
        } else {
          place_image = piece_images.get("nBlack");
        }
        break;
      case ROOK:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("rWhite");
        } else {
          place_image = piece_images.get("rBlack");
        }
        break;
      case QUEEN:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("qWhite");
        } else {
          place_image = piece_images.get("qBlack");
        }
        break;
      case KING:
        if (curr_piece.piece_color == Color.WHITE) {
          place_image = piece_images.get("kWhite");
        } else {
          place_image = piece_images.get("kBlack");
        }
        break;
      default:
        break;
    }
    
    image(place_image, BUFFER_LENGTH+squareLength/2+squareLength*curr_piece.chess_x, height-(BUFFER_LENGTH+squareLength/2+squareLength*curr_piece.chess_y), squareLength, squareLength);
  }
}

void loadGamePieces() {
   piece_images.put("pWhite", loadImage("chess_pieces/pawn_white.png"));
   piece_images.put("pBlack", loadImage("chess_pieces/pawn_black.png"));
   piece_images.put("bWhite", loadImage("chess_pieces/bishop_white.png"));
   piece_images.put("bBlack", loadImage("chess_pieces/bishop_black.png"));
   piece_images.put("nWhite", loadImage("chess_pieces/knight_white.png"));
   piece_images.put("nBlack", loadImage("chess_pieces/knight_black.png"));
   piece_images.put("rWhite", loadImage("chess_pieces/rook_white.png"));
   piece_images.put("rBlack", loadImage("chess_pieces/rook_black.png"));
   piece_images.put("qWhite", loadImage("chess_pieces/queen_white.png"));
   piece_images.put("qBlack", loadImage("chess_pieces/queen_black.png"));
   piece_images.put("kWhite", loadImage("chess_pieces/king_white.png"));
   piece_images.put("kBlack", loadImage("chess_pieces/king_black.png"));
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
    board_pieces.add(new Piece(i,1,Type.PAWN,Color.WHITE));
    board_pieces.add(new Piece(i,6,Type.PAWN,Color.BLACK));
  }
  
  Type back_row_init[] = { Type.ROOK, Type.KNIGHT, Type.BISHOP, Type.QUEEN, Type.KING, Type.BISHOP, Type.KNIGHT, Type.ROOK };
  
  // backrows
  for (int i = 0; i < 8; i++) {
    board_pieces.add(new Piece(i,0,back_row_init[i],Color.WHITE));
    board_pieces.add(new Piece(i,7,back_row_init[i],Color.BLACK));
  }
  
}
