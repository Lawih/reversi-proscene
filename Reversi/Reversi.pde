import remixlab.proscene.*;
import remixlab.bias.event.*;
import remixlab.dandelion.geom.*;

TranslatedBoard graphicBoard;
Scene scene;
Tile tile;
int size = 8;

void setup(){
  size(800, 600, P3D); // window size
  scene = new Scene(this); // create a Scene instance
  scene.setAxesVisualHint(false); // hide axis
  scene.setGridVisualHint(false); // hide grid
  
  graphicBoard = new TranslatedBoard( size );  
  
  scene.camera().setPosition(new Vec(0, 100, 100)); // move the camera
  scene.camera().lookAt(new Vec(0, 0, 0)); // make the camera look at the center of the board
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
  boolean gameHasFinished = graphicBoard.board.hasGameFinished();

  fill(#BBBBBB); 
  // Skipped and player 
  textSize(12); 
  fill(#EEEEEE);
  text("Press 's' to show possible moves, 'n' to start a new game.", 5, height - 5);

  if( gameHasFinished ){
    textSize(30);
    if( graphicBoard.board.whiteTiles > graphicBoard.board.blackTiles ){
      text("White wins!", 5, height - 30);
    }else if( graphicBoard.board.blackTiles > graphicBoard.board.whiteTiles ){
      text("Black wins!", 5, height - 30);
    }else{
      text("It's a tie!", 5, height - 30);
    }
  }else{
    String player = (graphicBoard.player == 'W' ? "White" : "Black");
    text( player + ", you go.", 5, height - 20);
  }
  textSize(20);
  if(graphicBoard.player == 'W' && !gameHasFinished )
    fill(#FADE69);
  text( "White tiles: " + graphicBoard.board.whiteTiles, 5, 20);
  fill(#EEEEEE);
  if(graphicBoard.player == 'B' && !gameHasFinished )
    fill(#FADE69);
  text( "Black tiles: " + graphicBoard.board.blackTiles, 5, 45);
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    graphicBoard.setShowingMoves();
  } else if (key == 'n' || key == 'N') {    
    graphicBoard.clear(); 
  } 
}