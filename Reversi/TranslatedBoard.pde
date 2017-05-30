class TranslatedBoard{
  Tile[][] tiles;
  int size;
  
  public TranslatedBoard( int size, Board board ){
    this.size = size;
    tiles = new Tile[size][size];
    translate(board);
  } 
  
  public void translate( Board board ){
    for( int i = 0; i < board.size; ++i ){
      for( int j = 0; j < board.size; ++j ){
        tiles[i][j] = new Tile( board.board[i][j], 160f / size, scene, this); // create the new tile;        
      }
    }
  }
  
  public void update() {
    for( int i = 0; i < size; ++i ){
      for( int j = 0; j < size; ++j ){
        if (tiles[j][i] != null)
          // recompute the patch appropriate position based on current column and row count (x, y)
          // patches[][].getSize() * x, moves the patch relative to the board position
          // patches[][].getSize * (x - size / 2 + 0.5), centers the board in world space
          tiles[j][i].setPosition(tiles[j][i].getSize() * ((float) i - (float) size / 2 + 0.5), tiles[j][i].getSize() * ((float) j - (float) size / 2 + 0.5), 0);
      }
    }
  }
  
  public void clear(){
    tiles = new Tile[size][size];    
  } 
  
  public void makeMove(Tile tile) {    
  }
  
}