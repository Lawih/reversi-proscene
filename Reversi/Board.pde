class Board{

    int yMovs[] = {-1, -1, 0, 1, 1, 1, 0, -1};
    int xMovs[] = {0, 1, 1, 1, 0, -1, -1, -1};

    char [][] board;
    int whiteTiles;
    int blackTiles;
    int boardSize;

    Board(int size){
        boardSize = size;
        board = new char[boardSize][boardSize];
        for (int i = 0; i < boardSize; ++i) {
            for (int j = 0; j < boardSize; ++j) {
                board[i][j] = '-';
            }
        }

        int initialTile = boardSize / 2;
        board[initialTile - 1][initialTile - 1] = board[initialTile][initialTile] = 'B'; 
        board[initialTile - 1][initialTile] = board[initialTile][initialTile - 1] = 'W';
        updateAmountTiles();
    }

    void updateAmountTiles(){
        whiteTiles = blackTiles = 0;
        for (int i = 0; i < boardSize; ++i) {
            for (int j = 0; j < boardSize; ++j) {
                whiteTiles += board[i][j] == 'W' ? 1 : 0;
                blackTiles += board[i][j] == 'B' ? 1 : 0;
            }
        }
    }

    void printMatrix(){
        for (int i = 0; i < boardSize; ++i) {
            for (int j = 0; j < boardSize; ++j) {
                print(board[i][j]);
            }
            println();
        }
    }

    boolean hasGameFinished(){
        return (whiteTiles + blackTiles == boardSize * boardSize) || (possibleMovements('B').size() == 0 && possibleMovements('W').size() == 0);
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

            if(oppositeTile && isAValidCoordinate(x, y) && tile == board[y][x])
                return true;
        }
        return false;
    }

    boolean makeAMove(Pair mov, char player){
        if(isAValidMovement(mov, player)){
            for (int i = 0; i < yMovs.length; ++i) {
                int x = mov.x + xMovs[i];
                int y = mov.y + yMovs[i];
                boolean oppositeTile = false;
                ArrayList<Pair> toChange = new ArrayList<Pair>();
                toChange.add(mov);
            
                while( isAValidCoordinate(x,y) && isAnOppositeTile(player, board[y][x])){
                    oppositeTile = true;
                    toChange.add(new Pair(x, y));
                    x += xMovs[i];
                    y += yMovs[i];
                }

                if(oppositeTile && isAValidCoordinate(x, y) && player == board[y][x]){
                    for (int j = 0; j < toChange.size(); ++j) {
                        Pair cur = toChange.get(j);
                        board[cur.y][cur.x] = player;
                    }
                }
            }
            return true;
        }
        else{
            return false;
        }
        updateAmountTiles();
    }

    ArrayList<Pair> possibleMovements(char player){
        ArrayList<Pair> result = new ArrayList<Pair>();
        for (int i = 0; i < boardSize; ++i) {
            for (int j = 0; j < boardSize; ++j) {
                Pair cur = new Pair(j, i);
                if (board[i][j] == '-' && isAValidMovement(cur, player)) {
                    result.add(cur);
                }
            }
        }
        return result;
    }

    boolean isAnOppositeTile(char cur, char sub){
        return (cur == 'B' && sub == 'W') || (cur == 'W' && sub == 'B' );
    }

    boolean isAValidCoordinate(int x, int y){
        return x >= 0 && x < boardSize && y >= 0 && y < boardSize;
    }
}