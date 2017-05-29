class Board{

    int yMovs[] = {-1, -1, 0, 1, 1, 1, 0, -1};
    int xMovs[] = {0, 1, 1, 1, 0, -1, -1, -1};

    char [][] board;
    int whiteTiles;
    int blackTiles;

    Board(){
        board = new char[8][8];
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                board[i][j] = '-';
            }
        }
        board[3][3] = board[4][4] = 'B'; 
        board[3][4] = board[4][3] = 'W';
        updateAmountTiles();
        println("Valid movement: " + isAValidMovement(new Pair(5, 3), 'B'));
    }

    void updateAmountTiles(){
        whiteTiles = blackTiles = 0;
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                whiteTiles += board[i][j] == 'W' ? 1 : 0;
                blackTiles += board[i][j] == 'B' ? 1 : 0;
            }
        }
    }

    void printMatrix(){
        for (int i = 0; i < 8; ++i) {
            for (int j = 0; j < 8; ++j) {
                print(board[i][j]);
            }
            println();
        }
    }

    boolean hasGameFinished(){
        return whiteTiles + blackTiles == 64;
    }

    boolean isAValidMovement(Pair mov, char tile){
        for (int i = 0; i < yMovs.length; ++i) {
            int x = mov.x + xMovs[i];
            int y = mov.y + yMovs[i];
            boolean oppositeTile = false;
            
            while( isAValidCoordinate(x,y) && isAnOppositeTile(tile, board[y][x])){
                oppositeTile = true;
                x += xMovs[i];
                y += yMovs[i];
            }

            if(isAValidCoordinate(x, y) && tile == board[y][x])
                return true;
        }
        return false;
    }

    boolean isAnOppositeTile(char cur, char sub){
        return (cur == 'B' && sub == 'W') || (cur == 'W' && sub == 'B' );
    }

    boolean isAValidCoordinate(int x, int y){
        return x >= 0 && x < 8 && y >= 0 && y < 8;
    }
}