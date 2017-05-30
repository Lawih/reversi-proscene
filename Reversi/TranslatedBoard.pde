class TranslatedBoard{
  Tile[][] tiles;
  Board board;
  int size;
  
  public TranslatedBoard( int size, Board board ){
    this.size = size;
    tiles = new Tile[size][size];
    this.board = board; 
    translateBoard();
  } 
  
  public void translateBoard(){
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
          tiles[i][j].setPosition(tiles[i][j].getSize() * ((float) j - (float) size / 2 + 0.5), tiles[i][j].getSize() * ((float) i - (float) size / 2 + 0.5), 0);
      }
    }
  }
  
  public void clear(){
    tiles = new Tile[size][size];    
  } 
  
  public void makeMove(Tile tile) {
    Pair mov;

    for( int i = 0; i < size; ++i ){
      for( int j = 0; j < size; ++j ){
        if (tiles[i][j] == tile) { // is this the tile we click on?
          mov = new Pair(j, i);
        }
      }
    }
    
    board.makeAMove(mov, 'B');
    print(mov.x);
    println();
    print(mov.y);
    translateBoard();
  }  
}