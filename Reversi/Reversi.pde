import remixlab.proscene.*;
import remixlab.bias.event.*;

Board board;
TranslatedBoard graphicBoard;
Scene scene;
Tile tile; 
char player;
int size = 8;

void setup(){
  size(800, 600, P3D); // window size
  scene = new Scene(this); // create a Scene instance
  scene.setAxesVisualHint(false); // hide axis
  scene.setGridVisualHint(false); // hide grid
  
  board = new Board(size);
  player = 'B';
  graphicBoard = new TranslatedBoard( size, board, player );  
}

void draw() {
  background(0);
  lights(); // lights on
  
  spotLight(150, 150, 150, scene.camera().position().x(), scene.camera().position().y(), scene.camera().position().z(), 0, 0, -1, 1, 20);
  spotLight(100, 100, 100, scene.camera().position().x(), scene.camera().position().y(), scene.camera().position().z(), 0, 0, 1, 1, 20);
  
  graphicBoard.update();
  scene.drawFrames();
  scene.beginScreenDrawing();
  drawText();
  scene.endScreenDrawing();
}

public void drawText() {
  fill(#BBBBBB); 
  // Skipped and player 
  textSize(12); 
  fill(#EEEEEE);
  text("Press 's' to show possible moves, 'n' to start a new game, 'p' to show counters, 'q' to increase size, 'w' to decrease size.", 5, height - 5);
  String player = (graphicBoard.player == 'W' ? "White" : "Black");
  text( player + ", you go.", 5, height - 20);
  textSize(20);
  if(graphicBoard.player == 'W')
    fill(#FADE69);
  text( "White tiles: " + board.whiteTiles, 5, 20);
  fill(#EEEEEE);
  if(graphicBoard.player == 'B')
    fill(#FADE69);
  text( "Black tiles: " + board.blackTiles, 5, 45);
}