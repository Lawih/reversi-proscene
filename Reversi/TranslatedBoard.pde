class TranslatedBoard{
  Tile[][] tiles;
  Board board;
  int size;
  char player;
  boolean skipped;
  boolean showingMoves;
  
  public TranslatedBoard( int size, Board board, char player ){
    this.size = size;
    tiles = new Tile[size][size];
    this.board = board; 
    this.player = player;
    showingMoves = true;
    createBoard();
    translateBoard();
  } 
  
  public void createBoard(){
    for( int i = 0; i < board.size; ++i ){
      for( int j = 0; j < board.size; ++j ){
        tiles[i][j] = new Tile( '-', 160f / size, scene, this); // create the new tile;        
      }
    }
  }
  
  public void translateBoard(){
    if( showingMoves ){
      setValues(this.board.getPossibleMovementsMarked(player));      
    }
    else{
      setValues(this.board.board);
    }
  }
  
  public void setValues( char[][] board ){
    for( int i = 0; i < this.board.size; ++i ){
      for( int j = 0; j < this.board.size; ++j ){
        tiles[i][j].setValue(board[i][j]); // Set new value;        
      }
    }    
  }
  
  public void update() {    
    translateBoard();
    for( int i = 0; i < size; ++i ){
      for( int j = 0; j < size; ++j ){
        if (tiles[j][i] != null)
          // recompute the patch appropriate position based on current column and row count (x, y)
          // patches[][].getSize() * x, moves the patch relative to the board position
          // patches[][].getSize * (x - size / 2 + 0.5), centers the board in world space
          tiles[i][j].setPosition(tiles[i][j].getSize() * ((float) j - (float) size / 2 + 0.5), tiles[i][j].getSize() * ((float) i - (float) size / 2 + 0.5), 0);
      }
    }
  }
  
  public void clear(){
    tiles = new Tile[size][size];    
  } 
  
  public void setOppositePlayer(){
    if( player == 'W' )
      player = 'B';
    else
      player = 'W';
  }
  
  public void setShowingMoves( ){
    showingMoves = !showingMoves;
  }
  
  public void makeMove(Tile tile) {
    Pair mov = null;

    for( int i = 0; i < size; ++i ){
      for( int j = 0; j < size; ++j ){
        if (tiles[i][j] == tile) { // Is this the tile we click on?
          mov = new Pair(j, i);
        }
      }
    }
    
    if( mov != null ){
      if ( board.makeAMove(mov, player) ){
        // Change player
        setOppositePlayer();
        
        // Check if next player has movements
        if( board.possibleMovements(player).isEmpty() ){
          skipped = true;
          setOppositePlayer();
        }
      }
      
      // translateBoard();
    }
  }  
}