class Board{
    char [][] board;
    int size;

    Board( int size ){
        this.size = size;
        
        board = new char[8][8];
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                board[i][j] = '-';
            }
        }
        board[3][3] = board[4][4] = 'B'; 
        board[3][4] = board[4][3] = 'W';
        /*for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                print(board[i][j]);
            }
            println();
        }*/
    }
}