public class Tile extends InteractiveFrame {
  private char value; // patch number
  private float size; // patch size in world
  private TranslatedBoard board; // reference to the board containing the patch
  
  public Tile( char value, float size, Scene scene, TranslatedBoard board ){
    super(scene);    
    this.value = value;
    this.size = size;
    this.board = board;
    
    removeBindings();
    disableVisualHint();
    setHighlightingMode(InteractiveFrame.HighlightingMode.NONE);
    setShape("display");
    setClickBinding(LEFT, 1, "play");
  }
  
  public void display(PGraphics pg) {
    pg.pushStyle();
    
    // set the appropriate fill and stroke weight based on the result of grabsMouse()
    if (grabsInput()) {
      pg.fill(0, 97, 6);
      pg.stroke(0, 74, 5);
      pg.strokeWeight(2);
    }
    else{
      pg.fill(0, 156, 10);
    }
    
    // draw patch faces
    float thickness = 6;
    
    pg.beginShape();
    pg.vertex(-getSize() / 2, -getSize() / 2, -thickness);
    pg.vertex(getSize() / 2, -getSize() / 2, -thickness);
    pg.vertex(getSize() / 2, getSize() / 2, -thickness);
    pg.vertex(-getSize() / 2, getSize() / 2, -thickness);
    pg.endShape(CLOSE);
    
    pg.beginShape();
    pg.vertex(-getSize() / 2, -getSize() / 2, 0);
    pg.vertex(-getSize() / 2, getSize() / 2, 0);
    pg.vertex(-getSize() / 2, getSize() / 2, -thickness);
    pg.vertex(-getSize() / 2, -getSize() / 2, -thickness);
    pg.endShape(CLOSE);
    
    pg.beginShape();
    pg.vertex(getSize() / 2, -getSize() / 2, 0);
    pg.vertex(getSize() / 2, getSize() / 2, 0);
    pg.vertex(getSize() / 2, getSize() / 2, -thickness);
    pg.vertex(getSize() / 2, -getSize() / 2, -thickness);
    pg.endShape(CLOSE);
    
    pg.beginShape();
    pg.vertex(-getSize() / 2, -getSize() / 2, 0);
    pg.vertex(getSize() / 2, -getSize() / 2, 0);
    pg.vertex(getSize() / 2, -getSize() / 2, -thickness);
    pg.vertex(-getSize() / 2, -getSize() / 2, -thickness);
    pg.endShape(CLOSE);
    
    pg.beginShape();
    pg.vertex(-getSize() / 2, getSize() / 2, 0);
    pg.vertex(getSize() / 2, getSize() / 2, 0);
    pg.vertex(getSize() / 2, getSize() / 2, -thickness);
    pg.vertex(-getSize() / 2, getSize() / 2, -thickness);
    pg.endShape(CLOSE);
    
    // draw front face
    pg.textureMode(NORMAL);
    pg.beginShape();
        
    pg.vertex(-getSize() / 2, -getSize() / 2, 0);
    pg.vertex(-getSize() / 2, getSize() / 2, 0);
    pg.vertex(getSize() / 2, getSize() / 2, 0);
    pg.vertex(getSize() / 2, -getSize() / 2, 0);
    
    pg.endShape(CLOSE);
       
    
    if( value != '-' ){
      // Check whether it is a white disk or black disk
      if( value == 'W' ){
        pg.fill(255, 255, 255);
        pg.stroke(255, 255, 255);
      }
      else{
        pg.fill(0, 0, 0);
        pg.stroke(0, 0, 0);
      }        
      
      pg.strokeWeight(2);
      
      // Draw disk
      pg.beginShape();
      
      pg.sphere(getSize()/2 - 2);
      
      pg.endShape(CLOSE);
      
    }    
    
    pg.popStyle();
  }

  public void play(ClickEvent event) {
    board.makeMove(this);
    print("Hehe");
  }

  public float getSize() {
    return size;
  }

  public char getValue() {
    return value;
  }

  public void setValue(char value) {
    this.value = value;
  }
  
}