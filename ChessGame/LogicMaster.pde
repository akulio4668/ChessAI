class LogicMaster {
  
  ArrayList<ArrayList<Piece>> boardRepresentation = new ArrayList<ArrayList<Piece>>();
  Piece pickedUp = null;
  boolean whiteTurn = true;
  
  LogicMaster() {
    initBoard();
  }
  
  void initBoard() {
    Type backRowInit[] = { Type.ROOK, Type.KNIGHT, Type.BISHOP, Type.QUEEN, Type.KING, Type.BISHOP, Type.KNIGHT, Type.ROOK };
    
    for (int i = 0; i < 8; i++) {
      ArrayList<Piece> currRow = new ArrayList<Piece>();
      
      switch (i) {
        case 0:
          for (int j = 0; j < 8; j++) {
            currRow.add(new Piece(j,i,backRowInit[j],Color.WHITE));
          }
          break;
         
        case 1:
          for (int j = 0; j < 8; j++) {
            currRow.add(new Piece(j,i,Type.PAWN,Color.WHITE));
          }
          break;
        
        case 6:
          for (int j = 0; j < 8; j++) {
             currRow.add(new Piece(j,i,Type.PAWN,Color.BLACK));
          }
          break;
          
        case 7:
          for (int j = 0; j < 8; j++) {
            currRow.add(new Piece(j,i,backRowInit[j],Color.BLACK)); 
          }
          break;
        
        default:
          for (int j = 0; j < 8; j++) {
            currRow.add(null);
          }   
      }
      
      boardRepresentation.add(currRow);
    }
  }
  
  void printBoard() {
   for (int i = 0; i < 8; i++) {
     for (int j = 0; j < 8; j++) {
       System.out.print(boardRepresentation.get(i).get(j) + "\t");
     }
     System.out.println("");
   }
   System.out.println("\n\n\n");
  }
  
  Piece getPiece(int x, int y) {
    return boardRepresentation.get(y).get(x);
  }
  
  Piece piecePickedUp() {
    return pickedUp; 
  }
  
  void pickDropHandler(int x, int y) {
    if (pickedUp == null) {
      if (boardRepresentation.get(y).get(x) != null) {
        pickedUp = boardRepresentation.get(y).get(x);
        boardRepresentation.get(y).set(x,null);
      }
    } else {
       boolean canDrop = dropPieceChecker(x,y); 
       if (canDrop) {
         boardRepresentation.get(y).set(x, new Piece(x,y,pickedUp.pieceType,pickedUp.pieceColor));
       } else {
         boardRepresentation.get(pickedUp.chessY).set(pickedUp.chessX, pickedUp);
       }
       pickedUp = null;
    }
  }
  
  boolean dropPieceChecker(int x, int y) {
    
    if ((whiteTurn && pickedUp.pieceColor == Color.BLACK) || (!whiteTurn && pickedUp.pieceColor == Color.WHITE)) {
      return false; 
    }
    
    Piece destSpace = getPiece(x,y);
    
    if (destSpace != null) {
      if (pickedUp.pieceColor == destSpace.pieceColor) {
        return false;
      } else {
        switch (pickedUp.pieceType) {
          case PAWN:
            if (pickedUp.chessX != (x - 1) && pickedUp.chessX != (x + 1)) {
              return false;
            }
       
            if (pickedUp.pieceColor == Color.WHITE) {              
              if (pickedUp.chessY != (y - 1)) {
                return false; 
              }
            } else {
              if (pickedUp.chessY != (y + 1)) {
                return false; 
              }
            }
            break;
          default:
            break;
        }
      }
    } else {
      switch (pickedUp.pieceType) {
        case PAWN:
          if (pickedUp.chessX != x) {
            return false; 
          }
          
          if (pickedUp.pieceColor == Color.WHITE) {
            if (pickedUp.chessY == 1) {
              if ((y -  pickedUp.chessY) != 2 && (y - pickedUp.chessY) != 1) {
                return false;
              }
              
              if ((y - pickedUp.chessY) == 2 && getPiece(x,pickedUp.chessY + 1) != null) {
                return false; 
              }
            } else {
              if ((y - pickedUp.chessY) != 1) {
                return false; 
              }
            }
          } else {      
            if (pickedUp.chessY == 6) {
              if ((pickedUp.chessY - y) != 2 && (pickedUp.chessY - y) != 1) {
                return false;
              }
              
              if ((pickedUp.chessY - y) == 2 && getPiece(x,pickedUp.chessY - 1) != null) {
                return false; 
              }
            } else {
              if ((pickedUp.chessY - y) != 1) {
                return false; 
              }
            }
          }
          break;
        default:
          break;
      }
    }
    
    whiteTurn = !whiteTurn;
    return true;
  }
}
