class LogicMaster {
  
  ArrayList<ArrayList<String>> boardRepresentation = new ArrayList<ArrayList<String>>();
  
  LogicMaster() {
    initBoard();
  }
  
  void initBoard() {
    for (int i = 0; i < 8; i++) {
      ArrayList<String> currRow = new ArrayList<String>();
      for (int j = 0; j < 8; j++) {
        currRow.add(".");
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
  
  void addPiece(int chessX, int chessY, Type pieceType, Color pieceColor) {
    String posString = "";
    
    switch (pieceColor) {
      case BLACK:
        posString += "b";
        break;
      case WHITE:
        posString += "w";
        break;
      default:
        break;
    }
    
    switch (pieceType) {
      case PAWN:
        posString += "P";
        break;
      case KNIGHT:
        posString += "N";
        break;
      case BISHOP:
        posString += "B";
        break;
      case ROOK:
        posString += "R";
        break;
      case QUEEN:
        posString += "Q";
        break;
      case KING:
        posString += "K";
        break;
      default:
        break;
    }
    
    boardRepresentation.get(chessY).set(chessX, posString);
  }
  
  boolean movePiece(int initX, int initY, int finalX, int finalY) {
    
    if (boardRepresentation.get(initY).get(initX).substring(0,1).equals(boardRepresentation.get(finalY).get(finalX).substring(0,1))) {
      return false;
    }
    
    String pieceType = boardRepresentation.get(initY).get(initX).substring(1,2);
    
    boardRepresentation.get(finalY).set(finalX, boardRepresentation.get(initY).get(initX));
    boardRepresentation.get(initY).set(initX, ".");
    
    return true;
  }
}
